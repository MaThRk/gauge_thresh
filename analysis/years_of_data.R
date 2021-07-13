# years of data-recording


get_station_information() %>%
  mutate(y = as.numeric(as.Date(end) - as.Date(start)) / 365)  %>%
  mutate(linesep = rep(c("a", "b"), nrow(.) / 2)) %>%
  mutate(start = lubridate::year(as.Date(start)),
         end = lubridate::year(as.Date(end))) %>%
  mutate(name = glue("{name} ({round(y, 0)})")) %>% {
    ggplot(.) +
      geom_segment(aes(
        x = start,
        xend = end,
        y = name,
        yend = name,
        col = y
      ),
      size = 1.2) +
      coord_cartesian(
        xlim = c(min(.$start), max(.$start)),
        ylim = c(0,69),
        clip = "off"
      ) +
      geom_segment(
        aes(
          x = min(.$start),
          xend = start,
          y = name,
          yend = name
        ),
        size = .1,
        linetype = "dashed"
      ) +
      # scale_x_date(date_breaks = "5 year",
      #              label = date_format("%Y")) +
      scale_color_scico(palette = "berlin",
                        name = "Years of Data") +
      guides(color = guide_colorbar(
        barwidth = unit(20, "lines"),
        title.position = "top",
        title.hjust = .5
      )) +
      theme(
        panel.grid.minor = element_blank(),
        legend.position = "bottom",
        panel.background = element_rect(fill = NA),
        axis.text.y = element_text(size = 6),
        legend.title = element_text(family = "Times New Roman")
      ) +
      labs(x = NULL,
           y = NULL) +
      annotate(
        geom = "text",
        x = 1978.5,
        y = 68,
        label = "Stationname\n(years of data)",
        size = 3,
        family = "Times New Roman"
      )
  }


f = here(file_dir(), "stations.png")
ggsave(f, width = 12, height = 8)
