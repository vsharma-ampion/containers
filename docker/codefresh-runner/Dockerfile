FROM alpine

# Arguments with default settings:

# Codefresh CLI Version:
ARG CODEFRESH_CLI_VERSION="v0.75.31"

# Gcloud: https://cloud.google.com/sdk/docs/install
ARG GCLOUD_SDK_VERSION="349.0.0"

# Kubectl:
# https://www.downloadkubernetes.com/
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
ARG KUBECTL_VERSION="v1.21.3"

# Helm
# https://helm.sh/docs/intro/install/
# https://github.com/helm/helm/releases
ARG HELM_VERSION="v3.6.3"

# Vault CLI: https://releases.hashicorp.com/vault/
ARG VAULT_CLI_VERSION="1.7.3"

# Terraform CLI: https://releases.hashicorp.com/terraform/
ARG TERRAFORM_CLI_VERSION="0.13.7"

# Terraform Provider AWS Plugin: https://releases.hashicorp.com/terraform-provider-aws
ARG TERRAFORM_PROVIDER_AWS_VERSION="3.51.0"

# Terraform Provider Google Plugin: https://releases.hashicorp.com/terraform-provider-google
ARG TERRAFORM_PROVIDER_GOOGLE_VERSION="3.76.0"

# Terraform Provider Local Plugin: https://releases.hashicorp.com/terraform-provider-local
ARG TERRAFORM_PROVIDER_LOCAL_VERSION="2.1.0"

# Terraform Provider Null Plugin: https://releases.hashicorp.com/terraform-provider-null/
ARG TERRAFORM_PROVIDER_NULL_VERSION="3.1.0"

# Terraform Provider Random Plugin: https://releases.hashicorp.com/terraform-provider-random/
ARG TERRAFORM_PROVIDER_RANDOM_VERSION="3.1.0"

# Terraform Provider Time Plugin: https://releases.hashicorp.com/terraform-provider-time/
ARG TERRAFORM_PROVIDER_TIME_VERSION="0.7.2"

# Terraform Provider Vault Plugin: https://releases.hashicorp.com/terraform-provider-vault/
ARG TERRAFORM_PROVIDER_VAULT_VERSION="2.22.0"

# Terraform Provider Codefresh Plugin: https://github.com/codefresh-io/terraform-provider-codefresh/releases
ARG TERRAFORM_PROVIDER_CODEFRESH_VERSION="0.0.19"

# Environment Settings:
ENV PATH=/google-cloud-sdk/bin:/codefresh:${PATH}
ENV TF_INPUT=false
ENV TF_CLI_CONFIG_FILE=/terraform/.terraformrc

ENV TERRAFORM_DIR=/terraform
ENV TERRAFORM_PLUGINS_DIR=${TERRAFORM_DIR}/plugins
ENV TERRAFORM_PLUGINS_CACHE_DIR=${TERRAFORM_DIR}/plugins-cache
ENV TF_PLUGIN_CACHE_DIR=${TERRAFORM_DIR}/plugins-cache

# Install Updates:
RUN apk update && \
    apk upgrade

# Install Packages:
RUN apk add --update \
    bash \
    openssl \
    curl \
    ca-certificates \
    bind-tools \
    python3 \
    py3-pip \
    py3-crcmod \
    py3-openssl \
    libc6-compat \
    openssh-client \
    jq \
    make \
    git \
    gnupg \
    tree

# Change shell to bash:
SHELL ["/bin/bash", "-c"]

# Install Codefresh CLI:
RUN mkdir /codefresh && \
    curl -LJo /codefresh/codefresh-${CODEFRESH_CLI_VERSION}-alpine-x64.tar.gz https://github.com/codefresh-io/cli/releases/download/${CODEFRESH_CLI_VERSION}/codefresh-${CODEFRESH_CLI_VERSION}-alpine-x64.tar.gz && \
    tar xzf /codefresh/codefresh-${CODEFRESH_CLI_VERSION}-alpine-x64.tar.gz -C /codefresh && \
    rm -Rf /codefresh/codefresh-${CODEFRESH_CLI_VERSION}-alpine-x64.tar.gz

# Install GCloud with Kubectl:
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm -Rf google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    /google-cloud-sdk/install.sh --usage-reporting false --path-update true --additional-components kubectl --quiet && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image
    
# Install Python3 Packages:
# References:
# https://googleapis.dev/python/google-auth/latest/index.html
# https://aws.amazon.com/sdk-for-python/
RUN pip3 install --upgrade \
    awscli \
    google-auth \
    yq

# Install Helm:
RUN curl -O https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    tar xzf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    mv /linux-amd64/helm /usr/local/bin/helm && \
    rm -Rf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    rm -Rf /linux-amd64

