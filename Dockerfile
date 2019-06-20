FROM alpine:3.8
ENV KUBEVAL_VERSION=0.10.0 \
    KUBECTL_VERSION=1.15.0 \
    KUSTOMIZE_VERSION=2.1.0

WORKDIR /app

RUN apk add --no-cache \
      curl \
      wget \
      git

RUN wget https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz \
    && tar xf kubeval-linux-amd64.tar.gz \
    && mv kubeval /usr/local/bin \
    && rm -rf kubeval-linux-amd64.tar.gz

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize

CMD ["kustomize"]
