terraform {
  backend "gcs" {
    bucket = "ch-odata-wh-tf-state"
    prefix = "backend/terraform.tfstate"
  }
}

provider "google" {
  project = "ch-odata-warehouse"
  region  = "europe-west1"
}

resource "google_project" "ch-odata-wh-project" {
  name            = "ch-odata-warehouse"
  project_id      = "ch-odata-warehouse"
  billing_account = "01F8A8-7C1908-1BF0DD"
}

// enable big query api
resource "google_project_service" "bq-svc" {
  project = google_project.ch-odata-wh-project.project_id
  service = "bigquery.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}
resource "google_project_service" "scheduler-api" {
  project = google_project.ch-odata-wh-project.project_id
  service = "cloudscheduler.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}
resource "google_project_service" "cloudrun-api" {
  project = google_project.ch-odata-wh-project.project_id
  service = "run.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}

resource "google_bigquery_dataset" "ch_meteo" {
  dataset_id    = "ch_meteo"
  friendly_name = "Meteo Swiss data"
  description   = "all gathered Meteo Swiss data"
  location      = "EU"

  labels = {
    env = "dev"
  }
}

resource "google_bigquery_table" "sunshine_10min" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "sunshine_10min"

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

  schema = <<EOF
[
  {
    "name": "station",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the human readable name of the station"
  },
  {
    "name": "abbr",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the standardized abbreviation for the measuring station"
  },
  {
    "name": "wigos_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the WMO Integrated Global Observing System ID"
  },
  {
    "name": "duration",
    "type": "INTEGER",
    "mode": "REQUIRED",
    "description": "the sunsine duration in minutes of the 10 minute interval"
  },
  {
    "name": "date_time",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "the date and time at which the measurement was taken"
  }
]
EOF
}

resource "google_bigquery_table" "sunshine_10min_staging" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "sunshine_10min_staging"

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

  schema = <<EOF
[
  {
    "name": "station",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the human readable name of the station"
  },
  {
    "name": "abbr",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the standardized abbreviation for the measuring station"
  },
  {
    "name": "wigos_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the WMO Integrated Global Observing System ID"
  },
  {
    "name": "duration",
    "type": "INTEGER",
    "mode": "REQUIRED",
    "description": "the sunsine duration in minutes of the 10 minute interval"
  },
  {
    "name": "date_time",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "the date and time at which the measurement was taken"
  }
]
EOF

}

resource "google_bigquery_table" "radiation_10min" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "radiation_10min"

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

  schema = <<EOF
[
  {
    "name": "station",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the human readable name of the station"
  },
  {
    "name": "abbr",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the standardized abbreviation for the measuring station"
  },
  {
    "name": "wigos_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the WMO Integrated Global Observing System ID"
  },
  {
    "name": "radation",
    "type": "NUMERIC",
    "mode": "REQUIRED",
    "description": "global radation in W/m^2"
  },
  {
    "name": "date_time",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "the date and time at which the measurement was taken"
  }
]
EOF
}

resource "google_bigquery_table" "radiation_10min_staging" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "radiation_10min_staging"

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

  schema = <<EOF
[
  {
    "name": "station",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the human readable name of the station"
  },
  {
    "name": "abbr",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the standardized abbreviation for the measuring station"
  },
  {
    "name": "wigos_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "the WMO Integrated Global Observing System ID"
  },
  {
    "name": "radation",
    "type": "NUMERIC",
    "mode": "REQUIRED",
    "description": "global radation in W/m^2"
  },
  {
    "name": "date_time",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "the date and time at which the measurement was taken"
  }
]
EOF

}

resource "google_service_account" "scrape_sa" {
  account_id = "scrape-sa"
}

resource "google_project_iam_binding" "scrape_sa_bq_writer" {
  project = google_project.ch-odata-wh-project.project_id
  role    = "roles/bigquery.dataEditor"

  members = [
    "serviceAccount:${google_service_account.scrape_sa.email}",
  ]
}
resource "google_project_iam_binding" "scrape_sa_bq_jobsuser" {
  project = google_project.ch-odata-wh-project.project_id
  role    = "roles/bigquery.jobUser"

  members = [
    "serviceAccount:${google_service_account.scrape_sa.email}",
  ]
}

resource "google_cloud_run_v2_job" "meteo_sunshine_10min" {
  name     = "meteo-sunshine-10min-scraper"
  location = "europe-west1"
  project  = google_project.ch-odata-wh-project.project_id

  template {
    template {
      containers {
        image = "google/cloud-sdk"
        command = [
          "bash",
          "-c",
          file("${path.root}/meteo/sunshine_10min/fetch_sunshine10min_bqUpload.sh")
        ]
      }
      service_account = google_service_account.scrape_sa.email
    }
  }

  depends_on = [google_project_service.cloudrun-api]
}

resource "google_cloud_run_v2_job" "meteo_radiation_10min" {
  name     = "meteo-radation-10min-scraper"
  location = "europe-west1"
  project  = google_project.ch-odata-wh-project.project_id

  template {
    template {
      containers {
        image = "google/cloud-sdk"
        command = [
          "bash",
          "-c",
          file("${path.root}/meteo/radiation_10min/fetch_radiation10min_bqUpload.sh")
        ]
      }
      service_account = google_service_account.scrape_sa.email
    }
  }

  depends_on = [google_project_service.cloudrun-api]
}

resource "google_service_account" "scrape_trigger" {
  account_id = "scrape-trigger"
}

resource "google_project_iam_binding" "scrape_trigger_cloud_run_invoker" {
  project = google_project.ch-odata-wh-project.project_id
  role    = "roles/run.invoker"

  members = [
    "serviceAccount:${google_service_account.scrape_trigger.email}",
  ]
}

resource "google_cloud_scheduler_job" "meteo_trigger_10m" {
  name     = "10m_meteo_scraping"
  schedule = "*/10 5-23 * * *"

  http_target {
    http_method = "POST"
    uri         = "https://${google_cloud_run_v2_job.meteo_sunshine_10min.location}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${google_project.ch-odata-wh-project.project_id}/jobs/${google_cloud_run_v2_job.meteo_sunshine_10min.name}:run"

    oauth_token {
      service_account_email = google_service_account.scrape_trigger.email
    }
  }

  retry_config {
    min_backoff_duration = "10s"
    max_doublings        = 6
  }

  attempt_deadline = "60s"

  depends_on = [
    google_project_service.scheduler-api,
    google_cloud_run_v2_job.meteo_sunshine_10min,
    google_project_iam_binding.scrape_trigger_cloud_run_invoker
  ]
}

resource "google_cloud_scheduler_job" "meteo_radation_trigger" {
  name     = "10m_radation_scraping"
  schedule = "*/10 5-23 * * *"

  http_target {
    http_method = "POST"
    uri         = "https://${google_cloud_run_v2_job.meteo_sunshine_10min.location}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${google_project.ch-odata-wh-project.project_id}/jobs/${google_cloud_run_v2_job.meteo_radiation_10min.name}:run"

    oauth_token {
      service_account_email = google_service_account.scrape_trigger.email
    }
  }

  retry_config {
    min_backoff_duration = "10s"
    max_doublings        = 6
  }

  attempt_deadline = "60s"

  depends_on = [
    google_project_service.scheduler-api,
    google_cloud_run_v2_job.meteo_sunshine_10min,
    google_project_iam_binding.scrape_trigger_cloud_run_invoker
  ]
}
