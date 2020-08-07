duet <- function(p1, p2, plot.title, ncols = NULL, start.date = '2000-01-01'){
  p <- dplyr::left_join(read_data(p1), read_data(p2), by = 'date') %>% 
    dplyr::filter(date >= start.date) %>% 
    reshape2::melt(id.vars = 'date') %>% 
    dplyr::mutate(
      variable = variable %>% 
        stringr::str_replace_all('_',' ') %>% 
        stringr::str_to_title()) %>% 
    ggplot2::ggplot(ggplot2::aes(date, value)) + 
    ggplot2::geom_hline(yintercept = 50) + 
    ggplot2::geom_line(color = '#850237') + 
    ggplot2::facet_wrap(ggplot2::vars(variable), ncol = ncols) + 
    ggplot2::labs(title = plot.title, 
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
  
  return(p)
}