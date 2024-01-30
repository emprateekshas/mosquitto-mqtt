#!/bin/sh
### Latest Approved Mosquitto Instance

# ---- Mosquitto Instance ----
FROM eclipse-mosquitto:latest AS mosquitto

#RUN mkdir -p /run/secrets/
RUN --mount=type=secret,id=MTC_PASSWD,target=/run/secrets/MTC_PASSWD \
    --mount=type=secret,id=MTC_USRNAME,target=/run/secrets/MTC_USRNAME \
    mosquitto_passwd -c -b /mosquitto/data/passwd "$(cat /run/secrets/MTC_USRNAME)" "$(cat /run/secrets/MTC_PASSWD)"

RUN --mount=type=secret,id=MTC_ODS_PASSWD,target=/run/secrets/MTC_ODS_PASSWD \
    --mount=type=secret,id=MTC_ODS_USRNAME,target=/run/secrets/MTC_ODS_USRNAME \
    mosquitto_passwd -c -b /mosquitto/data/passwd "$(cat /run/secrets/MTC_ODS_USRNAME)" "$(cat /run/secrets/MTC_ODS_PASSWD)"

VOLUME ["/mosquitto/data", "/mosquitto/log"]
EXPOSE 1883
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]

### EOF
