#!/bin/sh
### Latest Approved Mosquitto Instance

# ---- Mosquitto Instance ----
FROM eclipse-mosquitto:latest AS mosquitto


RUN --mount=type=secret,id=mtc_passwd,target=/run/secrets/mtc_passwd \
     TOKEN=$(cat /run/secrets/mtc_passwd) 
     
RUN mosquitto_passwd -b /mosquitto/data/passwd mtconnect $TOKEN

VOLUME ["/mosquitto/data", "/mosquitto/log"]
EXPOSE 1883
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]

### EOF

