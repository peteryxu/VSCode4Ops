- [Actual questions](#actual-questions)
- [In project quicklabs with $86](#in-project-quicklabs-with-86)
  - [In Cloud Shell, daily/morning/night check](#in-cloud-shell-dailymorningnight-check)
  - [GKE](#gke)
    - [Game Servers](#game-servers)
  - [compute](#compute)
    - [MIG](#mig)
    - [instance-templates](#instance-templates)
    - [instances](#instances)
    - [images](#images)
- [In project:  product1-dev-1108](#in-project--product1-dev-1108)
  - [VM](#vm)
    - [1109](#1109)
      - [Using IAP (identify aware proxy) for TCP forwarding](#using-iap-identify-aware-proxy-for-tcp-forwarding)
- [In project:  product1-dev-web-1108](#in-project--product1-dev-web-1108)
- [In project:  product1-data-1108](#in-project--product1-data-1108)


# Actual questions
https://www.examtopics.com/exams/google/professional-cloud-architect/view/1/


#  In project quicklabs with $86

## In Cloud Shell, daily/morning/night check
gcloud compute instances list

gcloud compute instances stop vm-1-grafana-vm --zone us-central1-a


## GKE
gcloud container
https://cloud.google.com/sdk/gcloud/reference/container/clusters/create

### Game Servers
https://cloud.google.com/game-servers/docs/quickstart#cloud-shell

//create 
gcloud container clusters create gcgs-quickstart \
--cluster-version=1.15 \
--tags=game-server \
--scopes=gke-default \
--num-nodes=1 \
--no-enable-autoupgrade \
--machine-type=e2-standard-2 \
--zone=us-central1-a
--preemptible

//resize
gcloud container clusters resize gcgs-quickstart --num-nodes=0 --zone=us-central1-a

## compute 

### MIG
gcloud compute instance-groups managed
https://cloud.google.com/sdk/gcloud/reference/compute/instance-groups/managed

//ceate instance group
gcloud compute instance-groups managed create mig-grafana --zone us-central1-a --template my-instance-template-2-grafana --size 2

//resize
gcloud compute instance-groups managed resize  mig-grafana --size 0 --zone us-central1-a

### instance-templates
gcloud compute instance-templates create my-instance-template-f1-micro \
    --machine-type f1-micro \
    --image-family debian-9 \
    --image-project debian-cloud \
    --boot-disk-size 10GB

gcloud compute instance-templates create  my-instance-template-2-grafana \
    --source-instance=vm-1-grafana-vm	 \
    --source-instance-zone=us-central1-a 

gcloud compute instance-templates create instance-template \
    --preemptible


### instances
//lifecycle
gcloud compute instances create
gcloud compute instances create-with-container instance-1  --zone us-central1-a            --container-image=gcr.io/google-containers/busybox
gcloud compute instances delete

//change 
gcloud compute instances update
gcloud compute instances set-machine-type example-instance  --zone us-central1-b --machine-type n1-standard-4

//daily operation
gcloud compute instances start
gcloud compute instances stop vm-1-grafana-vm --zone us-central1-a
gcloud compute instances move example-instance-1  --zone us-central1-b --destination-zone us-central1-f

//security access control related
gcloud compute instances add-iam-policy-binding
gcloud compute instances set-service-account ... 

### images
gcloud compute images create image-from-snapshot-1115-lamp --project=qwiklabsproj --source-snapshot=snapshot-1115-lamp --storage-location=us-central1

POST https://www.googleapis.com/compute/v1/projects/qwiklabsproj/global/images
{
  "kind": "compute#image",
  "name": "image-from-snapshot-1115-lamp",
  "sourceSnapshot": "projects/qwiklabsproj/global/snapshots/snapshot-1115-lamp",
  "storageLocations": [
    "us-central1"
  ]
}



#  In project:  product1-dev-1108
gcloud config configurations activate dev-product1dev 

## VM

### 1109
gcloud compute instances create vm-f1micro-1109 --machine-type=f1-micro --image-family=ubuntu-1804-lts --image-project=ubuntu-os-cloud

gcloud compute instances create example-instance --image-family=rhel-8 --image-project=rhel-cloud --zone=us-central1-a


1 F1-micro instance per month: Scalable, high-performance virtual machines.

1 non-preemptible f1-micro VM instance per month in one of the following US regions:
Oregon: us-west1
Iowa: us-central1
South Carolina: us-east1

30 GB-months HDD

5 GB-month snapshot storage in the following regions:
Oregon: us-west1
Iowa: us-central1
South Carolina: us-east1
Taiwan: asia-east1
Belgium: europe-west1

1 GB network egress from North America to all region destinations (excluding China and Australia) per month

####
gcloud compute ssh vm-f1micro-1109

#### Using IAP (identify aware proxy) for TCP forwarding
enable administrative access to VM instances that do not have public IP addresses or do not permit direct access over the internet.

https://cloud.google.com/iap/docs/using-tcp-forwarding


#  In project:  product1-dev-web-1108


#  In project:  product1-data-1108