FROM alpine:latest
RUN adduser kustomize -D \
  && apk add curl git openssh \
  && git config --global url.ssh://git@github.com/.insteadOf https://github.com/
RUN  curl -L --output /tmp/kustomize_v4.5.7_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.7/kustomize_v4.5.7_linux_amd64.tar.gz \
  && echo "701e3c4bfa14e4c520d481fdf7131f902531bfc002cb5062dcf31263a09c70c9 /tmp/kustomize_v4.5.7_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_v4.5.7_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && mkdir ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
USER kustomize
WORKDIR /src
