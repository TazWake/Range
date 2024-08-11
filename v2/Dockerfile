FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME
ARG PASSWORD

RUN apt-get update && apt-get install -y sudo auditd rsyslog wget curl gnupg

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.15.0-amd64.deb && dpkg -i filebeat-8.15.0-amd64.deb && rm filebeat-8.15.0-amd64.deb

RUN systemctl enable auditd && systemctl enable rsyslog

RUN useradd -m -s /bin/bash $USERNAME && echo "$USERNAME:$PASSWORD" | chpasswd && adduser $USERNAME sudo

RUN mkdir -p /opt/auditing

COPY setAuditD.sh /opt/auditing/setAuditD.sh
RUN chmod +x /opt/auditing/setAuditD.sh
RUN /opt/auditing/setAuditD.sh

COPY filebeat.yml /etc/filebeat/filebeat.yml

CMD ["/bin/bash"]
