# NAS ArgoCD Infrastructure

## Overview

This repository contains the configuration for the infrastructure supporting my NAS's Kubernetes cluster.  
It uses ArgoCD's [App-of-Apps pattern](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/) to deploy all applications.

## Applications

| Name            | Provider |
|-----------------|----------|
| ArgoCD          | GitHub   |
| MetalLB         | GitHub   |
| Traefik         | Helm     |
| Cert-Manager    | GitHub   |
| Authentik       | Helm     |
| NFS Provisioner | GitHub   |
| FlareSolverr    | Docker   |
| Prometheus      | Helm     |
| PostgreSQL      | Helm     |

## Installation

When installing from scratch, you need to apply the ArgoCD application first :
```bash
kubectl apply -k argocd/overlays/ENV
```

From there, you can install the rest of the applications using the ArgoCD UI by port-forwarding the `argocd-server` service :
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
