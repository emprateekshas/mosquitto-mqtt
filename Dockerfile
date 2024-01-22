#!/bin/sh
### Latest Approved Mosquitto Instance

# ---- Mosquitto Instance ----
FROM eclipse-mosquitto:latest AS mosquitto

#RUN --mount=type=secret,id=mtc_password mosquitto_passwd -c -b /mosquitto/data/passwd mtconnect $(cat /run/secrets/mtc_password)
#ARG MTC_PASSWORD

#RUN --mount=type=secret,id=MTC_PASSWD \
#    mosquitto_passwd -c -b /mosquitto/data/passwd mtconnect ${MTC_PASSWORD}

RUN --mount=type=secret,id=MTC_PASSWD MTC_PASSWD=$(cat /run/secrets/MTC_PASSWD)
RUN mosquitto_passwd -c -b /mosquitto/data/passwd mtconnect $MTC_PASSWD

VOLUME ["/mosquitto/data", "/mosquitto/log"]
EXPOSE 1883
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]

### EOF
