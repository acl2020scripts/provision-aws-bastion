#!/bin/bash

# Prerequisites:
# - you have gcloud configure to the GCP project that the workshop will run in
# - you know how many participants you're expecting in the next workshop
# - make sure the project name in line 32 is correct and also adapt the email address of the service account accordingly
#
# Steps:
# - execute the script with number of participants as parameter
# 
# Example:
# - to create service accounts and key files for 19 participants
#
# $ ./createGcloudServiceAccounts.sh 19


if [ -z $1 ]
then
    echo "Please provide the name of the service account as first parameter"
    echo ""
    echo "$ ./createGcloudServiceAccounts.sh acl-test-dec4- 2 acl-detroit"
    exit 1
fi

if [ -z $2 ]
then
    echo "Please provide the number of users as second parameter"
    echo ""
    echo "$ ./createGcloudServiceAccounts.sh acl-test-dec4- 2 acl-detroit"
    exit 1
fi

if [ -z $3 ]
then
    echo "Please provide the gcloud project as third parameter"
    echo ""
    echo "$ ./createGcloudServiceAccounts.sh acl-test-dec4- 2 acl-detroit"
    exit 1
fi

if [ -z $4 ]
then
    echo "Please provide the lab prefix as a fourth parameter"
    echo ""
    echo "$ ./createGcloudServiceAccounts.sh acl-test-dec4- 2 acl-detroit det-nov"
    exit 1
fi

serviceAccountName=$1
numberofusers=$2
gcloudproject=$3
prefix=$4
gcloud config set project $gcloudproject

i=1
while [ $i -le $numberofusers ]
do
  echo ""
  echo "delete SA: $prefix-$serviceAccountName$i@$gcloudproject.iam.gserviceaccount.com..."
  gcloud iam service-accounts delete $prefix-$serviceAccountName$i@$gcloudproject.iam.gserviceaccount.com --quiet
  
  i=$((i+1))
done

