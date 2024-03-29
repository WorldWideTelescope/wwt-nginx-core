[![Build Status](https://dev.azure.com/aasworldwidetelescope/WWT/_apis/build/status/WorldWideTelescope.wwt-nginx-core?branchName=master)](https://dev.azure.com/aasworldwidetelescope/WWT/_build/latest?definitionId=7&branchName=master)

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

This server also has vhosts configured to serve up a few special-purpose
domains with extremely limited functionality, e.g. redirecting the old
`forum.worldwidetelescope.org` to [wwt-forum.org](https://wwt-forum.org/).


## Building / Installation

This isn't really software that "install" yourself. The output artifact of
this repository is a Docker image that you obtain with the command:

```
docker build -t aasworldwidetelescope/nginx-core:latest .
```

You can then run the server locally with a command such as:

```
docker run --rm -p 8888:80 aasworldwidetelescope/nginx-core:latest
```

but you'll need to manually telnet in HTTP requests to get anything to work due
to the vhost configuration. E.g.,

```
$ telnet localhost 8888
GET /support/wwtsetup-latest.msi HTTP/1.1
Host: worldwidetelescope.org

HTTP/1.1 302 Moved Temporarily
Server: nginx/1.16.1
...
```

The main purpose of this pipeline is to automate the build and publication of
this image through the `azure-pipelines.yml` file. The image ultimately
emerges as
[aasworldwidetelescope/nginx-core](https://hub.docker.com/repository/docker/aasworldwidetelescope/nginx-core).
A webhook is configured there to update the running service on Azure.

The live servers are run as virtual hosts as Azure App Services behind an
Azure Application Gateway. Because they are run as vhosts, each request must
be passed the correct HTTP `Host` header, pointing to something like
`wwtnginxcore-prod.azurewebsites.net`. However, that means that if this server
issues redirects, by default they will point to the App Service domain name,
not the actual `worldwidetelescope.org` domain. App Gateway doesn't seem to
provide a facility for us to correctly rewrite any outgoing `Location` headers
from the App Service, so we instead provide a mechanism to make sure that the
emitted URLs point to the intended domain. If the environment variable
`PUBLIC_FACING_DOMAIN_NAME` is set, redirection URLs will be rooted
accordingly, with the scheme determined from a `X-Forwarded-Proto` HTTP header
if available.


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
