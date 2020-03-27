# WWT nginx Core Server

This repository contains setup for a backend component of the [AAS]
[WorldWide Telescope] web services.

[AAS]: https://aas.org/
[WorldWide Telescope]: http://worldwidetelescope.org/

In particular, the core WWT website runs an [nginx] web server to handle
miscellaneous redirections and serve certain static files. The
responsibilities of this server are a hodgepodge based on the website's
historical URL routes, since we route incoming requests to different backends
using URL path routing in our [Azure Application Gateway] frontend.

[nginx]: https://www.nginx.com/
[Azure Application Gateway]: https://azure.microsoft.com/en-us/services/application-gateway/


## Building / Installation

This isn't really software that "install" yourself. The output artifact of
this repository is a Docker image that you obtain with the command:

```
docker build -t aasworldwidetelescope/nginx-core:latest .
```

The main purpose of this pipeline is to automate the build and publication of
this image through the `azure-pipelines.yml` file. The image ultimately
emerges as
[aasworldwidetelescope/nginx-core](https://hub.docker.com/repository/docker/aasworldwidetelescope/nginx-core).
A webhook is configured there to update the running service on Azure.


## Contributions

Contributions are welcome! See [the WorldWide Telescope contributors’ guide]
for applicable information. We use a standard workflow with issues and pull
requests. All participants in this repository and the WWT communities must
abide by the [WWT Code of Conduct].

[the WorldWide Telescope contributors’ guide]: https://worldwidetelescope.github.io/contributing/
[WWT Code of Conduct]: https://worldwidetelescope.github.io/code-of-conduct/


## Legalities

The files in this repository are copyright the .NET Foundation, licensed under
the [MIT License](./LICENSE).


## Acknowledgments

`wwt-nginx-core` is part of the AAS WorldWide Telescope system, a
[.NET Foundation] project managed by the non-profit
[American Astronomical Society] (AAS). Work on WWT has been supported by the
AAS, the US [National Science Foundation] (grants [1550701] and [1642446]),
the [Gordon and Betty Moore Foundation], and [Microsoft].

[.NET Foundation]: https://dotnetfoundation.org/
[American Astronomical Society]: https://aas.org/
[National Science Foundation]: https://www.nsf.gov/
[1550701]: https://www.nsf.gov/awardsearch/showAward?AWD_ID=1550701
[1642446]: https://www.nsf.gov/awardsearch/showAward?AWD_ID=1642446
[Gordon and Betty Moore Foundation]: https://www.moore.org/
[Microsoft]: https://www.microsoft.com/
