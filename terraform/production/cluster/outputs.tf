output "rancher2_default_project_id" {
  value = module.drydock_cluster.rancher2_default_project_id
}

output "rancher2_cluster_registration_token" {
  value = module.drydock_cluster.rancher2_cluster_registration_token
}

output "do_kubeconfig" {
  value = module.drydock_cluster.do_kubeconfig
  sensitive = true
}