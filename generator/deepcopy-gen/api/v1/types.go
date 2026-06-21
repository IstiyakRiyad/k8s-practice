package v1

import metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

// For signle struct deepcopy implementation
// +k8s:deepcopy-gen=true
type ServerSpec struct {
	Replicas     int32             `json:"replicas"`
	Image        string            `json:"image"`
	Port         int32             `json:"port"`
	Environments map[string]string `json:"environments"`
}

// For signle struct deepcopy implementation
// +k8s:deepcopy-gen=true
type ServerStatus struct {
	ReadyReplicas int32 `json:"readyReplicas,omitempty"`
	Conditions    []metav1.Condition
}

// For signle struct deepcopy implementation
// +k8s:deepcopy-gen=true
type Server struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`
	Spec              ServerSpec   `json:"spec,omitempty"`
	Status            ServerStatus `json:"status,omitempty"`
}

type ServerList struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`
	Items             []Server `json:"items"`
}
