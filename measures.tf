
resource "google_bigquery_table" "precip_10min" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "precip_10min"

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

  schema = file("${path.root}/meteo/precip_10min/schema.json")
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

  schema = file("${path.root}/meteo/radiation_10min/radiation_10min.json")
}

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

  schema = file("${path.root}/meteo/sunshine_10min/sunshine_schema.json")
}

resource "google_bigquery_table" "temp_2m_10min" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "temp_2m_10min"

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

  schema = file("${path.root}/meteo/temp_2m_10min/temp_2m_schema.json")
}

resource "google_bigquery_table" "wind_10min" {
  dataset_id = google_bigquery_dataset.ch_meteo.dataset_id
  table_id   = "wind_10min"

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

  schema = file("${path.root}/meteo/wind_10min/schema.json")
}

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
