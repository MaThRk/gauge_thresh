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
# get the stations
stations.sf = get_station_information()


# -------------------------------------------------------------------------
# for each landslide select a station

# by distance (creates a list column of dataframes with each having three rows)
res = get_station_by_distance(position = landslides, station_sf = stations.sf)

# -------------------------------------------------------------------------
# give each dataframe an id
stat_id = imap_dfr(stations, ~ .x %>% mutate(id = .y))


# -------------------------------------------------------------------------
# give each station the date it is supposed to
for (i in 1:nrow(res)) {

  # get the date of the landslide
  dol = res[i,]$date

  # assign it to the stations list
  res[i,]$stations[[1]][["dol"]] = dol

}

# -------------------------------------------------------------------------
# get the stations

stations = res$stations

# -------------------------------------------------------------------------
# for each of the three stations get the rainfall

rain = map(stations[1:3], ~read_rainfall(.x$name_from_file, start_date = .x$dol, end_date = .x$dol + 20))

# -------------------------------------------------------------------------
# get the 3 and 15 day rainfall for each station for each landslide

rain_3_15 = map(rain, function(x){

  stations = x

  rain315 = map(stations, ~ .x$data[[1]] %>%
                  mutate(
                    r = row_number()
                    p3 =
                  ))


})








a = rain_3_15[[1]]
d = res[1,]$date
slice_rain(a, start_date = d, end_date = d + 30,)





