pamngr::join_sheets(c("usurtot","usudmaer")) %>%
  dplyr::filter(dates >= as.POSIXct("2015-01-01")) %>%
  magrittr::set_colnames(c("dates","Unemployment Rate","Underemployment Rate")) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Unemployment Rate",
    plot_subtitle = "Percent of Labor Force",
    caption = FALSE
  ) %>%
  pamngr::all_output("unemployment-rate")

