#  current report review
source("R/review.R")

#  current report monthly change in payrolls by occupation
source("R/payrolls-by-occupation.R")

#  average hourly earnings, annual percent change
source("R/ahe-yoy.R")



# usheyoy ---------------------------------------------------------------------------

  p <- read_data('usheyoy') %>%
    dplyr::select(Dates, PX_LAST) %>%
    dplyr::filter(Dates >= '2005-01-01') %>% 
    reshape2::melt(id.vars = 'Dates') %>% 
    dplyr::mutate(
      variable = variable %>% 
        stringr::str_replace_all('_',' ') %>% 
        stringr::str_to_title()) %>% 
    ggplot2::ggplot(ggplot2::aes(Dates, value)) + 
    ggplot2::geom_line(color = '#850237') + 
    ggplot2::labs(title = 'Annual Change in Average Hourly Earnings of Production & Nonsupervisory Workers', 
                  caption = paste('As of', Sys.Date() %>% format('%m/%d/%Y'))) + 
    ggplot2::theme(
      plot.title       = ggplot2::element_text(size  = ggplot2::rel(2), 
                                               face  = 'bold'), 
      axis.title       = ggplot2::element_blank(), 
      axis.text        = ggplot2::element_text(size  = ggplot2::rel(1.25)), 
      plot.caption     = ggplot2::element_text(size  = ggplot2::rel(1)),  
      strip.text       = ggplot2::element_text(size  = ggplot2::rel(1.25), 
                                               color = 'white'), 
      strip.background = ggplot2::element_rect(fill  = '#850237'))
  ppt_output(p , 'usheyoy')
