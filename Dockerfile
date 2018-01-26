FROM centos:7
MAINTAINER Jean-Baptiste BESNARD <jbbesnard@paratools.fr>
#Basics
RUN yum -y update \
&& yum -y install python git curl bc which bzip2
#Build Deps
RUN yum -y install make patch gcc gcc-c++ gcc-gfortran
#Deploy Spack
RUN cd /opt \
&& git clone https://github.com/spack/spack.git \
&& echo ". /opt/spack/share/spack/setup-env.sh" > /etc/profile.d/101-spack.sh \
&& chmod +x /etc/profile.d/101-spack.sh
#Deploy ENV helper
RUN echo '#!/bin/sh' > /bin/to_spack &&\
    echo '. /opt/spack/share/spack/setup-env.sh' >> /bin/to_spack &&\
    echo 'spack $@' >> /bin/to_spack && \
    chmod +x /bin/to_spack
#Install initial env
RUN to_spack install environment-modules
#This is to allow build as root of some packages (TAR for example)
ENV FORCE_UNSAFE_CONFIGURE=1
#
# You may use "to_spack" as spack in following CMD
#
CMD /bin/bash
