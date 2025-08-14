# newsapp-manifests

Single reusable Helm chart (`charts/app`) for backend & frontend.
Environment values in `values/<service>/<env>.yaml`.

## Local render test (requires Helm)
helm template backend-dev charts/app -f values/backend/dev.yaml
helm template frontend-prod charts/app -f values/frontend/prod.yaml

## Argo CD
- Apply projects and apps from `clusters/dev` or `clusters/prod`.
- Argo CD v2.9 supports `spec.sources` for multi-repo/values reference.
