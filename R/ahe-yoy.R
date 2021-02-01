pamngr::get_data("ahe yoy%") %>%
  dplyr::slice_max(dates, n = 180) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Average Hourly Earnings",
    plot_subtitle = "Annual Percent Change",
    show_legend = FALSE
  ) %>%
  pamngr::all_output("ahe-yoy.png")