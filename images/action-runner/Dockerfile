# Use a base image that includes basic tools
FROM summerwind/actions-runner:latest

USER root

#yq
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# kubectl
RUN curl -L -O "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x kubectl
RUN install kubectl /usr/local/bin/
RUN kubectl version --client

# setup sops for helm secrets
RUN curl "https://github.com/mozilla/sops/releases/download/3.0.3/sops_3.0.3_amd64.deb" -o /tmp/sops
RUN curl -sL "https://github.com/mozilla/sops/releases/download/3.0.3/sops-3.0.3.linux" > /tmp/sops
RUN chmod +x /tmp/sops && mv /tmp/sops /usr/local/bin/

# helm3
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | BINARY_NAME=helm3 bash \
    && chmod +x /usr/local/bin/helm3
RUN cp /usr/local/bin/helm3 /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

# helmfile
RUN wget https://github.com/roboll/helmfile/releases/download/v0.140.0/helmfile_linux_amd64 -O /usr/bin/helmfile && chmod +x /usr/bin/helmfile

RUN helm3 plugin install https://github.com/databus23/helm-diff
RUN helm3 plugin install https://github.com/chartmuseum/helm-push
RUN helm3 plugin install --version=2.0.1 https://github.com/dcasadevall/helm-secrets

USER runner