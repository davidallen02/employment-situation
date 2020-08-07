dat <- pamngr::join_sheets(c("nfp gp", "usespriv")) %>%
  magrittr::set_colnames(
    c("dates", "Goods Producing", "Service Providing")
  ) %>%
  dplyr::filter(dates >= lubridate::as_datetime("2019-12-31")) %>%
  dplyr::mutate_if(is.numeric, normalize_earliest) %>%
  reshape2::melt(id.vars = "dates")

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Employment by Occupation",
    plot_subtitle = "Normalized to December 2019",
    show_legend = FALSE
  )

p <- p + 
  ggplot2::facet_wrap(~ variable, ncol = 2) +
  ggplot2::scale_color_manual(values = rep("#850237", 2))

p %>% pamngr::all_output("employment-by-type-normalized")