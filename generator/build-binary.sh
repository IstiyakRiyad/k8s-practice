#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

K8S_PATH=${K8S_PATH:-$HOME/opensource/kubernetes}
KUBE_GENERATOR_PKG_PATH="${KUBE_GENERATOR_PKG_PATH:-${K8S_PATH}/staging/src/k8s.io/code-generator}"
OPENAPI_GENERATOR_PKG_PATH="${HOME}/opensource/kube-openapi"

K8S_GENERATE_PKGS=(
    applyconfiguration-gen
    client-gen
    conversion-gen
    deepcopy-gen
    defaulter-gen
    go-to-protobuf
    informer-gen
    lister-gen
    prerelease-lifecycle-gen
    register-gen
    validation-gen
)

function kube::generator::generate() {
    local pkg_path=""
    local name=""

    while [ "$#" -gt 0 ]; do
        case "$1" in
            "--pkg_path")
                pkg_path="$2"
                shift 2
                ;;
            *)
                if [[ "$1" =~ ^-- ]]; then
                    echo "invalid argument ${1}" >&2
                    return 1
                fi

                if [ -n "$name" ]; then
                    echo "too many arguments" >&2
                    return 1
                fi

                name="$1"
                shift
                ;;
        esac
    done

    if [ -z "${pkg_path}" ]; then
        echo "pkg path is required" >&2
        return 1
    fi

    if [ -z "${name}" ]; then
        echo "name is required" >&2
        return 1
    fi

    (
        cd $pkg_path
        go build -o "${name}" "./cmd/${name}"
    )

    mkdir -p "./${name}"
    mv "${pkg_path}/${name}" "./${name}"

    # add .gitignore file if not exists
    if [ ! -f "./${name}/.gitignore" ]; then
        echo "${name}" > "./${name}/.gitignore"
    fi
}

# Generate all binary
for name in "${K8S_GENERATE_PKGS[@]}"; do
    echo "generating ${name}"

    kube::generator::generate \
        --pkg_path ${KUBE_GENERATOR_PKG_PATH} \
        "${name}"
done

# build openapi-gen
echo "generating openapi-gen"
kube::generator::generate \
    --pkg_path ${OPENAPI_GENERATOR_PKG_PATH} \
    "openapi-gen"



