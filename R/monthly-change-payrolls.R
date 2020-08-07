  library(magrittr)
  
  pamngr::get_data("nfp tch") %>%
    tail(12) %>%
    # dplyr::slice_max(dates, n = 12) %>%
    reshape2::melt(id.vars = "dates") %>%
    pamngr::barplot(fill = "variable") %>%
    pamngr::pam_plot(
      plot_title = "Monthly Change in Nonfarm Payrolls",
      plot_subtitle = "Thousands",
      show_legend = FALSE,
      caption = FALSE
    ) %>%
    pamngr::all_output("monthly-change-in-payrolls", save = TRUE)
  
  
  
  
