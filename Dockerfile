FROM ubuntu:latest

RUN apt update -y
RUN apt upgrade -y

RUN apt install xfce4 -y
RUN apt install xfce4-goodies -y
RUN apt install tightvncserver -y

CMD bash
