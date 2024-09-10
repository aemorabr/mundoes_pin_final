#!/bin/bash

export AWS_REGION="us-east-1"
export ACCOUNT_ID="975050077248"
export ES_DOMAIN_NAME="eksworkshop-logging"
export ES_VERSION="Elasticsearch_7.10"
export ES_DOMAIN_USER="eksworkshop"
export ES_DOMAIN_PASSWORD="$(openssl rand -base64 12)_Ek1$"

# OIDC del cluster de elasticsearch
#
eksctl utils associate-iam-oidc-provider --cluster eks-mundos-e  --approve