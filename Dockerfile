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

CMD bash
