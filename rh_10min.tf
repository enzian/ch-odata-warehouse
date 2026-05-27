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
