---
description: >-
  K3Ai is a lightweight infrastructure-in-a-box ready to run on top of edge and
  IoT devices  filled in with a set of Artificial Intelligence platforms and
  solutions
---

# Quick Start Guide

## First things First

If you like we also have a documentation website here: [https://k3ai.gitbook.io/docs/](https://k3ai.gitbook.io/docs/)

Start by installing K3Ai with this:

```text
curl -sfL https://github.com/kf5i/k3ai/releases/latest/download/install | bash -
```

Install inside a vagrant machine

```text
curl -sfL https://github.com/kf5i/k3ai/releases/latest/download/install_vagrant | bash -
```

#### **Notes: sometimes things take longer than expected and you may see the error below:**

```text
error: timed out waiting for the condition on xxxxxxx
```

Don't worry about that sometimes the installation takes a few minutes especially the Vagrant one or if you have limited bandwidth.

Still curious how this looks like? Here's a short demo:

![](.gitbook/assets/aio.gif)

## What do I find within K3Ai (WIP)

K3ai supports a variety of artificial intelligence tools that can be installed as standalone or as a bundle from directly from the command-line. The actual list may be run adding the below options after `k3ai server` the command:

`-- pipelines` \(default\): Kubeflow pipelines are installed as default settings so there's no need to explicit the command. If one desires, anyway, to add to an existing k3ai custom installation the command will install and configure the Kubeflow pipelines automatically.

`-- tekton` \(**WIP**\)

`--gpu` \(**WIP**\)

`--tf-resnet` \(**WIP**\)

`--tf-mnist` \(**WIP**\)

`--tf-mxnet` \(**WIP**\)

`--seldon` \(**WIP**\)

`--triton` \(**WIP**\)

