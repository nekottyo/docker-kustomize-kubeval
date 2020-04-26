FROM alpine:3.10
ENV KUBEVAL_VERSION=0.15.0 \
    KUBECTL_VERSION=1.18.2 \
    KUSTOMIZE_VERSION=3.5.4

WORKDIR /app

RUN apk add --no-cache \
      curl \
      wget \
      git

RUN wget -q https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz \
    && tar xf kubeval-linux-amd64.tar.gz \
    && mv kubeval /usr/local/bin \
    && rm -rf kubeval-linux-amd64.tar.gz

RUN curl -sLf https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN curl -sLf https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -o kustomize.tar.gz\
    && tar xf kustomize.tar.gz \
    && mv kustomize /usr/local/bin \
    && chmod +x /usr/local/bin/kustomize \
    && rm -rf ./*

CMD ["kustomize"]
