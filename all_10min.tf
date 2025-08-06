resource "google_cloud_run_v2_job" "meteo_all_10min" {
  name     = "meteo-all-10min-scraper"
  location = "europe-west1"
  project  = google_project.ch-odata-wh-project.project_id

  template {
    template {
      containers {
        image = "google/cloud-sdk:alpine"
        command = [
          "bash",
          "-c",
          file("${path.root}/meteo/swiss_meteo_all.sh")
        ]
      }
      service_account = google_service_account.scrape_sa.email
    }
  }

  depends_on = [google_project_service.cloudrun-api]
}

resource "google_cloud_scheduler_job" "meteo_all_10m" {
  name      = "meteo-all-10m-scraping"
  schedule  = "*/10 * * * *"
  time_zone = "Europe/Zurich"

  http_target {
    http_method = "POST"
    uri         = "https://${google_cloud_run_v2_job.meteo_all_10min.location}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${google_project.ch-odata-wh-project.project_id}/jobs/${google_cloud_run_v2_job.meteo_all_10min.name}:run"

    oauth_token {
      service_account_email = google_service_account.scrape_trigger.email
    }
  }

  paused = false  
  
  retry_config {
    min_backoff_duration = "10s"
    max_doublings        = 6
  }

  attempt_deadline = "60s"

  depends_on = [
    google_project_service.scheduler-api,
    google_cloud_run_v2_job.meteo_all_10min,
    google_project_iam_binding.scrape_trigger_cloud_run_invoker
  ]
}
