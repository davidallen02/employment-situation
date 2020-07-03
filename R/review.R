library(magrittr)

actual <- pamngr::get_data("nfp tch", flds = "PX_LAST") %>%
  dplyr::left_join(pamngr::get_data('usurtot', flds = "PX_LAST"), by = "dates") %>%
  dplyr::left_join(pamngr::get_data('ahe yoy%', flds = "PX_LAST"), by = "dates") %>%
  set_colnames(c('date','payrolls','u3','ahe')) %>%
  dplyr::filter(date == max(date))

current.period <- actual %>%
  dplyr::select(date) %>%
  dplyr::pull() %>%
  format('%B %Y')

payrolls <- actual %>%
  dplyr::select(payrolls) %>%
  dplyr::pull() %>%
  scales::comma() %>%
  paste0('k') %>%
  grid::textGrob(gp = grid::gpar(fontsize = 40, col = '#850237'), just = 'center')

u3 <- actual %>%
  dplyr::select(u3) %>%
  dplyr::pull() %>%
  paste0('%')  %>%
  grid::textGrob(gp = grid::gpar(fontsize = 40, col = '#850237'), just = 'center')

ahe <- actual %>%
  dplyr::select(ahe) %>%
  dplyr::pull() %>%
  paste0('%') %>%
  grid::textGrob(gp = grid::gpar(fontsize = 40, col = '#850237'), just = 'center')


title <- 'Employment Situation\n' %>% 
  grid::textGrob(gp = grid::gpar(fontsize = 50, fontface = 'bold'), just = 'top')

date <- current.period %>% grid::textGrob(gp = grid::gpar(fontsize = 35))

subtitle.1 <- paste0('Monthly Change\nin Nonfarm Payrolls') %>% 
  grid::textGrob(gp = grid::gpar(fontsize = 30), just = 'top')

subtitle.2 <- paste0('U-3 Unemployment\nRate') %>% 
  grid::textGrob(gp = grid::gpar(fontsize = 30), just = 'top')

subtitle.3 <- 'Annual Growth in Avg\nHourly Earnings' %>% 
  grid::textGrob(gp = grid::gpar(fontsize = 30), just = 'top')

blank <- grid::textGrob(' ')

lay <- rbind(c(1,1,1),
             c(2,2,2),
             c(3,4,5),
             c(6,7,8),
             c(9,9,9))

gridExtra::grid.arrange(title, 
                        date,
                        subtitle.1, subtitle.2, subtitle.3, 
                        payrolls, u3, ahe,
                        blank,
                        layout_matrix = lay) %>% 
  pamngr::ppt_output('review.png')


