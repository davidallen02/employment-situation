pamngr::get_data("ahe yoy%") %>%
  dplyr::slice_max(dates, n = 180) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam.plot(
    plot.title = "Average Hourly Earnings",
    plot.subtitle = "Annual Percent Change",
    show.legend = FALSE
  ) %>%
  pamngr::ppt_output("ahe-yoy.png")