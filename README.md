# Docker - Atlassian Bamboo

This is a Docker-Image for Atlassian Bamboo based on Debian 9.

## Getting started
Run Atlassian Bamboo standalone and navigate to `http://[dockerhost]:8085` to finish configuration:

```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 8085:8085 -p 54663:54663 streacs/atlassian-bamboo:x.x.x
```

## Environment Variables
* (M) ORACLE_JAVA_EULA = accepted
* (O) JVM_ARGUMENTS =
* (I) SYSTEM_USER = bamboo
* (I) SYSTEM_GROUP = bamboo
* (I) SYSTEM_HOME = /home/bamboo
* (I) APPLICATION_INST = /opt/atlassian/bamboo
* (I) APPLICATION_HOME = /var/opt/atlassian/application-data/bamboo
* (O) TOMCAT_PROXY_NAME = www.example.com
* (O) TOMCAT_PROXY_PORT = 80|443
* (O) TOMCAT_PROXY_SCHEME = http|https
* (O) TOMCAT_PROXY_SECURE = false|true
* (O) JVM_MEMORY_MIN = 1024m
* (O) JVM_MEMORY_MAX = 2048m

(M) = Mandatory / (O) = Optional / (I) Information 

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

## Examples

Modify JVM memory
```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 8085:8085 -p 54663:54663 -e JVM_MEMORY_MIN=1024m -e JVM_MEMORY_MAX=2048m streacs/atlassian-bamboo:x.x.x
```

Persist application data
```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 8085:8085 -p 54663:54663 -v BAMBOO-DATA:/var/opt/atlassian/application-data/bamboo streacs/atlassian-bamboo:x.x.x
```

## Databases

This image doesn't include the MySQL JDBC driver.
Please use PostgreSQL.

## Source Code
[Github](https://github.com/streacs/docker_atlassian_bamboo)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details