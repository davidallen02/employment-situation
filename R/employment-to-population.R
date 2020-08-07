library(magrittr)

employ_pop <- pamngr::get_data("usertot")
employ_prime <- pamngr::get_data("user54sa")

emplemploy_pop %>%
  dplyr::left_join(employ_prime, by = "dates") %>%
  set_colnames(c("dates","Total Population","Prime Age")) %>%
  reshape2::melt(id.vars = "dates") 

p <- employ_pop %>%
  ggplot2::ggplot(ggplot2::aes(dates, value, color = variable)) +
  ggplot2::geom_line(size = 2) +
  ggplot2::scale_color_manual(values = c("#850237","black")) +
  ggplot2::labs(title = "Employment to Population Ratio") +
  ggplot2::theme(
    plot.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(3.25)),
    # plot.subtitle = ggplot2::element_text(size = ggplot2::rel(2)),
    legend.title = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(size = ggplot2::rel(1.5)),
    legend.position = "bottom",
    axis.title = ggplot2::element_blank(),
    axis.text = ggplot2::element_text(size = ggplot2::rel(1.5))
  )

pamngr::join_sheets(c("usertot","user54sa")) %>%
  set_colnames(c("dates", "Total Population","Prime Age")) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(plot_title = "Employment to Population Ratio") %>%
  pamngr::all_output("employment-to-population")

