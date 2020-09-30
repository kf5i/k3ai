---
description: >-
  K3Ai is a lightweight infrastructure-in-a-box ready to run on top of edge and
  IoT devices  filled in with a set of Artificial Intelligence platforms and
  solutions
---

# Quick Start Guide

## First things First

Start by installing K3Ai with this:

```text
curl -sfL https://raw.githubusercontent.com/kf5i/k3ai/master/install | bash -
```

wait for a minute and check the status of installation with:

```text
kubectl get pods -n kubeflow
```

when all pods are in status `running` you're good to go.

## 

