resource "google_bigquery_table" "rh_10min" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "rh_10min"

  time_partitioning {
    type  = "MONTH"
    field = "date_time"
  }

  clustering = ["abbr", "station", "wigos_id"]

  labels = {
    env = "dev"
  }

  table_constraints {
    primary_key {
      columns = ["wigos_id", "date_time"]
    }
  }

  schema = file("${path.root}/meteo/rh_10min/rh_schema.json")
}

resource "google_cloud_run_v2_job" "meteo_rh_10min" {
  name     = "meteo-rh-10min-scraper"
  location = "europe-west1"
  project  = google_project.ch-odata-wh-project.project_id

  template {
    template {
      containers {
        image = "google/cloud-sdk:alpine"
        command = [
          "bash",
          "-c",
          file("${path.root}/meteo/rh_10min/fetch_bqUpload.sh")
        ]
      }
      service_account = google_service_account.scrape_sa.email
    }
  }

  depends_on = [google_project_service.cloudrun-api]
}

resource "google_cloud_scheduler_job" "meteo_rh_10m" {
  name      = "meteo-rh-10m-scraping"
  schedule  = "*/10 * * * *"
  time_zone = "Europe/Zurich"

  http_target {
    http_method = "POST"
    uri         = "https://${google_cloud_run_v2_job.meteo_rh_10min.location}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${google_project.ch-odata-wh-project.project_id}/jobs/${google_cloud_run_v2_job.meteo_rh_10min.name}:run"

    oauth_token {
      service_account_email = google_service_account.scrape_trigger.email
    }
  }
  
  paused = true

  retry_config {
    min_backoff_duration = "10s"
    max_doublings        = 6
  }

  attempt_deadline = "60s"

  depends_on = [
    google_project_service.scheduler-api,
    google_cloud_run_v2_job.meteo_rh_10min,
    google_project_iam_binding.scrape_trigger_cloud_run_invoker
  ]
}

resource "google_bigquery_data_transfer_config" "meteo_ch_rh_10min_dedup" {
  project = google_project.ch-odata-wh-project.project_id

  service_account_name = google_service_account.scrape_sa.email

  display_name           = "rh10min_dedup"
  location               = "EU"
  data_source_id         = "scheduled_query"
  schedule               = "every day 23:55"
  destination_dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  params = {
    query = file("${path.root}/meteo/rh_10min/duplicate_cleanup.sql")
  }

  depends_on = [google_project_iam_member.datatransfer-permissions]
}
