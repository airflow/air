#!/bin/bash
#########################################################################
# destroy.sh .                                                          #
#                                                                       #
#                                                                       #
#                                                                       #
#                                                                       #
#                                                                       #
#########################################################################
set -x
aws iam remove-role-from-instance-profile --instance-profile-name ssm_profile --role-name ssm_role
aws iam delete-instance-profile --instance-profile-name ssm_profile
terraform destroy -auto-approve
date
