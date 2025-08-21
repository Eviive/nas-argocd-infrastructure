# NAS ArgoCD Infrastructure

## Overview

This repository contains the configuration for the infrastructure supporting my NAS's Kubernetes cluster.  
It uses ArgoCD's [App-of-Apps pattern](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/) to deploy all applications.

## Applications

| Name            | Provider | Version              |
|-----------------|----------|----------------------|
| ArgoCD          | GitHub   | v3.1.0               |
| MetalLB         | GitHub   | v0.15.2              |
| Traefik         | Helm     | 37.0.0               |
| Cert-Manager    | GitHub   | v1.18.2              |
| Authentik       | Helm     | 2024.12.2            |
| NFS Provisioner | GitHub   | 4.0.18               |
| FlareSolverr    | Docker   | pr-1300-experimental |
| Prometheus      | Helm     | 76.4.0               |
| PostgreSQL      | Helm     | 16.7.26              |

## Installation

When installing from scratch, you need to apply the ArgoCD application first :
```bash
kubectl apply -k argocd/overlays/ENV
```

From there, you can install the rest of the applications using the ArgoCD UI by port-forwarding the `argocd-server` service :
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
