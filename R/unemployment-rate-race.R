pamngr::join_sheets(c("usurwurs","usurburs","usurhl","usurqbay")) %>%
  magrittr::set_colnames(c("dates","White","Black","Hispanic/Latino","Asian")) %>%
  dplyr::filter(dates >= as.POSIXct("2015-01-01")) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Unemployment Rate by Race",
    caption = FALSE
  ) %>%
  pamngr::all_output("unemployment-rate-race")
