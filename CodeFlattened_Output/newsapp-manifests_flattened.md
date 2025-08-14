Repository Summary:
Files analyzed: 28
Directories scanned: 229
Total size: 30.04 KB (30765 bytes)
Estimated tokens: 7691
Processing time: 0.14 seconds


## Table of Contents

- [Project Summary](#project-summary)
- [Directory Structure](#directory-structure)
- [Files Content](#files-content)
  - Files By Category:
    - Configuration (23 files):
      - [Chart.yaml](#Chart_yaml) - 161 bytes
      - [Chart.yaml](#Chart_yaml) - 123 bytes
      - [deployment.yaml](#deployment_yaml) - 2.5 KB
      - [dev.yaml](#dev_yaml) - 368 bytes
      - [dev.yaml](#dev_yaml) - 405 bytes
      - [dev.yaml](#dev_yaml) - 178 bytes
      - [hpa.yaml](#hpa_yaml) - 823 bytes
      - [ingress.yaml](#ingress_yaml) - 885 bytes
      - [prepare-storage.yaml](#prepare-storage_yaml) - 835 bytes
      - [prod.yaml](#prod_yaml) - 240 bytes
      - [and 13 more Configuration files...]
    - Documentation (1 files):
      - [README.md](#README_md) - 472 bytes
    - Other (4 files):
      - [.flatten_ignore](#_flatten_ignore) - 2.1 KB
      - [.helmignore](#_helmignore) - 48 bytes
      - [LICENSE](#LICENSE) - 11.3 KB
      - [needed_envs](#needed_envs) - 268 bytes
- [Architecture and Relationships](#architecture-and-relationships)
  - [File Dependencies](#file-dependencies)
  - [Class Relationships](#class-relationships)
  - [Component Interactions](#component-interactions)

## Project Summary <a id="project-summary"></a>

# Project Digest: newsapp-manifests
Generated on: Thu Aug 14 2025 23:18:17 GMT+0300 (Israel Daylight Time)
Source: c:\Users\Lenovo\newsapp-manifests
Project Directory: c:\Users\Lenovo\newsapp-manifests

# Directory Structure
[DIR] .
  [DIR] .git
  [DIR] .vscode
  [DIR] charts
    [DIR] app
      [FILE] .helmignore
      [FILE] Chart.yaml
      [DIR] templates
        [FILE] deployment.yaml
        [FILE] hpa.yaml
        [FILE] ingress.yaml
        [FILE] service.yaml
      [FILE] values.yaml
    [DIR] mysql
      [FILE] Chart.yaml
      [DIR] templates
        [FILE] prepare-storage.yaml
        [FILE] pv.yaml
        [FILE] pvc.yaml
        [FILE] service.yaml
        [FILE] statefulset.yaml
      [FILE] values.yaml
  [DIR] clusters
    [DIR] dev
      [DIR] apps
        [FILE] stack.yaml
      [FILE] project.yaml
    [DIR] prod
      [DIR] apps
        [FILE] stack.yaml
      [FILE] project.yaml
  [DIR] CodeFlattened_Output
  [DIR] flattened
    [FILE] .flatten_ignore
  [FILE] LICENSE
  [FILE] needed_envs
  [FILE] README.md
  [DIR] sealed
    [DIR] backend
      [DIR] dev
      [DIR] prod
  [DIR] values
    [DIR] backend
      [FILE] dev.yaml
      [FILE] prod.yaml
    [DIR] frontend
      [FILE] dev.yaml
      [FILE] prod.yaml
    [DIR] mysql
      [FILE] dev.yaml
      [FILE] prod.yaml

# Files Content

## README.md <a id="README_md"></a>

# newsapp-manifests

Single reusable Helm chart (`charts/app`) for backend & frontend.
Environment values in `values/<service>/<env>.yaml`.

## Local render test (requires Helm)
helm template backend-dev charts/app -f values/backend/dev.yaml
helm template frontend-prod charts/app -f values/frontend/prod.yaml

## Argo CD
- Apply projects and apps from `clusters/dev` or `clusters/prod`.
- Argo CD v2.9 supports `spec.sources` for multi-repo/values reference.

## charts\app\Chart.yaml <a id="Chart_yaml"></a>

apiVersion: v2
name: app
description: Generic deployment chart for simple web apps (backend/frontend)
type: application
version: 0.1.0
appVersion: "1.0.0"

## flattened\.flatten_ignore <a id="flatten_ignore"></a>

# .flatten_ignore
# This file controls which files and directories are ignored or explicitly included during flattening.
# Use glob patterns here. When a directory is specified without wildcards, it is automatically treated as "directory/**".
#
# --------------------------
# Global Ignore Patterns:
# These patterns are always ignored, regardless of other settings
global:
# Build and dependency directories
node_modules
bower_components
vendor
dist
build
out
target
tmp
temp
.cache
__pycache__
.git
.vscode
.idea
.pnp
.jest
.mocha
.nyc_output
test-results
reports
.gradle
android
ios
# Package manager files
package-lock.json
yarn.lock
pnpm-lock.yaml
composer.lock
Gemfile.lock
poetry.lock
requirements.txt
go.sum
Cargo.lock
# Generated files
 * .min.js
 * .min.css
 * .map
 * .bundle.*
 * .chunk.*
# Documentation
docs/api
docs/generated
api-docs
jsdoc
javadoc
swagger
# Test and example files
test
tests
spec
__tests__
__mocks__
fixtures
mocks
stubs
test-data
test-utils
testing-utils
examples
demo
samples
# Environment and configuration
.env
.env.*
config
configs
settings
# IDE and editor files
.vscode
.idea
.vs
.project
.settings
.classpath
.factorypath
# Version control
.git
.svn
.hg
# Temporary files
 * .tmp
 * .temp
 * .bak
 * .log
logs
# --------------------------
# Local Whitelist Patterns:
# These patterns are always included, even if they match global ignore patterns
whitelist:
# Example:
# src/**
# lib/**/*.js
# --------------------------
# Local Blacklist Patterns:
# These patterns are ignored in addition to global patterns
blacklist:
# Example:
# test/**
# *.spec.js
# --------------------------
# Settings:
# Configure token limits and other processing options
settings:
# Token limits for different LLMs (characters, ~4 chars per token):
# - Claude 3 Opus: ~800K chars (200K tokens)
# - Claude 3 Sonnet: ~512K chars (128K tokens) [DEFAULT]
# - GPT-4 Turbo: ~512K chars (128K tokens)
# - Claude 2: ~400K chars (100K tokens)
# - GPT-4: ~128K chars (32K tokens)
# - GPT-3.5 Turbo: ~64K chars (16K tokens)
maxTokenLimit: 128000
maxTokensPerFile: 25000
# Processing options
useGitIgnore: true
maxConcurrentFiles: 4

## charts\app\.helmignore <a id="helmignore"></a>

.git/
.github/
.vscode/
*.swp
*.bak
*.tmp

## values\backend\dev.yaml <a id="dev_yaml"></a>

app: {name: backend, type: backend}
fullnameOverride: backend
image:
  repository: elipavlov/newsapp-backend
  tag: latest-6b42e0e
service:
  type: ClusterIP
  port: 8080
# keep if you want to pin nodes; otherwise remove this block
# nodeSelector: { kubernetes.io/hostname: node-2 }
env:
  plain:
    DB_ENGINE_TYPE: "MYSQL"
  secretRef: backend-secrets

## charts\mysql\Chart.yaml <a id="Chart_yaml"></a>

apiVersion: v2
name: mysql
description: Minimal MySQL for newsapp
type: application
version: 0.1.0
appVersion: "8.0"

## charts\app\templates\deployment.yaml <a id="deployment_yaml"></a>

### Dependencies

- `{{ .Values.image.repository }}:{{ .Values.image.tag }}`

apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "app.fullname" . }}
  labels:
    app.kubernetes.io/name: {{ include "app.name" . }}
  annotations:
    {{- /* Sync waves: backend=1, frontend=2 */ -}}
    {{- $wave := "1" -}}
    {{- if eq .Values.app.type "frontend" }}{{- $wave = "2" }}{{- end }}
    argocd.argoproj.io/sync-wave: "{{ $wave }}"
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app.kubernetes.io/name: {{ include "app.name" . }}
  template:
    metadata:
      labels:
        app.kubernetes.io/name: {{ include "app.name" . }}
    spec:
      {{- if .Values.imagePullSecrets }}
      imagePullSecrets:
{{ toYaml .Values.imagePullSecrets | indent 8 }}
      {{- end }}
      {{- if .Values.nodeSelector }}
      nodeSelector:
{{ toYaml .Values.nodeSelector | indent 8 }}
      {{- end }}
      {{- if .Values.tolerations }}
      tolerations:
{{ toYaml .Values.tolerations | indent 8 }}
      {{- end }}
      {{- if .Values.affinity }}
      affinity:
{{ toYaml .Values.affinity | indent 8 }}
      {{- end }}
      containers:
        - name: {{ include "app.name" . }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: {{ .Values.service.port }}
              name: http
              {{- if .Values.service.hostPort }}
              hostPort: {{ .Values.service.hostPort }}
              {{- end }}
          # Always pass the pod's namespace (used by FE nginx entrypoint for backend DNS)
          env:
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            {{- range $k, $v := .Values.env.plain }}
            - name: {{ $k }}
              value: "{{ $v }}"
            {{- end }}
          {{- if or .Values.env.secretRef .Values.env.configRef }}
          envFrom:
            {{- if .Values.env.configRef }}
            - configMapRef: { name: {{ .Values.env.configRef }} }
            {{- end }}
            {{- if .Values.env.secretRef }}
            - secretRef: { name: {{ .Values.env.secretRef }} }
            {{- end }}
          {{- end }}
          {{- if .Values.securityContext.addNetBindService }}
          securityContext:
            capabilities: { add: ["NET_BIND_SERVICE"] }
          {{- end }}
          resources:
{{ toYaml .Values.resources | indent 12 }}

## values\frontend\dev.yaml <a id="dev_yaml"></a>

app: {name: frontend, type: frontend}
image:
  repository: elipavlov/newsapp-frontend
  tag: latest-ee2e95e
service:
  type: ClusterIP
  port: 80
  hostPort: 3080
nodeSelector: {kubernetes.io/hostname: node-1}
securityContext:
  addNetBindService: true
env:
  plain:
    VITE_SERVER_URL: "/api"
    VITE_NEWS_INTERVAL_IN_MIN: "5"
    BACKEND_SERVICE_HOST: ""
    BACKEND_SERVICE_PORT: ""

## values\mysql\dev.yaml <a id="dev_yaml"></a>

nodeSelector:
  kubernetes.io/hostname: node-3

mysql:
  secretName: mysql-credentials

persistence:
  enabled: true
  existingClaim: mysql-pvc-development
  size: 5Gi

## charts\app\templates\hpa.yaml <a id="hpa_yaml"></a>

{{- if .Values.hpa.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "app.fullname" . }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "app.fullname" . }}
  minReplicas: {{ .Values.hpa.minReplicas }}
  maxReplicas: {{ .Values.hpa.maxReplicas }}
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ .Values.hpa.targetCPUUtilizationPercentage }}
    {{- if .Values.hpa.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ .Values.hpa.targetMemoryUtilizationPercentage }}
    {{- end }}
{{- end }}

## charts\app\templates\ingress.yaml <a id="ingress_yaml"></a>

{{- if .Values.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "app.fullname" . }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if .Values.ingress.className }}
  ingressClassName: {{ .Values.ingress.className }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType }}
            backend:
              service:
                name: {{ include "app.fullname" $ }}
                port:
                  number: {{ $.Values.service.port }}
          {{- end }}
    {{- end }}
  {{- with .Values.ingress.tls }}
  tls:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

## LICENSE <a id="LICENSE"></a>

                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

   Copyright [yyyy] [name of copyright owner]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

## values\backend\prod.yaml <a id="prod_yaml"></a>

﻿app: { name: backend, type: backend }
fullnameOverride: backend

image:
  repository: elipavlov/newsapp-backend
  tag: latest

service:
  type: ClusterIP
  port: 8080

env:
  plain:
    DB_ENGINE_TYPE: "MYSQL"
  secretRef: backend-secrets

## charts\mysql\templates\prepare-storage.yaml <a id="prepare-storage_yaml"></a>

### Dependencies

- `alpine:3.20`

apiVersion: batch/v1
kind: Job
metadata:
  name: mysql-prepare-storage
  labels:
    app.kubernetes.io/name: mysql
spec:
  backoffLimit: 2
  template:
    spec:
      restartPolicy: OnFailure
      nodeSelector:
{{- if .Values.nodeSelector }}
{{ toYaml .Values.nodeSelector | indent 8 }}
{{- end }}
      containers:
        - name: mkdir
          image: alpine:3.20
          command: ["/bin/sh","-c"]
          args:
            - |
              set -e
              mkdir -p /mnt/data/mysql-{{ .Release.Namespace }}
              echo "Ensured /mnt/data/mysql-{{ .Release.Namespace }}"
          volumeMounts:
            - name: host-mnt
              mountPath: /mnt/data
      volumes:
        - name: host-mnt
          hostPath:
            path: /mnt/data
            type: DirectoryOrCreate

## needed_envs <a id="needed_envs"></a>

VITE_SERVER_URL= {{VITE_SERVER_URL}}
VITE_NEWS_INTERVAL_IN_MIN= {{VITE_NEWS_INTERVAL_IN_MIN}}
# MONGO | MONGOOSE | POSTGRES | MYSQL
DB_ENGINE_TYPE={{DB_ENGINE_TYPE}}
# connection string : [protocol]://[username]:[password]@[host]/[database name]
DB_URI={{DB_URI}}
## values\mysql\prod.yaml <a id="prod_yaml"></a>

nodeSelector:
  kubernetes.io/hostname: node-3

mysql:
  secretName: mysql-credentials

persistence:
  enabled: true
  existingClaim: mysql-pvc-default
  size: 20Gi

## values\frontend\prod.yaml <a id="prod_yaml"></a>

﻿app: { name: frontend, type: frontend }

image:
  repository: elipavlov/newsapp-frontend
  tag: latest

service:
  type: ClusterIP
  port: 80
  hostPort: 80
nodeSelector: { kubernetes.io/hostname: node-1 }

securityContext:
  addNetBindService: true

env:
  plain:
    # FE talks to its own Nginx at /api; actions set the proxy target each deploy.
    VITE_SERVER_URL: "/api"
    VITE_NEWS_INTERVAL_IN_MIN: "5"
    BACKEND_SERVICE_HOST: "backend.default.svc.cluster.local"
    BACKEND_SERVICE_PORT: "8080"

## clusters\dev\project.yaml <a id="project_yaml"></a>

﻿apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: newsapp-dev
  namespace: argocd
spec:
  description: Development project for newsapp
  sourceRepos:
    - https://github.com/eli-pavlov/newsapp-manifests.git
  destinations:
    - namespace: development
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'
  namespaceResourceWhitelist:
    - group: '*'
      kind: '*'

## clusters\prod\project.yaml <a id="project_yaml"></a>

﻿apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: newsapp-prod
  namespace: argocd
spec:
  description: Production project for newsapp
  sourceRepos:
    - https://github.com/eli-pavlov/newsapp-manifests.git
  destinations:
    - namespace: default
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'
  namespaceResourceWhitelist:
    - group: '*'
      kind: '*'

## charts\mysql\templates\pv.yaml <a id="pv_yaml"></a>

apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv-{{ .Release.Namespace }}
  labels:
    app.kubernetes.io/name: mysql
spec:
  capacity:
    storage: {{ .Values.persistence.size | default "10Gi" }}
  accessModes: ["ReadWriteOnce"]
  storageClassName: local-path
  local:
    path: /mnt/data/mysql-{{ .Release.Namespace }}
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
{{- if .Values.nodeSelector }}
{{- if hasKey .Values.nodeSelector "kubernetes.io/hostname" }}
                - {{ .Values.nodeSelector."kubernetes.io/hostname" | quote }}
{{- end }}
{{- else }}
                - "node-3"
{{- end }}

## charts\mysql\templates\service.yaml <a id="service_yaml"></a>

apiVersion: v1
kind: Service
metadata:
  name: mysql
  labels:
    app.kubernetes.io/name: mysql
spec:
  type: ClusterIP
  selector:
    app.kubernetes.io/name: mysql
  ports:
    - name: mysql
      port: 3306
      targetPort: 3306

## charts\mysql\templates\pvc.yaml <a id="pvc_yaml"></a>

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Values.persistence.existingClaim | default (printf "mysql-pvc-%s" .Release.Namespace) }}
spec:
  accessModes: ["ReadWriteOnce"]
  resources:
    requests:
      storage: {{ .Values.persistence.size | default "10Gi" }}
  storageClassName: local-path
  volumeName: mysql-pv-{{ .Release.Namespace }}

## clusters\dev\apps\stack.yaml <a id="stack_yaml"></a>

apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: newsapp-dev
  namespace: argocd
spec:
  project: newsapp-dev
  destination:
    server: https://kubernetes.default.svc
    namespace: development
  sources:
    # 0) SealedSecrets (namespace-scoped to "development")
    - repoURL: https://github.com/eli-pavlov/newsapp-manifests.git
      targetRevision: main
      path: sealed/backend/dev
      directory:
        recurse: true

    # 1) DB (PV/PVC + StatefulSet + Service) on node-3
    - repoURL: https://github.com/eli-pavlov/newsapp-manifests.git
      targetRevision: main
      path: charts/mysql
      helm:
        releaseName: mysql
        valueFiles:
          - values/mysql/dev.yaml

    # 2) Backend (uses backend-secrets.DB_URI)
    - repoURL: https://github.com/eli-pavlov/newsapp-manifests.git
      targetRevision: main
      path: charts/app
      helm:
        releaseName: backend
        valueFiles:
          - values/backend/dev.yaml

    # 3) Frontend (Nginx proxies to backend-app.development.svc.cluster.local:8080)
    - repoURL: https://github.com/eli-pavlov/newsapp-manifests.git
      targetRevision: main
      path: charts/app
      helm:
        releaseName: frontend
        valueFiles:
          - values/frontend/dev.yaml

  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - ApplyOutOfSyncOnly=true
      - RespectIgnoreDifferences=true

## clusters\prod\apps\stack.yaml <a id="stack_yaml"></a>

apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: newsapp-prod
  namespace: argocd
spec:
  project: newsapp-prod
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  sources:
    # 0) SealedSecrets (namespace-scoped to "default")
    - repoURL: https://github.com/eli-pavlov/newsapp-manifests.git
      targetRevision: main
      path: sealed/backend/prod
      directory:
        recurse: true

    # 1) DB (PV/PVC + StatefulSet + Service) on node-3
    - repoURL: https://github.com/eli-pavlov/newsapp-manifests.git
      targetRevision: main
      path: charts/mysql
      helm:
        releaseName: mysql
        valueFiles:
          - values/mysql/prod.yaml

    # 2) Backend (uses backend-secrets.DB_URI)
    - repoURL: https://github.com/eli-pavlov/newsapp-manifests.git
      targetRevision: main
      path: charts/app
      helm:
        releaseName: backend
        valueFiles:
          - values/backend/prod.yaml

    # 3) Frontend (Nginx proxies to backend-app.default.svc.cluster.local:8080)
    - repoURL: https://github.com/eli-pavlov/newsapp-manifests.git
      targetRevision: main
      path: charts/app
      helm:
        releaseName: frontend
        valueFiles:
          - values/frontend/prod.yaml

  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - ApplyOutOfSyncOnly=true
      - RespectIgnoreDifferences=true

## charts\mysql\templates\statefulset.yaml <a id="statefulset_yaml"></a>

### Dependencies

- `mysql:8.0`

apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
  labels:
    app.kubernetes.io/name: mysql
spec:
  serviceName: mysql
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: mysql
  template:
    metadata:
      labels:
        app.kubernetes.io/name: mysql
    spec:
{{- if .Values.nodeSelector }}
      nodeSelector:
{{ toYaml .Values.nodeSelector | indent 8 }}
{{- end }}
      containers:
        - name: mysql
          image: mysql:8.0
          imagePullPolicy: IfNotPresent
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom: { secretKeyRef: { name: {{ .Values.mysql.secretName | quote }}, key: MYSQL_ROOT_PASSWORD } }
            - name: MYSQL_DATABASE
              valueFrom: { secretKeyRef: { name: {{ .Values.mysql.secretName | quote }}, key: MYSQL_DATABASE } }
            - name: MYSQL_USER
              valueFrom: { secretKeyRef: { name: {{ .Values.mysql.secretName | quote }}, key: MYSQL_USER } }
            - name: MYSQL_PASSWORD
              valueFrom: { secretKeyRef: { name: {{ .Values.mysql.secretName | quote }}, key: MYSQL_PASSWORD } }
          ports:
            - containerPort: 3306
              name: mysql
          volumeMounts:
            - name: data
              mountPath: /var/lib/mysql
{{- if .Values.persistence.existingClaim }}
      volumes:
        - name: data
          persistentVolumeClaim:
            claimName: {{ .Values.persistence.existingClaim }}
{{- else }}
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: {{ .Values.persistence.size | default "10Gi" }}
        storageClassName: local-path
{{- end }}

## charts\app\values.yaml <a id="values_yaml"></a>

app:
  name: app
  type: backend # or "frontend"

image:
  repository: ""
  tag: "latest"
  pullPolicy: IfNotPresent

replicaCount: 1

service:
  type: ClusterIP   # ClusterIP | NodePort
  port: 80          # container & service port for the app
  nodePort: null    # e.g. 30001 for backend
  hostPort: null    # e.g. 80 for prod FE, 3080 for dev FE

resources: {}

nodeSelector: {}
tolerations: []
affinity: []

imagePullSecrets: []

env:
  plain: {}       # e.g. VITE_* or DB_ENGINE_TYPE
  secretRef: ""   # e.g. backend-secrets (DB_URI)
  configRef: ""

securityContext:
  addNetBindService: false # needed if binding <1024 like port 80 as non-root

## charts\app\templates\service.yaml <a id="service_yaml"></a>

apiVersion: v1
kind: Service
metadata:
  name: {{ include "app.fullname" . }}
  labels:
    app.kubernetes.io/name: {{ include "app.name" . }}
  annotations:
    {{- /* Sync waves: backend=1, frontend=2 */ -}}
    {{- $wave := "1" -}}
    {{- if eq .Values.app.type "frontend" }}{{- $wave = "2" }}{{- end }}
    argocd.argoproj.io/sync-wave: "{{ $wave }}"
spec:
  type: {{ .Values.service.type }}
  selector:
    app.kubernetes.io/name: {{ include "app.name" . }}
  ports:
    - name: http
      port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.port }}
      {{- if and (eq .Values.service.type "NodePort") .Values.service.nodePort }}
      nodePort: {{ .Values.service.nodePort }}
      {{- end }}

## charts\mysql\values.yaml <a id="values_yaml"></a>

image:
  repository: mysql
  tag: "8.0"
  pullPolicy: IfNotPresent

mysql:
  database: newsapp
  port: 3306
  # Populated via Secret the CI creates:
  secretName: mysql-credentials  # keys: MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD

persistence:
  enabled: true
  storageClass: ""   # set if your cluster needs an explicit class
  size: 10Gi

nodeSelector: {}     # e.g. { kubernetes.io/hostname: node-3 }
tolerations: []
affinity: {}

service:
  type: ClusterIP
  port: 3306
## Code Visualization


### Architecture and Relationships

These diagrams visualize code relationships at different levels of abstraction.

### File Dependencies

This diagram shows dependencies between individual source files.

#

Below is a visualization of file dependencies in the codebase:

```mermaid
graph LR
  F1_c:\Users\Lenovo\newsapp-manifests_README.md["README.md"]
  F2_c:\Users\Lenovo\newsapp-manifests\charts\app_Chart.yaml["Chart.yaml"]
  F3_c:\Users\Lenovo\newsapp-manifests\flattened_.flatten_ignore[".flatten_ignore"]
  F4_c:\Users\Lenovo\newsapp-manifests\charts\app_.helmignore[".helmignore"]
  F5_c:\Users\Lenovo\newsapp-manifests\values\backend_dev.yaml["dev.yaml"]
  F6_c:\Users\Lenovo\newsapp-manifests\charts\mysql_Chart.yaml["Chart.yaml"]
  F7_c:\Users\Lenovo\newsapp-manifests\charts\app\templates_deployment.yaml["deployment.yaml"]
  F8_c:\Users\Lenovo\newsapp-manifests\values\frontend_dev.yaml["dev.yaml"]
  F9_c:\Users\Lenovo\newsapp-manifests\values\mysql_dev.yaml["dev.yaml"]
  F10_c:\Users\Lenovo\newsapp-manifests\charts\app\templates_hpa.yaml["hpa.yaml"]
  F11_c:\Users\Lenovo\newsapp-manifests\charts\app\templates_ingress.yaml["ingress.yaml"]
  F12_c:\Users\Lenovo\newsapp-manifests_LICENSE["LICENSE"]
  F13_c:\Users\Lenovo\newsapp-manifests\values\backend_prod.yaml["prod.yaml"]
  F14_c:\Users\Lenovo\newsapp-manifests\charts\mysql\templates_prepare-storage.yaml["prepare-storage.yaml"]
  F15_c:\Users\Lenovo\newsapp-manifests_needed_envs["needed_envs"]
  F16_c:\Users\Lenovo\newsapp-manifests\values\mysql_prod.yaml["prod.yaml"]
  F17_c:\Users\Lenovo\newsapp-manifests\values\frontend_prod.yaml["prod.yaml"]
  F18_c:\Users\Lenovo\newsapp-manifests\clusters\dev_project.yaml["project.yaml"]
  F19_c:\Users\Lenovo\newsapp-manifests\clusters\prod_project.yaml["project.yaml"]
  F20_c:\Users\Lenovo\newsapp-manifests\charts\mysql\templates_pv.yaml["pv.yaml"]
  F21_c:\Users\Lenovo\newsapp-manifests\charts\mysql\templates_pvc.yaml["pvc.yaml"]
  F22_c:\Users\Lenovo\newsapp-manifests\charts\mysql\templates_service.yaml["service.yaml"]
  F23_c:\Users\Lenovo\newsapp-manifests\clusters\dev\apps_stack.yaml["stack.yaml"]
  F24_c:\Users\Lenovo\newsapp-manifests\clusters\prod\apps_stack.yaml["stack.yaml"]
  F25_c:\Users\Lenovo\newsapp-manifests\charts\mysql\templates_statefulset.yaml["statefulset.yaml"]
  F26_c:\Users\Lenovo\newsapp-manifests\charts\app\templates_service.yaml["service.yaml"]
  F27_c:\Users\Lenovo\newsapp-manifests\charts\app_values.yaml["values.yaml"]
  F28_c:\Users\Lenovo\newsapp-manifests\charts\mysql_values.yaml["values.yaml"]
```

### Class Relationships

This diagram shows inheritance and associations between classes.

```mermaid
classDiagram
```


```mermaid
graph LR
A["Main"] --> B["Utils"]
```

<!-- TEST VISUALIZATION MARKER -->

```mermaid
graph LR
A["Main"] --> B["Utils"]
```