# Install Vault CLI:
RUN curl -O https://releases.hashicorp.com/vault/${VAULT_CLI_VERSION}/vault_${VAULT_CLI_VERSION}_linux_amd64.zip && \
    unzip vault_${VAULT_CLI_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    rm -Rf vault_${VAULT_CLI_VERSION}_linux_amd64.zip

# Install Terraform CLI:
RUN curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_CLI_VERSION}/terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    rm -Rf terraform_${TERRAFORM_CLI_VERSION}_linux_amd64.zip

# Terraform Provider Plugins:
RUN mkdir -p ${TERRAFORM_PLUGINS_CACHE_DIR} && \
    mkdir -p ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/aws && \
    curl -o ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/aws/terraform-provider-aws_${TERRAFORM_PROVIDER_AWS_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform-provider-aws/${TERRAFORM_PROVIDER_AWS_VERSION}/terraform-provider-aws_${TERRAFORM_PROVIDER_AWS_VERSION}_linux_amd64.zip && \
    mkdir -p ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/google && \
    curl -o ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/google/terraform-provider-google_${TERRAFORM_PROVIDER_GOOGLE_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform-provider-google/${TERRAFORM_PROVIDER_GOOGLE_VERSION}/terraform-provider-google_${TERRAFORM_PROVIDER_GOOGLE_VERSION}_linux_amd64.zip && \
    mkdir -p ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/local && \
    curl -o ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/local/terraform-provider-local_${TERRAFORM_PROVIDER_LOCAL_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform-provider-local/${TERRAFORM_PROVIDER_LOCAL_VERSION}/terraform-provider-local_${TERRAFORM_PROVIDER_LOCAL_VERSION}_linux_amd64.zip && \
    mkdir -p ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/null && \
    curl -o ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/null/terraform-provider-null_${TERRAFORM_PROVIDER_NULL_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform-provider-null/${TERRAFORM_PROVIDER_NULL_VERSION}/terraform-provider-null_${TERRAFORM_PROVIDER_NULL_VERSION}_linux_amd64.zip && \
    mkdir -p ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/random && \
    curl -o ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/random/terraform-provider-random_${TERRAFORM_PROVIDER_RANDOM_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform-provider-random/${TERRAFORM_PROVIDER_RANDOM_VERSION}/terraform-provider-random_${TERRAFORM_PROVIDER_RANDOM_VERSION}_linux_amd64.zip && \
    mkdir -p ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/time && \
    curl -o ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/time/terraform-provider-time_${TERRAFORM_PROVIDER_TIME_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform-provider-time/${TERRAFORM_PROVIDER_TIME_VERSION}/terraform-provider-time_${TERRAFORM_PROVIDER_TIME_VERSION}_linux_amd64.zip && \
    mkdir -p ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/vault && \
    curl -o ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/hashicorp/vault/terraform-provider-vault_${TERRAFORM_PROVIDER_VAULT_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform-provider-vault/${TERRAFORM_PROVIDER_VAULT_VERSION}/terraform-provider-vault_${TERRAFORM_PROVIDER_VAULT_VERSION}_linux_amd64.zip && \
    mkdir -p ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/codefresh-io/codefresh && \
    curl -LJo ${TERRAFORM_PLUGINS_DIR}/registry.terraform.io/codefresh-io/codefresh/terraform-provider-codefresh_${TERRAFORM_PROVIDER_CODEFRESH_VERSION}_linux_amd64.zip https://github.com/codefresh-io/terraform-provider-codefresh/releases/download/${TERRAFORM_PROVIDER_CODEFRESH_VERSION}/terraform-provider-codefresh_${TERRAFORM_PROVIDER_CODEFRESH_VERSION}_linux_amd64.zip

# Terraform Config File Settings:
RUN echo "plugin_cache_dir = \"${TERRAFORM_PLUGINS_CACHE_DIR}\"" > ${TF_CLI_CONFIG_FILE} && \
    echo "provider_installation {" >> ${TF_CLI_CONFIG_FILE} && \
    echo "  filesystem_mirror {" >> ${TF_CLI_CONFIG_FILE} && \
    echo "    path = \"${TERRAFORM_PLUGINS_DIR}\"" >> ${TF_CLI_CONFIG_FILE} && \
    echo "  }" >> ${TF_CLI_CONFIG_FILE} && \
    echo "}" >> ${TF_CLI_CONFIG_FILE}

# Version Checks:
    RUN which codefresh && \
        which gcloud && gcloud --version && \
        which kubectl && kubectl version --client && \
        which aws && aws --version && \
        which helm && helm version && \
        which vault && vault --version && \
        which terraform && terraform --version

# Cleanup uncessary files
RUN rm /var/cache/apk/* && rm -rf /tmp/*

WORKDIR /workspace
