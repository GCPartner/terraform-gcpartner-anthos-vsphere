output "master_sa_key" {
  value       = google_service_account_key.master_sa_key.private_key
  description = "GCP Master Service Account JSON Key"
}
