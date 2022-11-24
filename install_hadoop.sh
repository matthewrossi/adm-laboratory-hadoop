helm repo add pfisterer-hadoop https://pfisterer.github.io/apache-hadoop-helm/
helm upgrade --install hadoop pfisterer-hadoop/hadoop --values stable_hadoop_values.yaml
