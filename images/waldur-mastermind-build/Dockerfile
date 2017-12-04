FROM centos:7

COPY my-buildpackage-rpm.sh /usr/local/bin/my-buildpackage-rpm

RUN yum --assumeyes install epel-release && \
    yum --assumeyes update && \
    yum --assumeyes install rpm-build rpmlint tar yum-utils && \
    yum clean all && \
    chmod +x /usr/local/bin/my-buildpackage-rpm
