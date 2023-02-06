FROM kasmweb/ubuntu-focal-desktop:1.12.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


RUN touch $HOME/Desktop/hello.txt
RUN cat /etc/kasmvnc/kasmvnc.yaml

RUN apt update -y
RUN apt install python3 curl wget -y

RUN curl https://raw.githubusercontent.com/BasToTheMax/railway-desktop/main/conf.py -o co.yml
RUN mv co.yml /etc/kasmvnc/kasmvnc.yaml

RUN cat /etc/kasmvnc/kasmvnc.yaml

# RUN echo $'network:\n  ssl:\n    require_ssl: false' > ~/.vnc/kasmvnc.yaml


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
