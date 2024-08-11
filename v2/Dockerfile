FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME
ARG PASSWORD

# RUN apt update && apt install -y sudo auditd rsyslog wget curl gnupg

RUN apt update && apt install -y sudo rsyslog wget curl gnupg

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.15.0-amd64.deb && dpkg -i filebeat-8.15.0-amd64.deb && rm filebeat-8.15.0-amd64.deb

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-8.15.0-amd64.deb && dpkg -i auditbeat-8.15.0-amd64.deb && rm auditbeat-8.15.0-amd64.deb

COPY filebeat.yml /etc/filebeat/filebeat.yml

COPY auditbeat.yml /etc/auditbeat/auditbeat.yml

# RUN systemctl enable auditd && systemctl enable rsyslog

# RUN service rsyslog start # this fails


RUN service auditbeat start

RUN service filebeat start

RUN useradd -m -s /bin/bash $USERNAME && echo "$USERNAME:$PASSWORD" | chpasswd && adduser $USERNAME sudo

# AuditD not working in the containers
#RUN mkdir -p /opt/auditing
#COPY setAuditD.sh /opt/auditing/setAuditD.sh
#RUN chmod +x /opt/auditing/setAuditD.sh
#RUN /opt/auditing/setAuditD.sh

CMD ["/bin/bash"]
