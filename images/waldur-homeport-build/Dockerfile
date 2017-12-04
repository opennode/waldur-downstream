FROM centos:7

RUN yum --assumeyes install epel-release https://rpm.nodesource.com/pub_8.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm && \
    yum --assumeyes update ; \
    yum --assumeyes install tar bzip2 fontconfig gcc git nodejs && \
    yum clean all && \
    npm install -g yarn
