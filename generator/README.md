# Kubernetes Code Generator Binary Files

## Building all generator binary files
Run the below command to generate all file binary files from kubernetes project. Here only the openapi generator comes from different repository.

### Global Variable
Use following global variable to point to your kubernetes and openapi repository. `K8S_PATH` points to kubernetes repo and `OPENAPI_GENERATOR_PKG_PATH` point to openapi repository

```bash
K8S_PATH=<kubernetes_repo_path> OPENAPI_GENERATOR_PKG_PATH=<openapi_repo_path> ./build-binary.sh
```

**Example:**
```bash
K8S_PATH=$HOME/opensource/kubernetes OPENAPI_GENERATOR_PKG_PATH=$HOME/opensource/kube-openapi ./build-binary.sh
```


