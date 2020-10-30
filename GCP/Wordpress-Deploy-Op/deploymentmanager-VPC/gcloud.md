# use us-east1 region and us-east1-b zone

gcloud config configurations list
gcloud config configurations activate  ()

## gcloud config list
[compute]
region = us-central1
zone = us-central1-a
[core]
account = dev@we-sense.org
disable_usage_reporting = False
project = product1-dev-1018

gcloud config set account dev@we-sense.org
gcloud config set project product1-dev-1018
gcloud config set compute/zone us-east1-b
gcloud config set compute/region us-east1

## Managed Instance Group 
gcloud compute instance-groups managed delete advanced-configuration-frontend-igm

#
gcloud sql connect  mysql-xy1-8  --user=root

# setup kubectl
gcloud container clusters get-credentials griffin-dev --zone us-east1-b --project product1-dev-1018

gcloud iam service-accounts keys create key.json \
    --iam-account=cloud-sql-proxy@product1-dev-1018.iam.gserviceaccount.com

kubectl create secret generic cloudsql-instance-credentials \
    --from-file key.json


 gcloud compute instances create vm-griffin-3subnets --zone us-east1-b --machine-type=n1-standard-4 \
    --network-interface '' \
    --network-interface subnet=griffin-dev-mgmt \
    --network-interface subnet=griffin-prod-mgmt,no-address