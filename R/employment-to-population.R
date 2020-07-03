library(magrittr)

source("./R/functions/ppt_output.R")


employ_pop <- readxl::read_excel(path = "./data/data.xlsx", sheet = "usertot", skip = 2)
employ_prime <- readxl::read_excel(path = "./data/data.xlsx", sheet = "user54sa", skip = 2)

employ_pop <- employ_pop %>%
  dplyr::left_join(employ_prime, by = "Dates") %>%
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

p

ppt_output(p, image.name = "employment-to-population")