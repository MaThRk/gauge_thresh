# Thu Jul  1 14:58:54 2021 ------------------------------
# Compare the rainfall from the three nearest stations for each landslide
######################################


# -------------------------------------------------------------------------
# Define Some Paths

plot_dir = here(file_dir(), "plot_dir")
thresh_dir = here(file_dir(), "thresh_dir")
thresh_file = here(thresh_dir, "thresholds.txt")


for (i in c(plot_dir, thresh_dir)) {
  if(!dir.exists(i)){
    dir.create(i, recursive = T)
  }
}


# -------------------------------------------------------------------------
# get the landslide data
landslides = readRDS(path_filtered_landsld_data)


# -------------------------------------------------------------------------
# get the rainfall for the three nearest stations

test_data = landslides[1:10, ]

res = get_rainfall_from_gauge(test_data,
                              date_of_landslide = test_data$date,
                              days_back = 30,
                              select_station_by = "dist",
                              n_stations = 3)



# -------------------------------------------------------------------------

s = res %>% split(., .$PIFF_ID)
res = map(
  s,
  ~ data.frame(
    date = rep(.x$date, nrow(.x$stations[[1]])),
    station = .x$stations[[1]]$name,
    data_avail = .x$rain_data[[1]]$data_avail %>% unlist(),
    distance = .x$stations[[1]]$distance
  ) %>%
    mutate(
      data = .x$rain_data[[1]] %>% split(., .$name) %>% map(function(x){x$data$data[[1]]})
    )
) %>% bind_rows(., .id="PIFF_ID")


res %>%
  group_by(PIFF_ID, station) %>%
  summarise(
    data = cur_data()$data
  ) %>% unnest(cols =c(data)) -> df






