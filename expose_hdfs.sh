#!/bin/bash
kubectl get pods | grep hdfs-nn | awk '{print $1}' | xargs -i kubectl port-forward -n default {} 9870:9870
