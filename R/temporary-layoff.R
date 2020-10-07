library(magrittr)

dat <- pamngr::join_sheets(c("usjloser", "usjltemp")) %>%
  dplyr::mutate(percent_temp = usjltemp/usjloser) %>%
  dplyr::slice_max(dates, n = 60) %>%
  dplyr::select(dates, percent_temp) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable")

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Temporary Layoffs",
    plot_subtitle = "Temporary Layoffs as a Percentage of Total Job Losers",
    show_legend = FALSE
  )

p %>% pamngr::all_output("temporary-layoffs")