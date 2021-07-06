# Thu Jul  1 14:58:54 2021 ------------------------------
# Simple 5 % ED quantile regression thrsholds for the raingauge dat
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

# by distance
res = get_station_by_distance(position = landslides, station_sf = stations.sf)






