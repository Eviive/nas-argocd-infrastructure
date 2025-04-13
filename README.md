# NAS ArgoCD Infrastructure

## Overview

This repository contains the configuration for the infrastructure supporting my NAS's Kubernetes cluster.  
It uses ArgoCD's [App-of-Apps pattern](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/) to deploy all applications.

## Applications

| Name            | Provider | Version   |
|-----------------|----------|-----------|
| ArgoCD          | GitHub   | v2.13.2   |
| MetalLB         | GitHub   | v0.14.9   |
| NFS Provisioner | Helm     | 4.0.18    |
| Traefik         | Helm     | 34.1.0    |
| Cert-Manager    | Helm     | v1.17.1   |
| Authentik       | Helm     | 2024.12.2 |

## Installation

When installing from scratch, you need to apply the ArgoCD application first :
```bash
kubectl apply -k argocd/overlays/ENV
```

From there, you can install the rest of the applications using the ArgoCD UI by port-forwarding the `argocd-server` service :
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
