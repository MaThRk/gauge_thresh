# Thu Jul  1 15:24:22 2021 ------------------------------
# Calculate the acerave distance to a rain gauge for each landslide
######################################



# -------------------------------------------------------------------------
# load the data
landsld = readRDS(path_filtered_landsld_data)
stations = get_station_information()
st = read_sf(path_st_32632)

landsld = st_transform(landsld, crs=32632)
stations = st_transform(stations, crs=32632)
st = st_transform(st, crs=32632)


# -------------------------------------------------------------------------
# get the next station for each landslide
df = get_station_by_distance(landsld, stations)
top_stations = df$stations %>% map(~.x[1,]) %>% bind_rows() %>% st_drop_geometry()

df_dis = bind_cols(landsld, top_stations)


# -------------------------------------------------------------------------
# plot the average distance

m = mean(df_dis$distance)

ggplot() +
  geom_sf(data=st) +
  geom_sf(data = df_dis,
          aes(col = as.numeric(distance))) +
  scale_color_scico(palette = "berlin",
                    name = "Distance to next rain gauge [m]") +
  theme_map() +
  coord_sf(datum = 32632) +
  guides(color = guide_colorbar(title.position = "top",
                                barwidth = unit(15, "lines"))) +
  geom_label(
    aes(
    x = 626000,
    y = 5200000,
    label = glue("Average Distance: {round(m,2)} [m]")
    ),
    family = "Times New Roman",
    size = 5
  ) +
  labs(
    title = "Distance to next Rain Gauge for each slide"
  ) +
  theme(
    plot.title = element_text(family="Times New Roman", hjust=.5),
    legend.title = element_text(family="Times New Roman"),
    legend.text = element_text(family="Times New Roman"),
    legend.position = c(.6,.2),
    legend.direction = "horizontal"
  )

f = here(mahelp::file_dir(), "avg_distance.png")
ggsave(f, width=12, height=8)


