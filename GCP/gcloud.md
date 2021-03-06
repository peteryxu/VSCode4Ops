- [Daily Start Checking config](#daily-start-checking-config)
  - [creat new configuration, and set default config](#creat-new-configuration-and-set-default-config)
- [SDK Reference, Config, Context](#sdk-reference-config-context)
  - [Install, Update SDK](#install-update-sdk)
  - [help, topic, info](#help-topic-info)
  - [components](#components)
  - [init](#init)
  - [auth](#auth)
  - [org](#org)
  - [projects](#projects)
  - [resource-manager](#resource-manager)
  - [config](#config)
  - [Global flags](#global-flags)
- [Compute](#compute)
  - [general](#general)
  - [Compute Engine: instances](#compute-engine-instances)
    - [list](#list)
    - [create](#create)
    - [manage: start, stop, delete, reset(restart), new instance group](#manage-start-stop-delete-resetrestart-new-instance-group)
    - [disk, snapshot, images](#disk-snapshot-images)
    - [instance-groups, instance-templates](#instance-groups-instance-templates)
  - [Kubernetes Engine: GKE container clusters](#kubernetes-engine-gke-container-clusters)
    - [get/describe nodes/pods/deployments/services](#getdescribe-nodespodsdeploymentsservices)
    - [deployments/workloads](#deploymentsworkloads)
    - [images](#images)
  - [App Engine: app](#app-engine-app)
  - [Cloud Functions:](#cloud-functions)
- [Storage and Data: tools-> gcloud, bq, gsutil, cbt](#storage-and-data-tools--gcloud-bq-gsutil-cbt)
  - [Cloud SQL](#cloud-sql)
  - [Datastore (document db)](#datastore-document-db)
  - [BigQuery](#bigquery)
  - [Cloud Spanner](#cloud-spanner)
  - [Cloud Pub/Sub](#cloud-pubsub)
  - [Bigtable](#bigtable)
  - [Dataproc](#dataproc)
  - [Cloud Storage](#cloud-storage)
- [Networking](#networking)
  - [VPC](#vpc)
  - [Firewall](#firewall)
  - [VPN](#vpn)
  - [DNS](#dns)
  - [LB](#lb)
  - [IP](#ip)
- [Monitoring and Logging](#monitoring-and-logging)
- [Deployment Manager](#deployment-manager)

# Daily Start Checking config
gcloud config configurations list    (find out active configuration)

## creat new configuration, and set default config
gcloud auth list
gcloud projects list
gcloud config configurations create  dev-qwiklabsproj  (authname-projname)


gcloud config list   (account/project &  region/zone)

gcloud auth list
gcloud config set account dev@we-sense.org

gcloud projects list
gcloud config set project qwiklabsproj

gcloud config set compute/zone us-east1-b 
gcloud config set compute/region us-east1



# SDK Reference, Config, Context

https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login

## Install, Update SDK
https://cloud.google.com/sdk/docs/install


## help, topic, info

// User Config Directory: [/home/username/.config/gcloud] 
gcloud info  

gcloud help
gcloud topic

Run `gcloud help config` to learn how to change individual settings
This gcloud configuration is called [product1-dev-1018]. You can create additional configurations if you work with multiple accounts and/or projects.
Run `gcloud topic configurations` to learn more.

gcloud topic --help
gcloud topic configurations

## components
// https://cloud.google.com/sdk/docs/components
gcloud components list
gcloud components update
gcloud components install kubectl

## init
gloud init

## auth
gcloud auth list
gcloud auth login
gcloud auth activate-service-account
gcloud auth revoke [ACCOUNT


## org
gcloud organizations add-iam-policy-binding [ORG_ID]
--member='user:[EMAIL_ADDRESS]'
--role="roles/compute.xpnAdmin"

## projects
gcloud projects list

## resource-manager
gcloud beta resource-manager folders add-iam-policy-binding [FOLDER_ID]
--member='user:[EMAIL_ADDRESS]'
--role="roles/compute.xpnAdmin"

gcloud beta resource-manager folders list --organization=[ORG_ID]





## config
// https://cloud.google.com/sdk/docs/configurations 
// User Config Directory: [/home/username/.config/gcloud] 

gcloud config list
gcloud config configurations [COMMAND]
gcloud config configurations activate [CONFIGURATION]

gcloud config set compute/zone us-central1-a
gcloud config list project

## Global flags

--account specifies a GCP account to use overriding the default account.
--project specifies a GCP project to use, overriding the default project.
--zone 
--configuration uses a named configuration file that contains key-value pairs.
--flatten generates separate key-value records when a key has multiple values.
--format specifies an output format, such as a default (human readable) CSV, JSON, YAML, text, or other possible options.
--help displays a detailed help message.
--quiet disables interactive prompts and uses defaults.
--verbosity specifies the level of detailed output messages. Options are debug, info, warning, and error.


# Compute

## general
gcloud compute zones list
gcloud compute project-info describe
gcloud compute instances describe  (show all fields )

## Compute Engine: instances
### list
gcloud compute instances list --filter="zone:ZONE"  --limit 10 --sort-by ...
gcloud compute disk-types list
gcloud compute machine-types list

### create
cloud compute instances create --machine-type=n1-standard-8 --preemptible -- boot-disk-type=... --ace-instance-1

### manage: start, stop, delete, reset(restart), new instance group

gcloud compute instances start/stop ch06-instance-1 ch06-instance-2 --async --zone us-central1-c 

gcloud compute instances delete ch06-instance-1 --zone us-central2-b --keep-disks=all (––keep-disks=boot)

while the following deletes all nonboot disks:
gcloud compute instances delete ch06-instance-1 --zone us-central2-b --delete-disks=data

### disk, snapshot, images
gcloud compute snapshots list

gcloud compute disks snapshot DISK_NAME --snapshot-names=NAME
gcloud compute disks create ch06-disk-1 --source-snapshot=ch06-snapshot --size=100 --type=pd-standard

gcloud compute images create ch06-image-1 –-source-disk ch06-disk-1
gcloud compute images export --destination-uri DESTINATION_URI --image IMAGE_NAME

### instance-groups, instance-templates
gcloud compute instance-templates create  TEMPLATENAME
gcloud compute instance-templates create ch06-instance-template-1 --source-instance=ch06-instance-1
gcloud compute instance-templates list

gcloud compute instance-groups list
gcloud compute instance-groups managed list-instances gke-griffin-dev-default-pool-ce976b2f-grp


## Kubernetes Engine: GKE container clusters 

// will create right entry in kubeconfig file and set right context
gcloud container clusters get-credentials griffin-dev --zone us-east1-b --project product1-dev-1018

gcloud container --project "ferrous-depth-220417" clusters create  "standard-cluster-2" --zone "us-central1-a" --username "admin"  --cluster-version "1.9.7-gke.6" --machine-type "n1-standard-1"  --image-type "COS" --disk-type "pd-standard" --disk-size "100" --scopes  "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/trace.append" --num-nodes "3" --enable-cloud-logging --enable-cloud-monitoring --network "projects/ferrous-depth-220417/global/networks/default" --subnetwork "projects/ferrous-depth-220417/regions/us-central1/subnetworks/default" --addons HorizontalPodAutoscaling, HttpLoadBalancing,KubernetesDashboard --enable-autoupgrade --enable-autorepair

gcloud container clusters list
gcloud container clusters describe   griffin-dev --zone=us-east1-b 
gcloud container clusters describe   griffin-dev --zone us-east1-b 
gcloud container clusters describe   --zone us-east1-b griffin-dev

gcloud container clusters resize standard-cluster-1 --node-pool default-pool --size 5 --region=us-central1
gcloud container clusters update standard-cluster-1 --enable-autoscaling  --min-nodes 1 --max-nodes 5 --zone us-central1-a --node-pool default-pool


### get/describe nodes/pods/deployments/services
kubectl get nodes
kubectl get pods
kubectl get deployments
kubectl get services

kubectl get deployment wordpress -o yaml


kubectl describe pods 
kubectl describe services wordpress
kubectl get deployment wordpress -o yaml 


### deployments/workloads
// Autoscale, Expose, Rolling Update, and Scale

kubectl run ch07-app-deploy --image=ch07-app --port=8080
kubectl run hello-server --image=gcr.io/google/samples/hello-app:1.0 --port 8080

kubectl scale deployment ch07-app-deploy --replicas=5
kubectl autoscale deployment nginx-1 --max 10 --min 1 --cpu-percent 80

//exposed as services
kubectl expose deployment hello-server --type="LoadBalancer"

//delete
kubectl delete deployment nginx-1
kubectl delete service hello-server

### images
//Only listing images in gcr.io/product1-dev-1018. Use --repository to list images in other repositories. 
gcloud container images list
gcloud container images describe gcr.io/appengflex-project-1/nginx


## App Engine: app

gcloud components install app-engine-python

gcloud app deploy app.yml
gcloud app browse
gcloud app logs tail -s default

https://product1-dev-1018.ue.r.appspot.com

gcloud app versions stop v1 v2
gcloud app services set-traffic serv1 --splits v1=.4,v2=.6

//--migrate indicates that App Engine should migrate traffic from the previous version to the new version.
//--split-by specifies how to split traffic using either IP or cookies. Possible values are ip, cookie, and random.

//auto scale parameters
target_cpu_utilization
target_throughput_utilization
max_concurrent_requests
max_instances
min_instances 
max_pending_latency
min_pending_latency

## Cloud Functions:

gcloud functions deploy

gcloud functions deploy pub_sub_function_test --runtime python37 --trigger-topic gcp-ace-exam-test-topic

gcloud functions deploy cloud_storage_function_test \
         --runtime python37 \
         --trigger-resource gcp-ace-exam-test-bucket \
         --trigger-event google.storage.object.finalize    (file fully uploaded)

google.storage.object.finalize
google.storage.object.delete
google.storage.object.archive
google.storage.object.metadataUpdate        

gcloud functions delete cloud_storage_function_test

# Storage and Data: tools-> gcloud, bq, gsutil, cbt
gcloud beta compute disks create disk-1 --project=product1-dev-1018 --type=pd-standard --size=500GB --zone=us-central1-a

//Cloud SQL, Cloud Spanner, BigQuery
//Datastore, Firestore, BigTable
//Cloud Storage, MemoryStore, Pub/Sub, Dataproc

## Cloud SQL
gcloud sql connect ace-exam-mysql –user=root 

//on-demand backup
gcloud sql backups create ––async ––instance [INSTANCE_NAME]
//auto backup
gcloud sql instances patch ace-exam-mysql –backup-start-time 01:00

// export (sql or csv) and import to Cloud Storage
gcloud sql export csv ace-exam-mysql1 gs://ace-exam-buckete1/ace-exam-mysql-export.csv \
                            --database=mysql

gcloud sql export sql ace-exam-mysql1 gs://ace-exam-buckete1/ace-exam-mysqlexport.sql \                     --database=mysql

gcloud sql import sql ace-exam-mysql1 gs://ace-exam-buckete1/ace-exam-mysql-export.sql \
                            --database=mysql

## Datastore (document db)
//After creating entities, you can query the document database using GQL, a query language similar to SQL

gsutil mb gs://ace_exam_backups/

// Datastore uses a namespace data structure to group entities that are exported. You will need to specify the name of the namespace used by the entities you are exporting. The default namespace is simply (default).
gcloud datastore export --namespaces="(default)" gs://ace-exam-datastore1

//The export process will create a folder named ace-exam-datastore1 using the data and time of the export. The folder will contain a metadata file and a folder containing the exported data. The metadata filename will use the same date and time used for the containing folder. The data folder will be named after the namespace of the exported Datastore database. An example import command is as follows:

gcloud datastore import gs://ace-exam-datastore1/2018-12-20T19:13:55_64324/ 2018-12-20T19:13:55_64324.overall_export_metadata

## BigQuery

// an estimate of how much data will be scanned. You can also use the command line to get this estimate by using the bq command with the ––dry-run option. Use the size of query for pricing calulator estimate 
bq ––location=[LOCATION] query ––use_legacy_sql=false ––dry_run [SQL_QUERY]

//view status of jobs
bq --location=US show -j gcpace-project:US.bquijob_119adae7_167c373d5c3

//export to Cloud Storage
The options are CSV, Avro, and JSON. Choose a compression type. The options are None or Gzip for CSV and “deflate” and “snappy” for Avro.

bq extract --destination_format CSV --compression GZIP 'mydataset.mytable'  gs://example-bucket/myfile.zip

//import:  The options include CSV, JSON, Avro, Parquet, PRC, and Cloud Datastore Backup 
bq load --autodetect --source_format=CSV mydataset.mytable gs://ace-exam-biquery/mydata.csv

## Cloud Spanner

## Cloud Pub/Sub
gcloud pubsub topics create ace-exam-topic1
gcloud pubsub subscriptions create --topic=ace-exam-topic1 ace-exam-sub1

gcloud pubsub topics publish ace-exam-topic1 ––message "first ace exam message"
gcloud pubsub subscriptions pull ––auto-ack ace-exam-sub1


## Bigtable
gcloud components install cbt

echo instance = ace-exam-bigtable >> ~/.cbtrc
cbt createtable ace-exam-bt-table
cbt ls
//column family
cbt createfamily ace-exam-bt-table colfam1
cbt set ace-exam-bt-table row1 colfam1:col1=ace-exam-value
cbt read ace-exam-bt-table

//import/export using a java program
java -jar bigtable-beam-import-1.6.0-shaded.jar export \
    --runner=dataflow \
    --project=my-project \
    --bigtableInstanceId=ace-exam-instance \
    --bigtableTableId=ace-exam-table1 \
    --destinationPath=gs://ace-exam-bucket1/ace-exam-table1 \
    --tempLocation=gs://my-export-bucket/jar-temp \
    --maxNumWorkers=30 \
--zone=us-west2-a


## Dataproc
//managed Apache Spark and Hadoop service: Spark supports analysis and machine learning, while Hadoop is well suited to batch, big data applications

You will need to specify the cluster to run the job and the type of job, which can be either Spark, PySpark, SparkR, Hive, Spark SQL, Pig, or Hadoop. The JAR files are the Java programs that will be executed, and the Main Class or JAR is the name of the function or method that should be invoked to start the job. If you choose PySpark, you will submit a Python program; if you submit SparkR, you will submit an R program. When running Hive or SparkSQL, you will submit query files. You can also pass in optional arguments. Once the job is running, you will see it in the jobs listing page

gcloud dataproc clusters create cluster-bc3d ––zone us-west2-a
gcloud dataproc jobs submit spark ––cluster cluster-bc3d  ––jar ace_exam_jar.jar

//have Import and Export commands to save and restore cluster configuration data. These commands are available, in beta, using gcloud.

gcloud beta dataproc clusters export ace-exam-dataproc-cluster  --destination=gs://ace-exam-bucket1/mydataproc.yaml

gcloud beta dataproc clusters import gs://ace-exam-bucket1/mydataproc.yaml

## Cloud Storage

//make bucket
gsutil mb gs://ace-exam-bucket1/

//upload
gsutil cp /home/mydir/README.txt gs://ace-exam-bucket1/

//download
gsutil cp gs://ace-exam-bucket1/README.txt /home/mydir/



//rename or move
gsutil mv gs://[BUCKET_NAME]/[OLD_OBJECT_NAME] gs://[BUCKET_NAME]/ [NEW_OBJECT_NAME]

//change storage class
gsutil rewrite -s [STORAGE_CLASS] gs://[PATH_TO_OBJECT]

// grant service account permission to write to the bucket
gsutil acl ch -u tnkknzut25bezoq72bjbfmo5hu@spe-umbra-30.iam.gserviceaccount.com /
:W gs://ace-exam-bucket1

# Networking

## VPC
gcloud compute networks create managementnet --project=qwiklabs-gcp-03-e1cf829478ae --description=managementnet --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-03-e1cf829478ae --range=10.130.0.0/20 --network=managementnet --region=us-central1

gcloud compute networks list
gcloud compute networks subnets list --sort-by=NETWORK

//This peering will allow private traffic to flow between the two VPCs. when an organization does not exist. 
gcloud compute networks peerings create peer-ace-exam-1 \
    --network ace-exam-network-A \
    --peer-project ace-exam-project-B \
    --peer-network ace-exam-network-B \
    --auto-create-routes


gcloud compute shared-vpc enable [HOST_PROJECT_ID]
gcloud compute shared-vpc associated-projects add [SERVICE_PROJECT_ID] \
    --host-project [HOST_PROJECT_ID]



## Firewall
// Firewall rules are defined at the network level and used to control the flow of network traffic to VMs.
gcloud compute firewall-rules list --sort-by=NETWORK

gcloud compute --project=qwiklabs-gcp-03-e1cf829478ae firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389,icmp --source-ranges=0.0.0.0/0

gcloud compute firewall-rules create ace-exam-fwr2 –-network ace-exam-vpc1 –-allow tcp:20000-25000

## VPN

## DNS
gcloud beta dns managed-zones create ace-exam-zone1 --description= --dns-name=aceexamzone.com. --visibility=private --networks=default

gcloud dns record-sets transaction start --zone=ace-exam-zone1
gcloud dns record-sets transaction add server1.aceexamezone.com. -- name=www2.aceexamzone.com. --ttl=300 --type=CNAME --zone=ace-exam-zone1
gcloud dns record-sets transaction execute --zone=ace-exam-zone1

## LB
gcloud compute forwarding-rules create ace-exam-lb --port=80  --target-pool ace-exam-pool
gcloud compute target-pools add-instances ace-exam-pool --instances ig1,ig2

## IP
gcloud compute networks subnets expand-ip-range ace-exam-subnet1 --prefix-length 16

//reserv static  IP 
gcloud beta compute addresses create ace-exam-reserved-static1 --region=us-west2 --network-tier=PREMIUM

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



