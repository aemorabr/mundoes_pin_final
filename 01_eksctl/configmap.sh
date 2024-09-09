#!/bin/bash

kubectl edit -n kube-system configmap/aws-auth

#  mapUsers: |
#    - groups:
#    - system:masters
#      userarn:  arn:aws:iam::975050077248:user/aws_user
#      username: aws_user 