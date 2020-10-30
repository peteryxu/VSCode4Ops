# Init
gloud init

Your project default Compute Engine zone has been set to [us-central1-a].
You can change it by running [gcloud config set compute/zone NAME].

Your project default Compute Engine region has been set to [us-central1].
You can change it by running [gcloud config set compute/region NAME].

Your Google Cloud SDK is configured and ready to use!

* Commands that require authentication will use dev@we-sense.org by default
* Commands will reference project `product1-dev-1018` by default
* Compute Engine commands will use region `us-central1` by default
* Compute Engine commands will use zone `us-central1-a` by default

Run `gcloud help config` to learn how to change individual settings

This gcloud configuration is called [product1-dev-1018]. You can create additional configurations if you work with multiple accounts and/or projects.
Run `gcloud topic configurations` to learn more.


gcloud --help
gcloud topic --help
gcloud topic configurations


# check current config:  Active account
gcloud config set account `ACCOUNT`
gcloud config set project [PROJECT_ID]
gcloud config set compute/zone us-central1-a


gcloud auth list
gcloud config list project
gcloud compute zones list




# VPC
gcloud compute networks create managementnet --project=qwiklabs-gcp-03-e1cf829478ae --description=managementnet --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-03-e1cf829478ae --range=10.130.0.0/20 --network=managementnet --region=us-central1

gcloud compute networks list

gcloud compute networks subnets list --sort-by=NETWORK

# Firewall
gcloud compute firewall-rules list --sort-by=NETWORK

gcloud compute --project=qwiklabs-gcp-03-e1cf829478ae firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389,icmp --source-ranges=0.0.0.0/0

# VM
gcloud compute instances create privatenet-us-vm --zone=us-central1-c --machine-type=n1-standard-1 --subnet=privatesubnet-us

gcloud compute instances list --sort-by=ZONE

gcloud beta compute --project=qwiklabs-gcp-03-e1cf829478ae instances create managementnet-us-vm --zone=us-central1-c --machine-type=f1-micro --subnet=managementsubnet-us --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=85924901289-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=debian-10-buster-v20201014 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=managementnet-us-vm --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

# install LAMP stack with ubuntu image

sudo apt-get update
sudo apt-get install apache2 php7.0
sudo service apache2 restart

# Monitoring and Logging

It is best practice to run the Cloud Logging agent on all your VM instances. Run the Monitoring agent install script command in the SSH terminal of your VM instance to install the Cloud Monitoring agent

curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh
sudo apt-get update
sudo apt-get install stackdriver-agent


Run the Logging agent install script command in the SSH terminal of your VM instance to install the Cloud Logging agent

curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh
sudo apt-get update
sudo apt-get install google-fluentd

# Deployment Manager

gcloud deployment-manager deployments create advanced-configuration --config nodejs.yaml

Enabling service [deploymentmanager.googleapis.com] on project [75772095193]...
Operation "operations/acf.ed66e685-bcfa-436d-891b-365b535aafe3" finished successfully.
The fingerprint of the deployment is b'DHzEBEI-RBlaoRv0DV1d8g=='
Waiting for create [operation-1603230993473-5b2214ddbdf7a-1201bf1c-40796e30]...done.             
Create operation operation-1603230993473-5b2214ddbdf7a-1201bf1c-40796e30 completed successfully.
NAME                                   TYPE                             STATE      ERRORS  INTENT
advanced-configuration-application-fw  compute.v1.firewall              COMPLETED  []
advanced-configuration-backend         compute.v1.instance              COMPLETED  []
advanced-configuration-frontend-as     compute.v1.autoscaler            COMPLETED  []
advanced-configuration-frontend-hc     compute.v1.httpHealthCheck       COMPLETED  []
advanced-configuration-frontend-igm    compute.v1.instanceGroupManager  COMPLETED  []
advanced-configuration-frontend-it     compute.v1.instanceTemplate      COMPLETED  []
advanced-configuration-frontend-lb     compute.v1.forwardingRule        COMPLETED  []
advanced-configuration-frontend-tp     compute.v1.targetPool            COMPLETED  []

gcloud compute forwarding-rules list 

http://34.69.242.192:8080/



