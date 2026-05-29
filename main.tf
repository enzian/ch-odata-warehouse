terraform {
  backend "gcs" {
    bucket = "ch-odwh-tf-state"
    prefix = "backend/terraform.tfstate"
  }
}

provider "google" {
  project               = "ch-odata-warehouse-433011"
  billing_project       = "ch-odata-warehouse-433011"
  region                = "europe-west1"
  user_project_override = true
}

resource "google_project" "ch-odata-wh-project" {
  name            = "ch-odata-warehouse"
  project_id      = "ch-odata-warehouse-433011"
  org_id          = "532146608049"
  billing_account = "013AD9-5D5806-C6800B"
}

resource "google_project_service" "iam-api" {
  project = google_project.ch-odata-wh-project.project_id
  service = "iam.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}

resource "google_project_service" "serviceuasage-api" {
  project = google_project.ch-odata-wh-project.project_id
  service = "serviceusage.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}

// enable big query api
resource "google_project_service" "bq-api" {
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
resource "google_project_service" "bq-data-transfer-api" {
  project = google_project.ch-odata-wh-project.project_id
  service = "bigquerydatatransfer.googleapis.com"

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

  depends_on = [google_project_service.bq-api]
}

resource "google_project_iam_member" "datatransfer-permissions" {
  project = google_project.ch-odata-wh-project.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-${google_project.ch-odata-wh-project.number}@gcp-sa-bigquerydatatransfer.iam.gserviceaccount.com"
}


resource "google_bigquery_data_transfer_config" "dwpnt_10min_dedup_job" {
  project = google_project.ch-odata-wh-project.project_id

  service_account_name = google_service_account.scrape_sa.email

  display_name           = "dwpnt_10min_dedup"
  location               = "EU"
  data_source_id         = "scheduled_query"
  schedule               = "every day 23:10"
  destination_dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  params = {
    query = file("${path.root}/meteo/dwpnt_10min/duplicate_cleanup.sql")
  }

  depends_on = [google_project_iam_member.datatransfer-permissions]
}

resource "google_bigquery_data_transfer_config" "precip_10min_dedup_job" {
  project = google_project.ch-odata-wh-project.project_id

  service_account_name = google_service_account.scrape_sa.email

  display_name           = "precip_10min_dedup"
  location               = "EU"
  data_source_id         = "scheduled_query"
  schedule               = "every day 23:10"
  destination_dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  params = {
    query = file("${path.root}/meteo/precip_10min/duplicate_cleanup.sql")
  }

  depends_on = [google_project_iam_member.datatransfer-permissions]
}

resource "google_bigquery_data_transfer_config" "radation_dedup_job" {
  project = google_project.ch-odata-wh-project.project_id

  service_account_name = google_service_account.scrape_sa.email

  display_name           = "radiation10min_dedup"
  location               = "EU"
  data_source_id         = "scheduled_query"
  schedule               = "every day 23:10"
  destination_dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  params = {
    query = file("${path.root}/meteo/radiation_10min/duplicate_cleanup.sql")
  }

  depends_on = [google_project_iam_member.datatransfer-permissions]
}


resource "google_bigquery_data_transfer_config" "rh_10min_dedup_job" {
  project = google_project.ch-odata-wh-project.project_id

  service_account_name = google_service_account.scrape_sa.email

  display_name           = "rh_10min_dedup"
  location               = "EU"
  data_source_id         = "scheduled_query"
  schedule               = "every day 23:10"
  destination_dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  params = {
    query = file("${path.root}/meteo/rh_10min/duplicate_cleanup.sql")
  }

  depends_on = [google_project_iam_member.datatransfer-permissions]
}

resource "google_bigquery_data_transfer_config" "sunshine_10min_dedup_job" {
  project = google_project.ch-odata-wh-project.project_id

  service_account_name = google_service_account.scrape_sa.email

  display_name           = "sunshine_10min_dedup"
  location               = "EU"
  data_source_id         = "scheduled_query"
  schedule               = "every day 23:10"
  destination_dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  params = {
    query = file("${path.root}/meteo/sunshine_10min/duplicate_cleanup.sql")
  }

  depends_on = [google_project_iam_member.datatransfer-permissions]
}

resource "google_bigquery_data_transfer_config" "temp_2m_10min_dedup_job" {
  project = google_project.ch-odata-wh-project.project_id

  service_account_name = google_service_account.scrape_sa.email

  display_name           = "temp_2m_10min_dedup"
  location               = "EU"
  data_source_id         = "scheduled_query"
  schedule               = "every day 23:10"
  destination_dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  params = {
    query = file("${path.root}/meteo/temp_2m_10min/duplicate_cleanup.sql")
  }

  depends_on = [google_project_iam_member.datatransfer-permissions]
}

resource "google_bigquery_data_transfer_config" "wind_10min_dedup_job" {
  project = google_project.ch-odata-wh-project.project_id

  service_account_name = google_service_account.scrape_sa.email

  display_name           = "wind_10min_dedup"
  location               = "EU"
  data_source_id         = "scheduled_query"
  schedule               = "every day 23:10"
  destination_dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  params = {
    query = file("${path.root}/meteo/wind_10min/duplicate_cleanup.sql")
  }

  depends_on = [google_project_iam_member.datatransfer-permissions]
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

resource "google_service_account" "grafana" {
  account_id = "grafana"
}

resource "google_project_iam_binding" "grafana_bq_reader" {
  project = google_project.ch-odata-wh-project.project_id
  role      = "roles/bigquery.dataViewer"
  
  members = [
    "serviceAccount:${google_service_account.grafana.email}",
  ]
}
resource "google_project_iam_binding" "bq_jobuser" {
  project = google_project.ch-odata-wh-project.project_id
  role      = "roles/bigquery.jobUser"
  
  members = [
    "serviceAccount:${google_service_account.grafana.email}",
    "serviceAccount:${google_service_account.scrape_sa.email}",
  ]
}