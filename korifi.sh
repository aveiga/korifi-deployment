#!/bin/bash

source ./globals.sh
source ./creds.sh

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: $ROOT_NAMESPACE
  labels:
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/enforce: restricted
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: $KORIFI_NAMESPACE
EOF

kubectl --namespace "$ROOT_NAMESPACE" create secret docker-registry image-registry-credentials \
    --docker-username="$DOCKER_USERNAME" \
    --docker-password="$DOCKER_PASSWORD" \
    --docker-server="https://index.docker.io/v1/"

helm upgrade --install korifi https://github.com/cloudfoundry/korifi/releases/download/v0.4.0/korifi-0.4.0.tgz \
    --namespace="$KORIFI_NAMESPACE" \
    --set=global.generateIngressCertificates=true \
    --set=global.rootNamespace="$ROOT_NAMESPACE" \
    --set=adminUserName="$ADMIN_USERNAME" \
    --set=api.apiServer.url="api.$BASE_DOMAIN" \
    --set=global.defaultAppDomainName="apps.$BASE_DOMAIN" \
    --set=api.packageRepositoryPrefix=index.docker.io/aveiga \
    --set=kpack-image-builder.builderRepository=index.docker.io/aveiga/korifi/kpack-builder \
    --set=kpack-image-builder.dropletRepositoryPrefix=index.docker.io/aveiga/korifi/droplets