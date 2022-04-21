FROM ubuntu:20.04

ENV TERRAFORM_VER_14=0.14.11
ENV TERRFORM_VER=1.1.9
ENV PACKER_VER=1.7.10
ENV GCLOUD_VER=382.0.0-0
ENV KUBECTL_VER=1.22.9
ENV PATH=/root/.tfenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN apt-get update && apt-get -y install curl vim python3-minimal openssh-client unzip git apt-transport-https ca-certificates gnupg && apt-get clean
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv && tfenv install $TERRAFORM_VER_14 && tfenv install $TERRAFORM_VER && tfenv use $TERRAFORM_VER_14
RUN curl -s https://releases.hashicorp.com/packer/$PACKER_VER/packer_${PACKER_VER}_linux_amd64.zip -o /tmp/packer.zip && unzip /tmp/packer.zip -d /usr/local/bin && rm -f /tmp/packer.zip
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && apt-get update && apt-get -y install google-cloud-cli=${GCLOUD_VER} && curl -sL https://dl.k8s.io/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl && apt-get clean
ENTRYPOINT /bin/bash
