#!/bin/sh -ex
#
# Quick and dirty replacement for git-buildpackage-rpm
#
# Requires: awk find grep rpmbuild sed tar

PACKAGING_DIR="./packaging"
RPMBUILD_DIR="$HOME/rpmbuild"


copy_sources() {
	SRC_ARCHIVE=$1
	if [ -z "$SRC_ARCHIVE" ]; then
		echo "ERROR: SRC_ARCHIVE is not set"
		exit 3
	fi

	SRC_ARCHIVE_NAME=$(basename "$SRC_ARCHIVE")  # http://.../foo.tar.gz -> foo.tar.gz
	SRC_ARCHIVE_DIR=$(basename "$SRC_ARCHIVE" ".tar.gz")  # foo.tar.gz -> foo

	tar -czf "$RPMBUILD_DIR/SOURCES/$SRC_ARCHIVE_NAME" --exclude='.' --exclude='..' --exclude='.git' --transform="s,^,$SRC_ARCHIVE_DIR/," * .*
	find "$PACKAGING_DIR" -name "*.patch" -exec cp {} "$RPMBUILD_DIR/SOURCES/" \;
}


for DIR in SOURCES SPECS; do
	[ -d "$RPMBUILD_DIR/$DIR" ] || mkdir --parents "$RPMBUILD_DIR/$DIR"
done

for SPEC_FILE in $(ls "$PACKAGING_DIR"/*.spec); do
	PKG_NAME=$(grep '^Name:' "$SPEC_FILE" | awk '{print $2}')
	PKG_VERSION=$(grep '^Version:' "$SPEC_FILE" | awk '{print $2}')
	SRC_ARCHIVE=$(grep '^Source0:' "$SPEC_FILE" | awk '{print $2}' | sed -e "s/%{name}/$PKG_NAME/g" -e "s/%{version}/$PKG_VERSION/g")

	copy_sources "$SRC_ARCHIVE"
	cp "$SPEC_FILE" "$RPMBUILD_DIR/SPECS/"

	rpmbuild -ba "$RPMBUILD_DIR/SPECS/$(basename $SPEC_FILE)"
done
