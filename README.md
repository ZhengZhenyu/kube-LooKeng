# kube-LooKeng
Deploy openLooKeng cluster using Kubernetes

# Frontend
This project uses 'Airpal' to provide web UI for users. We have a docker image uses Ubuntu Bionic as base image, running on X86 platform.
Airpal requires a 'MySQL(MariaDB)' service as its own database.

# openLooKeng backend
We have docker images uses openEuler 20.09 as base image, running on both Arm and X86 platform.

# Deploy
Simply run the following command:
```
kubectl create -f openlookeng-cluster.yaml
```
# Notes and Future plans
The current cluster defination is a simple configuration for a demo usecase, please modify according to your own case.
In the future, we will keep improving the user experiences and make the script more configurable for general users.
