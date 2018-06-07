#!/bin/bash
#########################################################################
# build_airflow.sh                                                      #
#                                                                       #
# This will build out a server and start up the airflow application     #
#                                                                       #
#                                                                       #
#                                                                       #
#########################################################################
set +x
mystart=`date`
terraform init; RC=$?
if [[ $RC != 0 ]]; then
  echo "FAILURE! RC=$RC There was a problem with terraform init"
  exit 2;
fi
terraform validate; RC=$?
if [[ $RC != 0 ]]; then
  echo "FAILURE! RC=$RC There was a problem with terraform validate"
  exit 3;
fi
terraform plan; RC=$?
if [[ $RC != 0 ]]; then
  echo "FAILURE! RC=$RC There was a problem with terraform plan"
  exit 4;
fi
terraform apply -auto-approve | tee terraform_apply.log; RC=$?
if [[ $RC != 0 ]]; then
  echo "FAILURE! RC=$RC There was a problem with terraform apply"
  exit 5;
fi
myend=`date`
echo "start time:.....$mystart"
echo "end time:.......$myend"
