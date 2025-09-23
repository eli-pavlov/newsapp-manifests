<div align="center">
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/argocd/argocd-original.svg" alt="Argo CD Logo" width="100" height="100"/>
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/kubernetes/kubernetes-plain.svg" alt="Kubernetes Logo" width="100" height="100"/>
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/helm/helm-original.svg" alt="Helm Logo" width="100" height="100"/>
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/git/git-original.svg" alt="Git Logo" width="100" height="100"/>

  <h1>NewsApp Kubernetes Manifests (GitOps)</h1>
</div>

This repository contains all the Kubernetes manifests required to deploy the **NewsApp** application and its entire supporting infrastructure using a **GitOps** methodology. It serves as the single source of truth for the desired state of the cluster, managed by **Argo CD**.

<p align="center">
  <img src="https://img.shields.io/badge/GitOps-ArgoCD-EF7422?style=for-the-badge&logo=argocd" alt="Argo CD Badge"/>
  <img src="https://img.shields.io/badge/Orchestration-Kubernetes-326CE5?style=for-the-badge&logo=kubernetes" alt="Kubernetes Badge"/>
  <img src="https://img.shields.io/badge/Packaging-Helm-0f1689?style=for-the-badge&logo=helm" alt="Helm Badge"/>
</p>

---

## ✨ Key Concepts

-   **GitOps with Argo CD**: The entire cluster state—applications, addons, and configuration—is defined declaratively in this Git repository. Argo CD continuously monitors this repo and keeps the cluster synchronized.
-   **App of Apps Pattern**: A single root application (`newsapp-master-app.yaml`) bootstraps the entire cluster state, which includes deploying other Argo CD `Application` resources for addons and app environments.
-   **Environment Separation**: A clear, directory-based separation between `development` and `production` environments, each with its own configurations and secrets.
-   **Helm for Templating**: All applications (`frontend`, `backend`, `postgres`) are packaged as reusable Helm charts, with environment-specific configurations supplied via `values.yaml` files.
-   **Encrypted Secrets in Git**: Uses **Sealed Secrets** to safely encrypt and store sensitive data (like database passwords and API keys) in this public Git repository.
-   **Automated TLS & Storage**: Manages cluster addons like `cert-manager` for automatic SSL certificates and defines `PersistentVolume`s for stateful workloads.
-   **Ordered Sync with Waves**: Argo CD Sync Waves (`argocd.argoproj.io/sync-wave`) are used extensively to control the deployment order, ensuring dependencies like secret controllers and CRDs are available before the applications that rely on them.

---

## 🔄 How It Works: The GitOps Flow

This repository is designed to be consumed by an Argo CD instance running in your Kubernetes cluster.

1.  **Bootstrapping**: An administrator applies the single root manifest, `newsapp-master-app.yaml`, to the cluster.
    ```sh
    kubectl apply -f newsapp-master-app.yaml
    ```
2.  **Root App Sync**: Argo CD detects the root application and begins to sync it. This application's source is the `clusters/` directory of this repository.
3.  **App of Apps Deployment**: The root app deploys all other Argo CD `Application` resources found within the `clusters/` directory. This includes:
    -   Cluster-wide addons (`ingress-nginx`, `cert-manager`, `sealed-secrets`).
    -   Environment-specific applications for both `dev` and `prod`.
4.  **Dependency Resolution**: Argo CD respects the `sync-wave` annotations and deploys resources in the correct order. For example, `sealed-secrets-controller` (wave `-100`) is deployed before any applications that use `SealedSecret` resources (wave `1`).
5.  **Application Sync**: Each application (e.g., `newsapp-backend-dev`) syncs its corresponding Helm chart from the `charts/` directory, applying the environment-specific overrides from its `values/backend/dev.yaml` file.
6.  **Continuous Reconciliation**: The cluster state now mirrors the configuration defined in this repository. Any new commits pushed to the `main` branch will be automatically detected by Argo CD and synced to the cluster.

---

## 🛠️ Prerequisites

