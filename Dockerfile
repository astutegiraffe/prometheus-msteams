FROM alpine:3.13

ARG TARGETARCH
ENV TARGETARCH=$TARGETARCH

RUN apk --no-cache add ca-certificates tini 

LABEL description="A lightweight Go Web Server that accepts POST alert message from Prometheus Alertmanager and sends it to Microsoft Teams Channels using an incoming webhook url."

COPY ./default-message-card.tmpl /default-message-card.tmpl
COPY bin/prometheus-msteams-linux-${TARGETARCH} /promteams

ENTRYPOINT ["/sbin/tini", "--", "/promteams"]

EXPOSE 2000
