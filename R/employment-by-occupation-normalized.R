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


dat <- pamngr::join_sheets(
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
  dplyr::filter(dates >= lubridate::as_datetime("2019-12-31")) %>%
  # dplyr::slice_tail(n = 7) %>% 
  dplyr::mutate_if(is.numeric, normalize_earliest) %>%
  reshape2::melt(id.vars = "dates") %>%
  dplyr::mutate(variable = variable %>% 
                  stringr::str_replace_all("-", " ") %>%
                  stringr::str_to_title())
p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Employment by Occupation",
    plot_subtitle = "Normalized to December 2019",
    show_legend = FALSE
  )

p <- p + 
  ggplot2::facet_wrap(~ variable, ncol = 3) +
  ggplot2::scale_color_manual(values = rep("#850237", 9))

p %>% pamngr::all_output("employment-by-occupation-normalized")





