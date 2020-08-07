pamngr::join_sheets(c("usaelurt","usaehurt","usaesurt","usaecurt")) %>%
  magrittr::set_colnames(c("dates",
                           "< High School",
                           "High School",
                           "Some College",
                           "BS/BA or Higher")) %>%
  dplyr::filter(dates >= as.POSIXct("2015-01-01")) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Unemployment Rate by Educational Attainment",
    caption = FALSE
  ) %>%
  pamngr::all_output("unemployment-rate-education")
