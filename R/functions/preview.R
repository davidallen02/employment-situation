library(magrittr)

consensus <- read_data('nfp tch') %>%
  dplyr::select(Dates, BN_SURVEY_MEDIAN) %>%
  dplyr::left_join(
    y = read_data('usurtot') %>% dplyr::select(Dates, BN_SURVEY_MEDIAN),
    by = 'Dates'
  ) %>%
  dplyr::left_join(
    y = read_data('ahe yoy%') %>% dplyr::select(Dates, BN_SURVEY_MEDIAN),
    by = 'Dates'
  ) %>%
  set_colnames(c('date','payrolls','u3','ahe')) %>%
  dplyr::filter(date == max(date))

current.period <- consensus %>%
  dplyr::select(date) %>%
  dplyr::pull() %>%
  format('%B %Y')

payrolls <- consensus %>%
  dplyr::select(payrolls) %>%
  dplyr::pull() %>%
  paste0('k') %>%
  grid::textGrob(gp = grid::gpar(fontsize = 40, col = '#850237'),
                 just = 'bottom')

u3 <- consensus %>%
  dplyr::select(u3) %>%
  dplyr::pull() %>%
  paste0('%')  %>%
  grid::textGrob(gp = grid::gpar(fontsize = 40, col = '#850237'),
                              just = 'bottom')

ahe <- consensus %>%
  dplyr::select(ahe) %>%
  dplyr::pull() %>%
  paste0('%') %>%
  grid::textGrob(gp = grid::gpar(fontsize = 40, col = '#850237'),
                 just = 'bottom')


title <- 'Employment Situation\n' %>% grid::textGrob(
  gp = grid::gpar(fontsize = 50, fontface = 'bold'),
  just = 'top'
)

date <- paste0(current.period, '\nConsensus Estimates') %>% grid::textGrob(
  gp = grid::gpar(fontsize = 35)
)

subtitle.1 <- paste0('Monthly Change\nin Nonfarm Payrolls') %>% 
  grid::textGrob(gp = grid::gpar(fontsize = 30),
                 just = 'top')
subtitle.2 <- paste0('U-3 Unemployment\nRate') %>% 
  grid::textGrob(gp = grid::gpar(fontsize = 30),
                 just = 'top')
subtitle.3 <- 'Annual Growth in Avg\nHourly Earnings' %>% 
  grid::textGrob(gp = grid::gpar(fontsize = 30),
                 just = 'top')


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
  ppt_output('preview')


