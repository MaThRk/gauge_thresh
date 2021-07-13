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
df = get_station_by_distance(landsld)
top_stations = df$stations %>% map(~.x[1,]) %>% bind_rows() %>% st_drop_geometry()

df_dis = bind_cols(landsld, top_stations)


# -------------------------------------------------------------------------
# bounding box
bb = st_bbox(st)


# -------------------------------------------------------------------------
# hillshade
hs = read_stars("~/geodata/hillshades_south_tyrol/grey_scale_100m.tif")



# -------------------------------------------------------------------------
# plot the average distance

m = mean(df_dis$distance)
a =make_voronoi(landsld)[[1]]

ggplot() +
    geom_stars(
      data = hs,
      aes(x = x, y = y, fill = grey_scale_100m.tif),
      downsample = 0,
      show.legend = F) +
  geom_sf(data=st,
          fill = "#D2D7DF") +
  geom_sf(data = df_dis,
          aes(col = as.numeric(distance))) +
  geom_sf(
    data = stations,
    col = "red",
    aes(
      shape ="Rain Gauge",
    ),
    size = 4
  ) +
  # geom_sf(data = ,
  #         size = .2,
  #         alpha = .1) +
  scale_color_scico(palette = "bilbao",
                    name = "Distance from Landslide to next rain gauge [m]") +
  scale_shape_manual(values = c("Rain Gauge" = 4),
                     name = "") +
  scale_fill_continuous(low="black", high="white", na.value="transparent") +
  coord_sf(xlim = c(bb[c(1,3)]),
           ylim = c(bb[c(2,4)]),
           datum = st_crs(32632)) +
  theme_map() +
  guides(color = guide_legend(title.position = "top")) +
  # geom_label(
  #   aes(
  #   x = 626000,
  #   y = 5200000,
  #   ),
  #   family = "Times New Roman",
  #   size = 5
  # ) +
  labs(
    title = "Distance to next Rain Gauge for each slide",
    subtitle = glue("Average Distance: {round(m,2)} [m]")
  ) +
  theme(
    plot.title = element_text(family="Times New Roman", hjust=.5, size=16),
    legend.title = element_text(family="Times New Roman", size=15),
    plot.subtitle = element_text(hjust=.5, family="Times New Roman"),
    legend.text = element_text(family="Times New Roman", size=14),
    legend.position = c(.55,.1),
    legend.background = element_rect(color="black", linetype = "dashed"),
    legend.direction = "horizontal",
    legend.margin = margin(rep(8,4)),
    legend.box.just = "right"
  )

f = here(mahelp::file_dir(), "avg_distance_with_voronoi_overlay.png")
ggsave(f, width=12, height=8)







