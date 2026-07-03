# NAS ArgoCD Infrastructure

## Overview

This repository contains the configuration for the infrastructure supporting my NAS's Kubernetes cluster.  

## Dependencies

### Infrastructure

| Name                     | Provider |
|--------------------------|----------|
| ArgoCD                   | Helm     |
| Authentik                | Helm     |
| Cert-Manager             | GitHub   |
| Cloudflared              | Docker   |
| CloudNativePG            | Helm     |
| Grafana                  | Helm     |
| Loki                     | Helm     |
| MetalLB                  | GitHub   |
| Mimir                    | Helm     |
| nginx                    | Docker   |
| Monitoring               | Helm     |
| n8n                      | Helm     |
| Nextcloud                | Helm     |
| NFS Provisioner          | GitHub   |
| Prometheus Operator CRDs | Helm     |
| Traefik                  | Helm     |
| Redis                    | Helm     |

### Media Server

| Name         | Provider |
|--------------|----------|
| Bazarr       | Docker   |
| Jackett      | Docker   |
| Jellyfin     | Docker   |
| Jellyseerr   | Docker   |
| CoreDNS      | Docker   |
| Gluetun      | Docker   |
| FlareSolverr | Docker   |
| qBittorrent  | Docker   |
| Radarr       | Docker   |
| Scraparr     | Docker   |
| Sonarr       | Docker   |

## Installation

When installing from scratch, you need to apply the ArgoCD application first :
```bash
helm upgrade --install argocd charts/apps/infrastructure/argocd --namespace argocd --create-namespace -f charts/apps/infrastructure/argocd/values.yaml
```

From there, you can install the rest of the applications using the ArgoCD UI by port-forwarding the `argocd-server` service :
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
