##############################################################################
# Dockerfile to build Atlassian Bamboo container images
# Based on Debian (https://hub.docker.com/r/_/debian/)
##############################################################################

FROM debian:stretch-slim

MAINTAINER Oliver Wolf <root@streacs.com>

ARG APPLICATION_RELEASE

ENV APPLICATION_INST /opt/atlassian/bamboo
ENV APPLICATION_HOME /var/opt/atlassian/application-data/bamboo

ENV SYSTEM_USER bamboo
ENV SYSTEM_GROUP bamboo
ENV SYSTEM_HOME /home/bamboo

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
  && mkdir /usr/share/man/man1

RUN set -x \
  && apt-get update \
  && apt-get -y --no-install-recommends install wget xmlstarlet ca-certificates git ruby-rspec ssh openjdk-8-jdk \
  && gem install serverspec

RUN set -x \
  && addgroup --system ${SYSTEM_GROUP} \
  && adduser --system --home ${SYSTEM_HOME} --ingroup ${SYSTEM_GROUP} ${SYSTEM_USER}

RUN set -x \
  && mkdir -p ${APPLICATION_INST} \
  && mkdir -p ${APPLICATION_HOME} \
  && wget --no-check-certificate -nv -O /tmp/atlassian-bamboo-${APPLICATION_RELEASE}.tar.gz https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${APPLICATION_RELEASE}.tar.gz \
  && tar xfz /tmp/atlassian-bamboo-${APPLICATION_RELEASE}.tar.gz --strip-components=1 -C ${APPLICATION_INST} \
  && chown -R ${SYSTEM_USER}:${SYSTEM_GROUP} ${APPLICATION_INST} \
  && chown -R ${SYSTEM_USER}:${SYSTEM_GROUP} ${APPLICATION_HOME} \
  && rm /tmp/atlassian-bamboo-${APPLICATION_RELEASE}.tar.gz

RUN set -x \
  && apt-get clean \
  && rm -rf /var/cache/* \
  && rm -rf /tmp/*

RUN set -x \
  && touch -d "@0" "${APPLICATION_INST}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties" \
  && touch -d "@0" "${APPLICATION_INST}/bin/setenv.sh" \
  && touch -d "@0" "${APPLICATION_INST}/conf/server.xml"

ADD files/service /usr/local/bin/service
ADD files/entrypoint /usr/local/bin/entrypoint
ADD files/healthcheck /usr/local/bin/healthcheck
ADD rspec-specs ${SYSTEM_HOME}/

VOLUME ${APPLICATION_HOME}

EXPOSE 8085 54663

ENTRYPOINT ["/usr/local/bin/entrypoint"]

USER ${SYSTEM_USER}

WORKDIR ${SYSTEM_HOME}

HEALTHCHECK --interval=5s --timeout=3s CMD /usr/local/bin/healthcheck

CMD ["/usr/local/bin/service"]
