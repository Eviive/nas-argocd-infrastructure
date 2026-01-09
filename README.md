# NAS ArgoCD Infrastructure

## Overview

This repository contains the configuration for the infrastructure supporting my NAS's Kubernetes cluster.  
It uses ArgoCD's [App-of-Apps pattern](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/) to deploy all applications.

## Dependencies

| Name            | Provider |
|-----------------|----------|
| ArgoCD          | Helm     |
| Authentik       | Helm     |
| Cert-Manager    | GitHub   |
| CloudNativePG   | Helm     |
| Grafana         | Helm     |
| Loki            | Helm     |
| MetalLB         | GitHub   |
| Mimir           | Helm     |
| Monitoring      | Helm     |
| n8n             | Helm     |
| NFS Provisioner | GitHub   |
| Redis           | Helm     |
| Traefik         | Helm     |
| nginx           | Docker   |

## Installation

When installing from scratch, you need to apply the ArgoCD application first :
```bash
kubectl apply -k argocd/overlays/ENV
```

From there, you can install the rest of the applications using the ArgoCD UI by port-forwarding the `argocd-server` service :
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
