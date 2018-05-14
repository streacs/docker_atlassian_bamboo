# Docker - Atlassian Bamboo

This is a Docker-Image for Atlassian Bamboo based on Debian 9.

## Getting started
Run Atlassian Bamboo standalone and navigate to `http://[dockerhost]:8085` to finish configuration:

```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 8085:8085 -p 54663:54663 streacs/atlassian-bamboo:x.x.x
```

## Environment Variables
* ORACLE_JAVA_EULA
* JVM_ARGUMENTS
* SYSTEM_USER = bamboo
* SYSTEM_GROUP = bamboo
* SYSTEM_HOME = /home/bamboo
* APPLICATION_INST = /opt/atlassian/bamboo
* APPLICATION_HOME = /var/opt/atlassian/application-data/bamboo
* TOMCAT_PROXY_NAME =
* TOMCAT_PROXY_PORT =
* TOMCAT_PROXY_SCHEME =
* TOMCAT_PROXY_SECURE =

## Ports
* 8085 = Default HTTP Connector
* 54663 = Atlassian Bamboo Remote Agent Port

## Volumes
* /var/opt/atlassian/application-data/bamboo

## Oracle end user license agreement
To run this container you have to accept the terms of the Oracle Java end user license agreement.
http://www.oracle.com/technetwork/java/javase/terms/license/index.html

Add following environment variable to your configuration : 
```bash
-e ORACLE_JAVA_EULA=accepted
```

## Source Code
[Github](https://github.com/streacs/docker_atlassian_bamboo)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details