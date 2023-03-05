FROM ubuntu:latest

# Updates
RUN apt update -y
RUN apt upgrade -y

# No input
ENV DEBIAN_FRONTEND noninteractive

# things
RUN apt install xfce4 -y
RUN apt install xfce4-goodies -y
RUN apt install tightvncserver -y
RUN apt install novnc websockify -y
RUN apt install curl sudo wget net-tools git -y
RUN apt install python python-pip -y

# user
ARG USER=testuser
ARG PASS=1234

# perms
RUN useradd -m $USER -p $(openssl passwd $PASS) && \
    usermod -aG sudo $USER && \
    chsh -s /bin/bash $USER 

# dir
RUN mkdir /home/$USER/.vnc && \
    echo $PASS | vncpasswd -f > /home/$USER/.vnc/passwd && \
    chmod 0600 /home/$USER/.vnc/passwd && \
    chown -R $USER:$USER /home/$USER/.vnc
 
# start script
COPY start.sh /home/$USER/.vnc/xstartup

# port
EXPOSE 5901

WORKDIR /.novnc
RUN wget -qO- https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz | tar xz --strip 1 -C $PWD
RUN mkdir /.novnc/utils/websockify
RUN wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | tar xz --strip 1 -C /.novnc/utils/websockify
RUN ln -s vnc.html index.html

WORKDIR /home/$USER

# user
USER testuser

# start
CMD echo hi && whoami && USER=testuser vncserver && echo done && /.novnc/utils/launch.sh --listen 6901 --vnc localhost:5901
