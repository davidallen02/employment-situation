ppt_output <- function(p, image.name){
  ggplot2::ggsave(
    filename = paste0('./output/ppt/', image.name, '.png'),
    plot     = p,
    width    = 13.33,
    height   = 7.5,
    units    = 'in'
  )
}