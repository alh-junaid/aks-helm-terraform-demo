
# aks-hello-world-demo

A minimal Python "Hello World" web app, containerized with Docker, deployable to Azure Kubernetes Service (AKS) using Helm charts and Terraform.
Includes Infrastructure-as-Code (Terraform), Helm/Kubernetes manifests, and a sample GitHub Actions CI/CD pipeline for end-to-end automation.

## Project overview
**What it includes**
- A tiny Flask app (`main.py`) that returns `{"data":"Hello World"}`.
- `Dockerfile` to containerize the application.
- A Helm chart (`helloworld/`) with Kubernetes manifests (Deployment, Service).
- Terraform infra under `infra/` to provision AKS (and supporting resources).
- Example GitHub Actions workflows under `.github/workflows/` for infra and app CI/CD.

---
### Repository structure
```
D:.
│   .gitignore
│   Dockerfile
│   main.py
│   README.md
│   requirements.txt
│
├───.github
│   └───workflows
│           helloworld.yaml
│           infra.yaml
│           master.yaml
│
├───helloworld
│   │   .helmignore
│   │   Chart.yaml
│   │   report.yaml
│   │   values.yaml
│   │
│   └───templates
│           deployment.yaml
│           service.yaml
│           _helpers.tpl
│
└───infra
        backend.tf
        main.tf
        outputs.tf
        variables.tf
```
---

## Prerequisites

- Docker
- Python 3.8+ and `pip`
- kubectl
- Helm 3
- Terraform (for infra)
- Azure CLI (if provisioning AKS on Azure)
- (Optional) GitHub account & repo for workflows
- Docker registry (e.g., Azure Container Registry) and credentials/secrets

## Quick start — run locally

1. Clone:

```bash
git clone https://github.com/your-username/aks-hello-world-demo.git
cd aks-hello-world-demo
```

2. Install Python deps and run:

```
pip install -r requirements.txt
python main.py
```
3. Or build & run with Docker:

```
docker build -t hello-world-app .
docker run -p 5000:5000 hello-world-app
# then open http://localhost:5000/hello

```

## Dockerfile notes

The provided Dockerfile uses a minimal Python base, copies source, installs requirements, and runs Flask. If you prefer running the app directly, you can replace the CMD with:
```
CMD ["python", "main.py"]
```
or keep using flask run with ENV FLASK_APP=main.py and FLASK_RUN_HOST=0.0.0.0.

## Helm (deploy to Kubernetes)

1. Ensure kubectl is configured for your cluster.
2. Install the chart:
```
helm install helloworld ./helloworld \
  --namespace helloworld --create-namespace \
  --set image.repository=<your-registry>/hello-world-app \
  --set image.tag=<tag>
```
3. Check the deployment and service:
```
kubectl -n helloworld get deployments,svc,pods
kubectl -n helloworld port-forward svc/helloworld 5000:80
# then access http://localhost:5000/hello

```
Adjust values.yaml or --set flags to match your container image and desired replicas/port.

## Terraform (provision AKS)

Steps :
```
cd infra
terraform init
terraform plan 
terraform apply  
```
After apply, Terraform outputs should include kubeconfig or AKS connection info. Configure kubectl (example using Azure CLI):
```
az aks get-credentials --resource-group <rg> --name <cluster-name>

```
## GitHub Actions (CI/CD)

**Workflows in `.github/workflows/` are examples for:**

1. Building and pushing Docker images.  
2. Deploying Helm charts to AKS.  
3. Terraform infrastructure provisioning (with proper secrets and approvals).  


### Secrets you will need:

1. `AZURE_CREDENTIALS` — Service principal JSON for Azure actions.  
2. `REGISTRY_USERNAME` / `REGISTRY_PASSWORD` — Container registry credentials or registry token.  
3. `KUBE_CONFIG` — (Optional) If you prefer to set kubeconfig directly.  
4. Any Terraform backend secrets — e.g., storage account keys.

## Helpful commands

1. List project files (Windows PowerShell):
```
tree /f /a
```
2. Show pods and logs:
```
kubectl get pods -n helloworld
kubectl logs -f <pod-name> -n helloworld
```
3. Rebuild image and force deploy with Helm:
```
docker build -t <registry>/hello-world-app:latest .
docker push <registry>/hello-world-app:latest

helm upgrade --install helloworld ./helloworld \
  --namespace helloworld \
  --set image.repository=<registry>/hello-world-app \
  --set image.tag=latest
```

## Troubleshooting

1. **App not reachable on container:**  
   Ensure Flask listens on `0.0.0.0` (not `127.0.0.1`) and the container port matches the `service.targetPort`.

2. **Docker build fails with missing `requirements.txt`:**  
   Confirm `requirements.txt` exists at the build context root and that your  
   `COPY . /Rest_API` and `WORKDIR` paths are correct.

3. **Helm deployment stuck:**  
   Run `kubectl describe pod <pod>` to check events, and  
   `kubectl logs <pod>` to view logs.

4. **Terraform errors:**  
   Check provider versions and Azure permissions for the service principal.

