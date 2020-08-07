library(magrittr)

rename_columns <- function(x){ 
  data.frame(security = x) %>%
    dplyr::left_join(readxl::read_xlsx("data.xlsx", sheet = "key"), by = "security") %>%
    dplyr::select(name) %>%
    dplyr::pull() %>% 
    as.character() %>%
    stringr::str_remove_all("US Employees on Nonfarm Payrolls ") %>%
    stringr::str_remove_all("US Employees On Nonfarm Payrolls ") %>%
    stringr::str_remove_all("By Industry ") %>%
    stringr::str_remove_all(" SA") %>%
    stringr::str_remove_all("Industry") %>%
    stringr::str_replace_all(" ", "-") %>%
    stringr::str_to_lower()
}

normalize_earliest <- function(x){
  
  start_value <- x[1]
  y <- x/start_value*100
  
  return(y)
  }


p <- pamngr::join_sheets(
  c("usmmnatr",
    "usectot",
    "usmmmanu",
    "nfp ttut",
    "useitots",
    # "useftot",
    "useetots",
    "usehtots",
    "useotots",
    "usegtot")
) %>%
  dplyr::rename_all(rename_columns) %>%
  dplyr::slice_tail(n = 7) %>% 
  dplyr::mutate_if(is.numeric, normalize_earliest) %>%
  reshape2::melt(id.vars = "dates") %>%
  dplyr::mutate(variable = variable %>% 
                  stringr::str_replace_all("-", " ") %>%
                  stringr::str_to_title()) %>%
  ggplot2::ggplot(ggplot2::aes(dates, value, color = variable)) +
  ggplot2::geom_line(color = "#850237", size = 2) +
  ggplot2::facet_wrap(~ variable, ncol = 3) 
  p <- p %>% pamngr::pam_plot(
    plot_title = "Employment by Occupation",
    plot_subtitle = "Normalized to December 2019",
    caption = FALSE
  ) %>%
  pamngr::all_output("employment-normalized")
  # ggplot2::theme(
  #   plot.title = ggplot2::element_text(size = ggplot2::rel(2)),
  #   plot.subtitle = ggplot2::element_text(size = ggplot2::rel(1.5)),    
  #   strip.text = ggplot2::element_text(size = ggplot2::rel(.8)),
  #   axis.text = ggplot2::element_text(size = ggplot2::rel(.8))
  # )


# ggplot2::ggsave(
#   filename = "employment-normalized.png",
#   plot = p,
#   width = 6.5,
#   height = 4,
#   units = "in"
# )






