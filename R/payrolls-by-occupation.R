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

payrolls_occup <- pamngr::join_sheets(
  c("usmmnatr",
    "usectot",
    "usmmmanu",
    "nfp ttut",
    "useitots",
    "useftot",
    "useetots",
    "usehtots",
    "useotots",
    "usegtot")
) %>%
  dplyr::rename_all(rename_columns) %>%
  reshape2::melt(id.vars = "dates") %>%
  dplyr::group_by(variable) %>%
  dplyr::arrange(dates) %>%
  dplyr::mutate(change = value - dplyr::lag(value)) %>%
  dplyr::slice_max(dates, n = 1) %>%
  dplyr::mutate(
    dates = dates %>% format("%B %Y"),
    variable = variable %>%
      stringr::str_replace_all("-", " ") %>%
      stringr::str_to_title()
  ) %>%
  dplyr::arrange(desc(value))

periods <- payrolls_occup %>%
  dplyr::ungroup() %>%
  dplyr::select(dates) %>%
  dplyr::pull() %>%
  unique()

p <- payrolls_occup %>%
  ggplot2::ggplot(ggplot2::aes(variable, change, fill = dates)) +
  ggplot2::geom_bar(stat = "identity", position = "dodge") +
  ggplot2::coord_flip() +
  ggplot2::scale_fill_manual(values = pamngr::pam.pal())

p <- p %>%
  pamngr::pam_plot(
    plot_title = "Change in Nonfarm Payrolls by Industry",
    plot_subtitle = paste0(periods, ", Thousands"),
    x_lab = "Thousands of Jobs",
    show_legend = FALSE,
    caption = FALSE
  ) %>%
  pamngr::all_output("payrolls-by-occupation")

