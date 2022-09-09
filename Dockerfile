FROM alpine:3.16 as builder
ENV KUBEVAL_VERSION=0.16.1 \
    KUBECTL_VERSION=1.25.0

WORKDIR /app

RUN apk add --no-cache \
      curl \
      wget \
      git

RUN wget -q https://github.com/instrumenta/kubeval/releases/download/v${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz \
    && tar xf kubeval-linux-amd64.tar.gz \
    && mv kubeval /usr/local/bin \
    && rm -rf kubeval-linux-amd64.tar.gz

RUN curl -sLf https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

CMD ["kustomize"]

FROM builder as kustomizev4

ENV KUSTOMIZE_VERSION=4.5.7

RUN curl -sLf https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -o kustomize.tar.gz\
    && tar xf kustomize.tar.gz \
    && mv kustomize /usr/local/bin \
    && chmod +x /usr/local/bin/kustomize \
    && rm -rf ./*


FROM builder as kustomizev3

ENV KUSTOMIZE_VERSION=3.10.0

RUN curl -sLf https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -o kustomize.tar.gz\
    && tar xf kustomize.tar.gz \
    && mv kustomize /usr/local/bin \
    && chmod +x /usr/local/bin/kustomize \
    && rm -rf ./*


FROM kustomizev4
