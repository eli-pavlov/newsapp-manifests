<div align='center'>
<img src="https://raw.githubusercontent.com/eli-pavlov/github-actions-cicd-project/master/docs/githubactions.png" width=320 />
<h1> GitOps Manifests for CI/CD Project </h1>

<p> Kubernetes manifests & Kustomize overlays for automated GitOps deployments via Argo CD. </p>

<h4>
  <span> · </span>
  <a href="https://github.com/eli-pavlov/github-actions-cicd-manifests/blob/main/README.md"> Documentation </a>
  <span> · </span>
  <a href="https://github.com/eli-pavlov/github-actions-cicd-project/issues"> Report Bug </a>
  <span> · </span>
  <a href="https://github.com/eli-pavlov/github-actions-cicd-project/issues"> Request Feature </a>
</h4>

$\~\~\$

</div>


$\~\~\$

\:bookmark\_tabs: Table of Contents

* [Architecture Diagram](#world_map-gitops-architecture-diagram)
* [About This Repo](#star2-about-this-repo)
* [Kustomize & Overlay Structure](#gear-kustomize--overlay-structure)
* [Argo CD Integration](#rocket-argo-cd-integration)
* [How to Deploy](#wrench-how-to-deploy)
* [Directory Structure](#open_file_folder-directory-structure)
* [Workflow: How Updates Happen](#arrows_clockwise-workflow-how-updates-happen)
* [License](#warning-license)
* [Contact](#handshake-contact)
* [Acknowledgements](#gem-acknowledgements)

$\~\~\$

## \:star2: About This Repo

This repository contains the **Kubernetes manifests** and **Kustomize overlays** for The CI/CD Gitops Project.

It is managed and updated automatically by the CI/CD pipeline of the [app repo](https://github.com/eli-pavlov/github-actions-cicd-project), and synchronized to Kubernetes clusters by [Argo CD](https://argo-cd.readthedocs.io/en/stable/).

**Key Features:**

* Clean separation of base manifests and environment overlays (development/production)
* Automated image tag updates by GitHub Actions workflow
* Declarative, auditable infrastructure-as-code for Kubernetes
* Argo CD Application CRs for hands-free GitOps deployments

$\~\~\$

## \:gear: Kustomize & Overlay Structure

Kustomize overlays enable environment-specific configuration:

| Folder                  | Purpose                                             |
| ----------------------- | --------------------------------------------------- |
| `base/`                 | Shared Deployment/Service specs                     |
| `overlays/development/` | Dev-specific patches (ports, image tags, resources) |
| `overlays/production/`  | Prod-specific patches (scaling, ports, image tags)  |
| `argocd/`               | Argo CD Application manifests                       |

Example overlay structure:

```
manifests/
├── base/
├── overlays/
│   ├── development/
│   └── production/
└── argocd/
```

$\~\~\$

## \:rocket: Argo CD Integration

Argo CD tracks this repo for changes and syncs the desired state to your Kubernetes cluster:

* **Dev environment:**
  Watches `overlays/development`
  Deploys automatically on commit
* **Prod environment:**
  Watches `overlays/production`
  Manual approval via GitHub Environment before deployment

To register the Applications, run:

```bash
kubectl apply -f manifests/argocd/application-dev.yaml
kubectl apply -f manifests/argocd/application-prod.yaml
```

$\~\~\$

## \:wrench: How to Deploy

**Automated via CI/CD:**

* On every code push and Docker image build, the app repo pipeline:

  * Updates the correct overlay’s `kustomization.yaml` with the new image tag (e.g. `dev-abcdefg` or `latest-abcdefg`)
  * Commits & pushes the change here
  * Argo CD auto-syncs and deploys

**Manual (for troubleshooting):**

1. Update image tag in the relevant `kustomization.yaml`:

   ```sh
   cd manifests/overlays/development   # or production
   kustomize edit set image elipavlov/rtproject=elipavlov/rtproject:dev-abcdefg
   git commit -am "Update image tag"
   git push
   ```
2. Argo CD will detect the change and redeploy.

$\~\~\$

## \:open\_file\_folder: Directory Structure

```
github-actions-cicd-manifests/
├── LICENSE
├── README.md
└── manifests/
    ├── base/
    │   ├── deployment.yaml
    │   ├── kustomization.yaml
    │   └── service.yaml
    ├── overlays/
    │   ├── development/
    │   │   ├── kustomization.yaml
    │   │   ├── patch-deployment.yaml
    │   │   └── patch-service.yaml
    │   └── production/
    │       ├── kustomization.yaml
    │       ├── patch-deployment.yaml
    │       └── patch-service.yaml
    └── argocd/
        ├── application-dev.yaml
        └── application-prod.yaml
```

$\~\~\$

## \:arrows\_clockwise: Workflow: How Updates Happen

1. **Code is pushed** to app repo
2. **CI/CD pipeline builds/pushes image**, updates overlay in this repo with new tag
3. **Change is committed and pushed** here
4. **Argo CD detects change** and syncs to cluster
5. **Kubernetes deployment updated** with new image

$\~\~\$

## \:warning: License

Distributed under the Apache 2.0 License.

This repo contains only infrastructure code.
See the [app repo](https://github.com/eli-pavlov/github-actions-cicd-project) for application code licensing.

$\~\~\$

## \:handshake: Contact

**Eli Pavlov**
[www.weblightenment.com](https://www.weblightenment.com)
[admin@weblightenment.com](mailto:admin@weblightenment.com)

Project Repo: [github-actions-cicd-manifests](https://github.com/eli-pavlov/github-actions-cicd-manifests)

$\~\~\$

## \:gem: Acknowledgements

* [Kubernetes.io](https://kubernetes.io/docs)
* [Kustomize](https://kustomize.io)
* [Argo CD](https://argo-cd.readthedocs.io/en/stable/)
* [GitHub Actions](https://docs.github.com/en/actions)
* [Awesome GitOps](https://github.com/weaveworks/awesome-gitops)
