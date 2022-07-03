[ ![Docker](https://img.shields.io/badge/Docker%20Image-309DEE?style=for-the-badge&logo=docker&logoColor=white) ](https://hub.docker.com/r/jack20191124/nginx)
[ ![License Badge](https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white) ](https://www.apache.org/licenses/LICENSE-2.0)
[ ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/QubitPi/jupiter/Nginx%20CI/nginx?logo=github&style=for-the-badge) ](https://github.com/QubitPi/jupiter/actions/workflows/nginx-ci.yml)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/QubitPi/jupiter/nginx?logo=github&style=for-the-badge)

Nginx Docker Image
==================

![NGINX-logo-rgb-large](https://user-images.githubusercontent.com/16126939/177058657-1943c105-4d76-41b3-bfc8-9fa9654da213.png)

[Nginx](https://nginx.org/) is a server that powerfully supports highly concurrent request processing. Nginx is very 
popular because it

* offers highly concurrent and high-performance request processing
* is very extensible due to its modular design which makes it possible to develop eco-systems on top of Nginx (e.g. 
  [OpenResty](https://openresty.org/en/))
* provides high availability (runs several years, 99.99%+ available)
* allows hot deployments
* is open source(BSD license)

Nginx is a excellent choice for

1. Serving static resource access
2. [Reverse Proxy](https://nginx.org/en/docs/http/ngx_http_upstream_module.html)
   a. Load balancing
   b. Caching static or semi-static resources for faster request processing
3. Hosting web app(e.g. OpenResty) for some database API access (accessing DB directory from Nginx gives better 
   performance in some cases as Nginx has powerful multi-requests processing capabilities)

Get Image
---------

### Docker Hub

You can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/nginx/):

    docker pull jack20191124/nginx

### GitHub

You could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/nginx/):

    git clone https://github.com/QubitPi/jupiter.git
    cd jupiter
    git checkout nginx
    docker build -t jack20191124/nginx .

Standup a Container
-------------------

Once image is on your machine(either by pulling or building), you can standup a nginx instance.

    docker run -d --name=nginx -it -p 80:80 jack20191124/nginx /etc/init.sh -bash

If visiting localhost:80 shows the following, your container is up and running properly:

```
Welcome to nginx!

If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.
```

Create a Static Resource Web Server
-----------------------------------

The container of this image can be used as Nginx instance that serves static resources, which is one of the main features 
of Nginx. For example, to spin up a container named "nginx" that serves static resources under a directory called
`static`:

    docker create --name=nginx -it -p 80:80 jack20191124/nginx /etc/init.sh -bash
    docker cp static/* nginx:/usr/local/nginx/html/
    docker start nginx
    
The 1st command creates the container; the 2nd command copies all files under `./static` directory into the container 
before starting the container using the 3rd command. Note that the files in `static` in the container are under 
`/usr/local/nginx/html/index.html` in the container. You could see them by either hitting localhost:80 on your host 
machine's browser or enter the container and see them using `docker exec -it nginx bash`

This images comes with default static resource, which is a single-line html file "This is a default static resource
file" (see localhost:80 or `static/index.html` in this distribution).

Note that by default this image does not
[compress the static resources](https://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip) or enable
[auto-index](https://nginx.org/en/docs/http/ngx_http_autoindex_module.html) but nothing stops them from being supported
in container.

Visualizing access.log
----------------------

Access log contains important information about Nginx runtime. We can use it to debug and analyze server usage data.
This image supports realtime analysis of access log via [GoAccess](https://goaccess.io/).

Once container starts, you can visualize access log at http://localhost/access.html
    
SSL Certificate
---------------

This image is designed to work in production environment. If you would like to support HTTPS protocol, you can generate
SSL certificate using the pre-installed certbot(`python-certbot-nginx`) utilities:

    certbot --nginx --nginx-server-root=/usr/local/nginx/conf/ -d <domain name>

License
-------

The use and distribution terms for this software are covered by the Apache License, Version 2.0
(http://www.apache.org/licenses/LICENSE-2.0.html).
