resource "google_bigquery_table" "dwpnt_10min" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "dwpnt_10min"

  time_partitioning {
    type  = "MONTH"
    field = "date_time"
  }

  description = <<-EOT
  Current measurement values of Dew point, 10 min [°C].Data is updated
  every 10 minutes. The data set contains all weather stations of the
  SwissMetNet, the automatic monitoring network of MeteoSwiss, which 
  comprises 160 automatic monitoring stations. These stations deliver a
  multitude of current data on the weather and climate in Switzerland
  every ten minutes.
EOT

  clustering = ["abbr", "station", "wigos_id"]

  labels = {
    env = "dev"
  }

  table_constraints {
    primary_key {
      columns = ["wigos_id", "date_time"]
    }
  }

  schema = file("${path.root}/meteo/dwpnt_10min/schema.json")
}
