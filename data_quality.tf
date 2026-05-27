resource "google_bigquery_table" "q_freshness" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "q_freshness"

  description = <<-EOT
  
EOT

  labels = {
    env = "dev"
  }

  view {
    query = file("${path.root}/meteo/data_quality/freshness.sql")
    use_legacy_sql = false
  }
}

resource "google_bigquery_table" "q_measure_cnt_over_time" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "q_measure_cnt_over_time"

  description = <<-EOT
  
EOT

  labels = {
    env = "dev"
  }

  view {
    query = file("${path.root}/meteo/data_quality/measures_cnt_over_time.sql")
    use_legacy_sql = false
  }
}