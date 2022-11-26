# Create an Hadoop cluster using Kubernetes

*This tutorial is an adaptation of the original work done by Andrea
Zonca in [Install Hadoop on Kubernetes tutorial](https://zonca.dev/2021/10/hadoop-kubernetes-jetstream.html)*

## Requirements

### docker

Docker is an open platform for developing, shipping, and running applications.
Docker enables you to separate your applications from your infrastructure.

Follow installation instructions [here](https://docs.docker.com/get-docker/).

### kind

[kind](https://sigs.k8s.io/kind) is a tool for running local Kubernetes
clusters using Docker container "nodes".

Follow installation instructions [here](https://kind.sigs.k8s.io/docs/user/quick-start/).

### kubectl

The Kubernetes command-line tool, [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/),
allows you to run commands against Kubernetes clusters.
You can use kubectl to deploy applications, inspect and manage cluster
resources, and view logs.

Follow installation instructions [here](https://kubernetes.io/docs/tasks/tools/).

### helm

Helm is the package manager for Kubernetes.
Helm helps you manage Kubernetes applications — Helm Charts help you define,
install, and upgrade even the most complex Kubernetes application.

Follow installation instructions [here](https://helm.sh/docs/intro/install/)

## Deploy Hadoop

Fortunately we have a Helm chart which deploys all the Hadoop components.

Clone this repository with:

```bash
git clone https://github.com/matthewrossi/adm-laboratory-hadoop.git
```

Create a local Kubernetes clusters using Docker container “nodes”:

```bash
kind create cluster --config=kind-config.yaml
```

Verify the configuration in stable_hadoop_values.yaml, I’m currently keeping it simple, so no persistence.

Install Hadoop via Helm:

```bash
bash install_hadoop.sh
```

Once the pods are running, you should see:

```bash
> kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
hadoop-hadoop-hdfs-dn-0   1/1     Running   0          68m
hadoop-hadoop-hdfs-dn-1   1/1     Running   0          60m
hadoop-hadoop-hdfs-nn-0   1/1     Running   0          68m
hadoop-hadoop-yarn-nm-0   1/1     Running   0          68m
hadoop-hadoop-yarn-nm-1   1/1     Running   0          59m
hadoop-hadoop-yarn-rm-0   1/1     Running   0          68m
```

## Launch a test job

Get a terminal on the YARN node manager:

```bash
bash login_yarn.sh
```

You have now access to the Hadoop 3.3.2 cluster. Launch a test MapReduce job to compute pi:

```bash
bin/yarn jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.2.jar pi 16 1000
```

## Access the YARN Dashboard

You can also export the YARN dashboard from the cluster to your local machine.

```bash
bash expose_yarn.sh
```

Connect locally to port 8088 to check the status of the jobs.

## Delete the local Kubernetes cluster

Don't forget to delete the local Kubernetes clusters with:

```bash
kind delete cluster
```

Otherwise `kind` will keep it running even after reboots.
