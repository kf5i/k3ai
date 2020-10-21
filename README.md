# K3ai \(keɪ3ai\)

K3ai is a lightweight infrastructure-in-a-box solution specifically built to install and configure AI tools and platforms in production evironments on Edge and IoT devices as easily as local test environments.

![k3ai in action](.gitbook/assets/aio.gif)


## Ready to experiment?

```text
curl -sfL https://get.k3ai.in | bash -
```

Full Documentaiton:  [https://docs.k3ai.in](https://docs.k3ai.in)

Look for interaction with us? Join our slack channel:  [**https://kf5ikfai.slack.com**](https://join.slack.com/t/kf5ikfai/shared_invite/zt-huh5ib1f-ZyBxqyBDKooGNvpd5_MoQQ)

## Components of K3ai

K3ai curently provides: \(the list is changing and growing\):

* Kubernetes based on K3s from Rancher: [https://k3s.io/](https://k3s.io/)
* Kubeflow pipelines: [https://github.com/kubeflow/pipelines](https://github.com/kubeflow/pipelines)
* Argo Workflows: https://github.com/argoproj/argo
* Kubeflow: [https://www.kubeflow.org/](https://www.kubeflow.org/) - (coming soon)
* NVIDIA GPU support: [https://docs.nvidia.com/datacenter/cloud-native/index.html](https://docs.nvidia.com/datacenter/cloud-native/index.html)
* NVIDIA Triton inference server: [https://github.com/triton-inference-server/server/tree/master/deploy/single\_server](https://github.com/triton-inference-server/server/tree/master/deploy/single_server) (coming soon)
* Tensorflow Serving: [https://www.tensorflow.org/tfx/serving/serving\_kubernetes](https://www.tensorflow.org/tfx/serving/serving_kubernetes):
  * ResNet
  * Mnist (coming soon)

