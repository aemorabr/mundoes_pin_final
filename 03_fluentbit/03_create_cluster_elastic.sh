
export AWS_REGION="us-east-1"
export ACCOUNT_ID="975050077248"
export ES_DOMAIN_NAME="eksworkshop-logging"
export ES_VERSION="Elasticsearch_7.10"
export ES_DOMAIN_USER="eksworkshop"
export ES_DOMAIN_PASSWORD="$(openssl rand -base64 12)_Ek1$"
# # Download and update the template using the variables created previously
# cat opensearch-domain-skeleton.json | envsubst > es-domain.json
# # Create the cluster
# aws opensearch create-domain \
#   --cli-input-json  file://es-domain.json

# # Comprobar si se desplego
# #
if [ $(aws es describe-elasticsearch-domain --domain-name "${ES_DOMAIN_USER}" --query 'DomainStatus.Processing') == "false" ]; then tput setaf 2; echo "The Elasticsearch cluster is ready"; else tput setaf 1;echo "The Elasticsearch cluster is NOT
ready"; fi