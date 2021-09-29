dat = get_station_information()



dat %>% count(time_res_min)


dat %>%
  mutate(
    start = as.Date(start),
    end = as.Date(end),
    time = end-start
  ) %>%
  filter(
    time == min(time)  | time == max(time)
  ) %>%
  mutate(
    t= time/365
  )

