resource "google_project_service" "analytics-hub-api" {
  project = google_project.ch-odata-wh-project.project_id
  service = "analyticshub.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}

resource "google_bigquery_analytics_hub_data_exchange" "ch_meteo_exchange" {
  location         = "EU"
  data_exchange_id = "odata_swiss"
  display_name     = "Swiss Open Government data"
  description      = "The opendata.swiss portal is a joint project of the Confederation, cantons, communes and other organizations with a mandate from the state. It makes open government data available to the general public in a central catalogue. opendata.swiss is operated by the Federal Statistical Office. This dataset is maintained through volunteer work and NOT by the Federal Statistical Office."

  sharing_environment_config  {
    default_exchange_config {}
  }

  depends_on = [google_project_service.analytics-hub-api]
}

resource "google_bigquery_analytics_hub_listing" "ch_meteo_listing" {
  location         = "EU"
  data_exchange_id = google_bigquery_analytics_hub_data_exchange.ch_meteo_exchange.data_exchange_id
  listing_id       = "ch_meteo"
  display_name     = "Swiss Meteo Data"
  description      = "The national weather and climate service. Meteorological stations, weather radars and satellites monitor the weather. Using the collected data, MeteoSwiss generates forecasts, warnings and climate analyses. More information: https://www.meteoschweiz.admin.ch"

  categories = ["CATEGORY_CLIMATE_AND_ENVIRONMENT"]

  primary_contact = "michael.ingold11@gmail.com"
  documentation   = "Test *of* markdown _content_"
  

  data_provider {
    name            = "Federal Office of Meteorology and Climatology MeteoSwiss"
    primary_contact = "kundendienst@meteoschweiz.ch"
  }

  publisher {
    name            = "Michael Ingold"
    primary_contact = "michael.ingold11@gmail.com"
  }


  bigquery_dataset {
    dataset = google_bigquery_dataset.ch_meteo.id
  }
}

# resource "google_bigquery_analytics_hub_listing_iam_binding" "binding" {
#   project = google_bigquery_analytics_hub_listing.ch_meteo_listing.project
#   location = google_bigquery_analytics_hub_listing.ch_meteo_listing.location
#   data_exchange_id = google_bigquery_analytics_hub_listing.ch_meteo_listing.data_exchange_id
#   listing_id = google_bigquery_analytics_hub_listing.ch_meteo_listing.listing_id
#   role = "roles/viewer"
#   members = [
#     "allAuthenticatedUsers",
#   ]
# }

# resource "google_bigquery_analytics_hub_listing_iam_member" "allAuthUsers_viewer" {
#   project          = google_bigquery_analytics_hub_listing.ch_meteo_listing.project
#   location         = google_bigquery_analytics_hub_listing.ch_meteo_listing.location
#   data_exchange_id = google_bigquery_analytics_hub_listing.ch_meteo_listing.data_exchange_id
#   listing_id       = google_bigquery_analytics_hub_listing.ch_meteo_listing.listing_id
#   role             = "roles/viewer"
#   member           = "allAuthenticatedUsers"
# }

resource "google_bigquery_analytics_hub_listing_iam_binding" "allAuthUsers-analytics-hub-subscribers" {
  project = google_bigquery_analytics_hub_listing.ch_meteo_listing.project
  location = google_bigquery_analytics_hub_listing.ch_meteo_listing.location
  data_exchange_id = google_bigquery_analytics_hub_listing.ch_meteo_listing.data_exchange_id
  listing_id = google_bigquery_analytics_hub_listing.ch_meteo_listing.listing_id
  role = "roles/analyticshub.subscriber"
  members = [
    "allAuthenticatedUsers",
  ]
}

