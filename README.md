# GlassFish 3

[![](https://images.microbadger.com/badges/image/ucalgary/glassfish:3.1.2.2.svg)](https://microbadger.com/images/ucalgary/glassfish:3.1.2.2)

GlassFish is an open-source application server project started by Sun Microsystems for the Java EE platform and now sponsored by Oracle Corporation. The supported version is called Oracle GlassFish Server. GlassFish is free software, dual-licensed under two free software licences: the Common Development and Distribution License (CDDL) and the GNU General Public License (GPL) with the classpath exception.

This repository provides Docker images for GlassFish 3.1.2.2 only. For GlassFish 4 images, see the official [glassfish](https://hub.docker.com/_/glassfish/) image (deprecated), [glassfish/server](https://hub.docker.com/r/glassfish/server/), or [oracle/glassfish](https://hub.docker.com/r/oracle/glassfish/).

## Starting GlassFish Server

```
$ docker run -d ucalgary/glassfish
```

This image calls `asadmin start-domain --verbose` to start the default GlassFish domain as its command. By specifying `--verbose`, the domain is started as a foreground process, with logs outputted to `stdout` and `stderr`. Stopping a running container will stop the Domain Adminisration Server (DAS).

## Setting the `admin` User Password and Enabling Secure Admin

The `admin` user has a default password that is empty. To change the password when the container starts, set a value for the `AS_ADMIN_PASSWORD` environment variable. The container's entrypoint script will call `asadmin change-admin-password` to set the admin user's password.

```
$ docker run --env AS_ADMIN_PASSWORD=abcd1234 -d ucalgary/glassfish
```

Once an admin password is set, secure admin can be enabled to enable remote administration and encrypt all admin traffic. If `AS_ADMIN_ENABLE_SECURE` environment variable should be set to a non-empty value, the entrypoint script will call `asadmin enable-secure-admin` after setting the admin password. The image includes `EXPOSE 4848` for access to the remote admin port.

```
$ docker run --env AS_ADMIN_PASSWORD=abcd1234 --env AS_ADMIN_ENABLE_SECURE=1 \
-p 4848:4848 -d ucalgary/glassfish
```

## Maintenance

This image is currently maintained by the Research Management Systems project at the [University of Calgary](http://www.ucalgary.ca/). It is used to support specific applications requiring GlassFish 3.1.2.2 and will not be upgraded to GlassFish 4 or beyond.
