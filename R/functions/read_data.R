read_data <- function(index_name){
  dat <- readxl::read_xlsx(
    path      = paste0('./data/data.xlsx'), 
    sheet     = index_name,
    skip      = 5, 
    # col_types = c('date', 'numeric'),
    na        = '#N/A N/A'
  ) 
  
  return(dat)
}