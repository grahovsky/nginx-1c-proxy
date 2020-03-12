FROM centos:centos7
#MAINTAINER "grahovsky" <grahovsky@gmail.com>

# install epel
RUN yum -y update; yum -y install epel-release; yum clean all

# create user with specific id for okd
ENV OKD_USER_ID 1001080000
RUN groupadd -f --gid $OKD_USER_ID nginx && \
    useradd --uid $OKD_USER_ID --gid $OKD_USER_ID --comment 'Nginx web server' --no-log-init --home-dir /home/nginx nginx

# install dependences
RUN yum -y update ; \
    yum -y install nginx ; \
    yum clean all


# set rootpass for debug
RUN echo 'root' | passwd root --stdin

#Environment Variables
ARG AGENT_PORT=1540
ENV AGENT_PORT=$AGENT_PORT

ARG MANAGER_PORT=1541
ENV MANAGER_PORT=$MANAGER_PORT

ARG RAS_PORT=1541
ENV RAS_PORT=$RAS_PORT

ARG RANGE_PORT_START=1560
ENV RANGE_PORT_START=$RANGE_PORT_START

ARG RANGE_PORT_END=1591
ENV RANGE_PORT_END=$RANGE_PORT_END

# expose ports
EXPOSE $AGENT_PORT $MANAGER_PORT $RASPORT $RANGE_PORT_START-$RANGE_PORT_END

# add permissions
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    chown -R nginx:nginx /var/log/nginx && \
    chmod 777 -R /etc/nginx

USER nginx

ADD nginx.conf /etc/nginx/
ADD entrypoint.sh /tmp/

ENTRYPOINT ["/bin/bash", "-x", "/tmp/entrypoint.sh"]
#CMD ["/bin/bash"]
CMD ["nginx", "-g", "daemon off;"]
