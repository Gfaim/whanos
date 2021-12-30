package main

import (
	v1 "k8s.io/api/core/v1"
	"sigs.k8s.io/yaml"
)

type WhanosResources struct {
	Limits   *v1.ResourceList `json:"limits,omitempty"`
	Requests *v1.ResourceList `json:"requests,omitempty"`
}

type WhanosDeployment struct {
	Replicas  *int32           `yaml:"replicas,omitempty"`
	Resources *WhanosResources `yaml:"resources,omitempty"`
	Ports     *[]int32         `yaml:"ports,omitempty"`
}

type WhanosConfig struct {
	Deployment WhanosDeployment `yaml:"deployment"`
}

func parseConfig(config string) (cfg WhanosConfig) {
	if err := yaml.Unmarshal([]byte(config), &cfg); err != nil {
		panic(err)
	}
	return cfg
}
