# Helm resources

# Install cert-manager helm chart
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  chart            = "https://charts.jetstack.io/charts/cert-manager-v${var.cert_manager_version}.tgz"
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true
  wait_for_jobs    = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "image.repository"
    value = "cnrancher/mirrored-jetstack-cert-manager-controller"
  }

  set {
    name  = "webhook.image.repository"
    value = "cnrancher/mirrored-jetstack-cert-manager-webhook"
  }

  set {
    name  = "cainjector.image.repository"
    value = "cnrancher/mirrored-jetstack-cert-manager-cainjector"
  }

  set {
    name  = "startupapicheck.image.repository"
    value = "cnrancher/mirrored-jetstack-cert-manager-ctl"
  }
}

# Install Rancher helm chart
resource "helm_release" "rancher_server" {
  depends_on = [
    helm_release.cert_manager,
  ]

  name             = "rancher"
  chart            = "${var.rancher_helm_repository}/rancher-${var.rancher_version}.tgz"
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true
  wait_for_jobs    = true

  set {
    name  = "hostname"
    value = var.rancher_server_dns
  }

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "bootstrapPassword"
    value = "admin" # TODO: change this once the terraform provider has been updated with the new pw bootstrap logic
  }
}
