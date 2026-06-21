# Deepcopy Gen

DeepCopy gen binary is used for implementing golang struct deepcopy and return new object. Here it some function that implements `runtime.Object` interface to file.

The runtime object which get's implemented:
```go
// staging/src/k8s.io/apimachinery/pkg/runtime/interfaces.go:337

import "k8s.io/apimachinery/pkg/runtime/schema"

type Object interface {
	GetObjectKind() schema.ObjectKind
	DeepCopyObject() Object
}
```

Here the `schema.ObjectKind` defination:
```go
// staging/src/k8s.io/apimachinery/pkg/runtime/schema/group_version.go:142
type GroupVersionKind struct {
	Group   string
	Version string
	Kind    string
}

// staging/src/k8s.io/apimachinery/pkg/runtime/schema/interfaces.go:22
type ObjectKind interface {
	SetGroupVersionKind(kind GroupVersionKind)
	GroupVersionKind() GroupVersionKind
}
```

Delete already present deepcopy file. Then run below command. Here we can provide package name or relative path to the projects like `./api/...`
```bash
./deepcopy-gen \
    -v "1" \
    --output-file zz_generated.deepcopy.go \
    --go-header-file "boilerplate.go.txt" \
    --lint-rules known-tags-only,require-explicit-disablement \
    "k8s-deepcopy-gen/api/v1"
```

Here the `doc.go` file where we can define package level deepcopy tags like below. Other name on the same package doesn't support this.

```go
// +k8s:deepcopy-gen=package
```

We can define struct level generator tag by the below tags:
```go
// +k8s:deepcopy-gen=true
```

