library(magrittr)

dat <- pamngr::get_data("nfp t") %>%
  dplyr::slice_max(dates, n = 60) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable")

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Nonfarm Payrolls",
    plot_subtitle = "Thousands",
    show_legend = FALSE
  )
  
p %>% pamngr::all_output("payrolls-level")