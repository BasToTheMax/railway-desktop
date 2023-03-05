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
COPY ./start.sh /home/$USER/.vnc/xstartup

# port
EXPOSE 5901

# start
CMD echo hi && whoami && bash