-   A running Kubernetes cluster.
-   **Argo CD** installed and configured in the cluster.
-   **Kubeseal CLI** installed on your local machine to encrypt secrets. You can find installation instructions [here](https://github.com/bitnami-labs/sealed-secrets#installation).

---

## 📂 Repository Structure

The repository is structured to separate cluster-wide addons, environment-specific applications, reusable Helm charts, and configuration values.

```bash
newsapp-manifests/
├── newsapp-master-app.yaml # 🚀 The single Argo CD root application to bootstrap everything.
├── clusters/
│   ├── addons/             # Cluster-wide services (ingress, certs, secrets, monitoring).
│   ├── dev/                # Manifests for the DEVELOPMENT environment.
│   │   ├── apps/           # Argo CD Applications for dev services.
│   │   └── sealed/         # Encrypted SealedSecrets for dev.
│   └── prod/               # Manifests for the PRODUCTION environment.
│       ├── apps/           # Argo CD Applications for prod services.
│       └── sealed/         # Encrypted SealedSecrets for prod.
├── charts/
│   ├── backend/            # Helm chart for the backend application.
│   ├── frontend/           # Helm chart for the frontend application.
│   └── postgres/           # Helm chart for the PostgreSQL database.
└── values/
├── ├─backend/
│   │ ├── dev.yaml        # Helm values for the backend in dev.
│   │ └── prod.yaml       # Helm values for the backend in prod.
├── └─frontend/
│     ├── dev.yaml
│     └── prod.yaml
└── postgres/
├── dev.yaml
└── prod.yaml
```

---

## 🔒 Managing Secrets

This repository uses **Sealed Secrets** to manage sensitive information. This allows you to store encrypted secrets in Git, which can only be decrypted by the controller running in your cluster.

**Workflow for adding a new secret:**

1.  **Create a standard Kubernetes Secret manifest locally.**
    ```yaml
    # my-secret.yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: my-database-password
      namespace: development
    stringData:
      PASSWORD: "SuperSecretPassword123"
    ```

2.  **Encrypt it using the `kubeseal` CLI.** You must have your `kubectl` context pointing to the cluster where the Sealed Secrets controller is running.
    ```sh
    # Fetch the public key and encrypt the file
    kubeseal --fetch-cert > pub-cert.pem
    kubeseal --format yaml --cert pub-cert.pem < my-secret.yaml > my-sealed-secret.yaml
    ```

3.  **Commit the encrypted file.** The output file (`my-sealed-secret.yaml`) is a `SealedSecret` resource. You can now safely commit this file to the repository (e.g., under `clusters/dev/sealed/`). Argo CD will apply it, and the controller in the cluster will decrypt it into a regular Kubernetes `Secret`.

---

## 🧩 Application Configuration

The infrastructure is designed to run the `newsApp` application. The following environment variables are required by the application itself. These are **not** Argo CD parameters; they should be managed as Kubernetes secrets (ideally using the Sealed Secrets workflow described above) and applied to your deployments.

### **Frontend Environment Variables**

#### Build-Time (Vite)

| Variable                      | Description                               | Example                                  |
| ----------------------------- | ----------------------------------------- | ---------------------------------------- |
| `VITE_SERVER_URL`             | The base path for API requests.           | `/api`                                   |
| `VITE_NEWS_INTERVAL_IN_MIN`   | The interval in minutes to fetch news.    | `5`                                      |
| `VITE_FRONTEND_GIT_BRANCH`    | Git branch of the frontend build.         | `main`                                   |
| `VITE_FRONTEND_GIT_COMMIT`    | Git commit SHA of the frontend build.     | `a1b2c3d`                                |

#### Runtime (NGINX)

| Variable                   | Description                                             | Example                                  |
| -------------------------- | ------------------------------------------------------- | ---------------------------------------- |
| `BACKEND_SERVICE_HOST`     | The internal Kubernetes service hostname for the backend. | `backend.default.svc.cluster.local`      |
| `BACKEND_SERVICE_PORT`     | The port of the backend service.                        | `8080`                                   |

### **Backend Environment Variables**

#### Database Configuration

| Variable         | Description                                                        | Example      |
| ---------------- | ------------------------------------------------------------------ | ------------ |
| `DB_ENGINE_TYPE` | The database engine type (`POSTGRES`, `MONGO`, etc.).              | `POSTGRES`   |
| `DB_PROTOCOL`    | The database connection protocol.                                  | `postgresql` |
| `DB_USER`        | The database username.                                             | `news_user`  |
| `DB_PASSWORD`    | The database password. **(Should be a secret)** | `s3cr3t_p4ss`|
| `DB_HOST`        | The internal Kubernetes service hostname for the database.         | `postgresql-prod-client.default.svc.cluster.local` |
| `DB_PORT`        | The port for the database service.                                 | `5432`       |
| `DB_NAME`        | The name of the database.                                          | `newsdb_prod`|

#### Storage Configuration

| Variable                | Description                                                                                                   | Example                      |
| ----------------------- | ------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| `STORAGE_TYPE`          | The storage backend type (`AWS_S3` or `DISK`).                                                                | `AWS_S3`                     |
| `AWS_ACCESS_KEY_ID`     | AWS Access Key ID. **(Required if `STORAGE_TYPE` is `AWS_S3`)** | `AKIA...`                    |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Access Key. **(Required if `STORAGE_TYPE` is `AWS_S3`; should be a secret)** | `wJal...`                    |
| `AWS_REGION`            | The AWS region for the S3 bucket. **(Required if `STORAGE_TYPE` is `AWS_S3`)** | `us-east-1`                  |
| `AWS_BUCKET`            | The name of the S3 bucket. **(Required if `STORAGE_TYPE` is `AWS_S3`)** | `my-app-data-bucket`         |
| `DISK_ROOT_PATH`        | The root path on the disk for local storage. **(Required if `STORAGE_TYPE` is `DISK`)** | `/data/movies`               |

#### Build Information

| Variable             | Description                              | Example   |
| -------------------- | ---------------------------------------- | --------- |
| `BACKEND_GIT_BRANCH` | Git branch of the backend build.         | `main`    |
| `BACKEND_GIT_COMMIT` | Git commit SHA of the backend build.     | `e4f5g6h` |