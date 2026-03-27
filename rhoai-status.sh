#!/bin/bash

fmt="%-45s %-45s %-25s\n"

div_section()
{
  echo "-----------------------------------------------------------------------------------------------------"
}

check_requirements()
{
  # Need jq, and oc binary
  # Also, need to be connected to the cluster

  which jq &>/dev/null
  if [ $? -ne 0 ]; then
    echo "jq binary not available. Please, install it."
    echo "exiting ..."
    exit
  fi

  which oc &>/dev/null
  if [ $? -ne 0 ]; then
    echo "oc binary not available. Please, install it."
    echo "exiting ..."
    exit
  fi

  oc get nodes &>/dev/null
  if [ $? -ne 0 ]; then
    echo "You are not authenticated to the cluster via oc, please do it."
    echo "exiting ..."
    exit
  fi

  # Divider
  div_section
}

check_csv()
{
  echo "# RHOAI CSV Operators Status"
  echo
  printf "$fmt" "Operator" "DisplayName" "Status"
  printf "$fmt" "--------" "-----------" "------"

  # Collecting the whole CSV information in a single shot
  full_csv=$(oc get csv -A | sort -k3 -u)
  
  # Operator's Names for RHOAI 3.x
  # - jobset-operator
  # - custom-metrics-autoscaler
  # - cert-manager-operator
  # - leader-worker-set
  # - rhcl-operator
  # - kueue-operator
  # - sriov-network-operator
  # - opentelemetry-operator
  # - tempo-operator
  # - cluster-observability-operator
  # - spyre-operator
  # - gpu-operator-certified

  for b in $(echo jobset-operator custom-metrics-autoscaler cert-manager-operator leader-worker-set rhcl-operator kueue-operator sriov-network-operator opentelemetry-operator tempo-operator cluster-observability-operator spyre-operator gpu-operator-certified rhods-operator)
  do
    # Checking if the operator in question is present
    validate_operator=$(echo "$full_csv" | grep $b | awk '{print $2}' | wc -l)

    if [ $validate_operator -eq 0 ]; then
      printf "$fmt" $b "NOT_INSTALLED" "NOT_INSTALLED"
    else
      temp_namespace=$(echo "$full_csv" | grep $b | awk '{print $1}')
      operator_name=$(echo "$full_csv" | grep $b | awk '{print $2}')
      display_name=$(oc get csv/$operator_name -n $temp_namespace -o json | jq .spec.displayName)
      status=$(echo "$full_csv" | grep $b | awk '{print $NF}')

      printf "$fmt" $operator_name "$display_name" $status
    fi
  done

  # Divider
  div_section
}

check_dsc()
{
  echo "# DataScienceCluster Check"
  echo
  # Checking the DSC status
  result=$(oc get dsc/default-dsc -A -o json | jq .status.phase)
  printf "$fmt" "dsc/default-dsc status" "" "$result"

  # Divider
  div_section
}

check_cluster_operators()
{
  echo "# Degraded Cluster Operators"
  echo

  # Checking if there is any cluster operator that is degraded
  validate_degraded_cluster=$(oc get co --no-headers | awk '$5 == "True"' | wc -l)

  if [ $validate_degraded_cluster -eq 0 ]; then
    echo "All OK"
  else
    printf "$fmt" "OPERATOR" "VERSION" "DEGRADED"
    printf "$fmt" "--------" "-------" "--------"

    oc get co --no-headers | awk '$5 == "True"' | while read -r name ver avail prog deg since
    do
      printf "$fmt" "$name" "$ver" "$deg"
    done
  fi

  # Divider
  div_section
}

check_console()
{
  echo "# Cluster Console"
  echo
  oc whoami --show-console

  # Divider
  div_section
}

check_cluster_version()
{
  echo "# Cluster Version"
  echo
  oc get clusterversion

  # Divider
  div_section
}

check_nodes()
{
  echo "# Cluster Nodes"
  echo
  oc get nodes

  # Divider
  div_section
}

check_ocp_api_server()
{
  echo "# Cluster API Server Health"
  echo
  oc get --raw "/readyz?verbose"

  # Divider
  div_section
}

check_api_service()
{
  echo "# Cluster API Service"
  echo

  # Checking if there is any apiservice that is not available
  validate_apiservice=$(oc get apiservice --no-headers | awk '$3 != "True"' | wc -l)

  if [ $validate_apiservice -eq 0 ]; then
  echo "All OK"
  else
    oc get apiservice --no-headers | awk '$3 != "True"' | while read -r name service avail age
    do
      printf "$fmt" "$name" "$service" "$avail"
    done
  fi

  # Divider
  div_section
}

# Main
check_requirements
check_console
check_cluster_version
check_nodes
check_csv
check_dsc
check_cluster_operators
check_api_service
check_ocp_api_server
