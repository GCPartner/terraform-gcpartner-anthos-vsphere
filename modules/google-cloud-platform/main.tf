provider "google" {
  project = var.gcp_project_id
}

locals {
  roles = [
    "roles/serviceusage.serviceUsageAdmin",
    "roles/resourcemanager.projectIamAdmin",
    "roles/iam.serviceAccountCreator",
    "roles/iam.serviceAccountKeyAdmin",
    "roles/storage.objectViewer"
  ]
}

resource "google_service_account" "master_service_account" {
  account_id   = format("%s-master", var.cluster_name)
  display_name = "Anthos on vSphere Master Service Account"
  description  = "Anthos on vSphere Master Service Account"
  project      = var.gcp_project_id
  # TODO: This is an awful hack... It should be a real TF Module rather than local exec, because this won't run on windows for instance. 
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "google_project_iam_member" "role_assignment" {
  for_each = toset(local.roles)
  role     = each.value
  member   = "serviceAccount:${google_service_account.master_service_account.email}"
  project  = var.gcp_project_id
}

resource "google_service_account_key" "master_sa_key" {
  service_account_id = google_service_account.master_service_account.name
}
