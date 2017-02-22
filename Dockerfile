FROM debian:jessie
 
RUN apt-get update && \
  apt-get install -y openssh-server mrtg nano supervisor
 
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
 
RUN mkdir /etc/mrtg && \
  mkdir /var/www/ && mkdir /var/www/mrtg && mkdir /mrtgcfg && \ 
  cfgmaker --global "WorkDir: /var/www/mrtg" \
  --global "RunAsDaemon: Yes" \
  --zero-speed=100000000 \
  --no-down \
  --output="/mrtgcfg/mrtg.cfg" \
  public@192.168.1.1

#COPY mrtg /etc/init.d/mrtg
#RUN chmod +x /etc/init.d/mrtg && chown root:root /etc/init.d/mrtg

#RUN update-rc.d mrtg defaults


# SET ROOT PASSWORD 
RUN echo 'root:screencast' | chpasswd && \
  mkdir /var/run/sshd && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    mkdir /root/.ssh
 
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo 'export LANG="en_US.UTF-8"' >> /etc/profile
 
EXPOSE 22
CMD ["/usr/bin/supervisord"]
