# rhoai-status

**Disclaimer**: This project or the binary files available in the `Releases` area are `NOT` delivered and/or released by Red Hat. This is an independent project to help customers and Red Hat Support team to export and/or collect some data from your `OCP cluster` for reporting or troubleshooting purposes.

---

This script will collect some information from your `OCP Cluster`, in a way that will present the current state of your cluster, presenting if all the necessary operators for `RHOAI` got installed properly, and also if some necessary componentes are available.

Here, we can see an example:
```
./rhoai-status.sh
-----------------------------------------------------------------------------------------------------
# Cluster Console

https://console-openshift-console.apps.cluster04.king.lab
-----------------------------------------------------------------------------------------------------
# Cluster Version

NAME      VERSION   AVAILABLE   PROGRESSING   SINCE   STATUS
version   4.20.16   True        False         7d9h    Cluster version is 4.20.16
-----------------------------------------------------------------------------------------------------
# Cluster Nodes

NAME    STATUS   ROLES                         AGE     VERSION
srv05   Ready    control-plane,master,worker   7d10h   v1.33.8
-----------------------------------------------------------------------------------------------------
# RHOAI CSV Operators Status

Operator                                      DisplayName                                   Status
--------                                      -----------                                   ------
jobset-operator.v1.0.0                        "Job Set Operator"                            Succeeded
custom-metrics-autoscaler.v2.18.1-2           "Custom Metrics Autoscaler"                   Succeeded
cert-manager-operator.v1.18.1                 "cert-manager Operator for Red Hat OpenShift" Succeeded
leader-worker-set.v1.0.0                      "Red Hat build of Leader Worker Set"          Succeeded
rhcl-operator.v1.3.1                          "Red Hat Connectivity Link"                   Succeeded
kueue-operator.v1.3.0                         "Red Hat build of Kueue"                      Succeeded
sriov-network-operator.v4.20.0-202602261925   "SR-IOV Network Operator"                     Succeeded
opentelemetry-operator.v0.144.0-1             "Red Hat build of OpenTelemetry"              Succeeded
tempo-operator.v0.20.0-2                      "Tempo Operator"                              Succeeded
cluster-observability-operator.v1.4.0         "Cluster Observability Operator"              Succeeded
spyre-operator.v1.2.0                         "IBM Spyre Operator"                          Succeeded
gpu-operator-certified.v26.3.0                "NVIDIA GPU Operator"                         Succeeded
rhods-operator.3.3.0                          "Red Hat OpenShift AI"                        Succeeded
-----------------------------------------------------------------------------------------------------
# DataScienceCluster Check

dsc/default-dsc status                                                                      "Ready"
-----------------------------------------------------------------------------------------------------
# Degraded Cluster Operators

All OK
-----------------------------------------------------------------------------------------------------
# Cluster API Service

All OK
-----------------------------------------------------------------------------------------------------
# Cluster API Server Health

[+]ping ok
[+]log ok
[+]api-openshift-apiserver-available ok
[+]api-openshift-oauth-apiserver-available ok
[+]informer-sync ok
[+]poststarthook/quota.openshift.io-clusterquotamapping ok
[+]poststarthook/openshift.io-api-request-count-filter ok
[+]poststarthook/openshift.io-startkubeinformers ok
[+]poststarthook/openshift.io-openshift-apiserver-reachable ok
[+]poststarthook/openshift.io-oauth-apiserver-reachable ok
[+]poststarthook/start-apiserver-admission-initializer ok
[+]poststarthook/generic-apiserver-start-informers ok
[+]poststarthook/priority-and-fairness-config-consumer ok
[+]poststarthook/priority-and-fairness-filter ok
[+]poststarthook/storage-object-count-tracker-hook ok
[+]poststarthook/start-apiextensions-informers ok
[+]poststarthook/start-apiextensions-controllers ok
[+]poststarthook/crd-informer-synced ok
[+]poststarthook/start-system-namespaces-controller ok
[+]poststarthook/start-cluster-authentication-info-controller ok
[+]poststarthook/start-kube-apiserver-identity-lease-controller ok
[+]poststarthook/start-kube-apiserver-identity-lease-garbage-collector ok
[+]poststarthook/start-legacy-token-tracking-controller ok
[+]poststarthook/start-service-ip-repair-controllers ok
[+]poststarthook/rbac/bootstrap-roles ok
[+]poststarthook/scheduling/bootstrap-system-priority-classes ok
[+]poststarthook/priority-and-fairness-config-producer ok
[+]poststarthook/bootstrap-controller ok
[+]poststarthook/start-kubernetes-service-cidr-controller ok
[+]poststarthook/aggregator-reload-proxy-client-cert ok
[+]poststarthook/start-kube-aggregator-informers ok
[+]poststarthook/apiservice-status-local-available-controller ok
[+]poststarthook/apiservice-status-remote-available-controller ok
[+]poststarthook/apiservice-registration-controller ok
[+]poststarthook/apiservice-wait-for-first-sync ok
[+]poststarthook/apiservice-discovery-controller ok
[+]poststarthook/kube-apiserver-autoregistration ok
[+]autoregister-completion ok
[+]poststarthook/apiservice-openapi-controller ok
[+]poststarthook/apiservice-openapiv3-controller ok
[+]shutdown ok
readyz check passed
-----------------------------------------------------------------------------------------------------
```

Notes. This is valid for `RHOAI 3.x`, and also requires that `jq` and `oc` binaries on the system. Don't worry, if the binaries are not present, the script will tell you. ;-)

If you have any idea, feedback, etc, please, feel free to open a new issue.

Thank you!
Waldirio
