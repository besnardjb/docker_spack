Description
-----------

A minimal docker image to play with spack.

Integrates a pre-build module env.


Get it
------

```
docker pull jbbesnard/docker_spack
```

Customize
---------

You may use "to_spack" to add new packages to your images

```
FROM jbbesnard/docker_spack
MAINTAINER JB <jbbesnard@paratools.com>

RUN to_spack install git

CMD /bin/bash
```
