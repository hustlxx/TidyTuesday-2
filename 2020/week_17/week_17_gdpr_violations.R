library(tidyverse)

gdpr_violations <- read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-21/gdpr_violations.tsv')

set.seed(2817)

axis_ <- tibble(axis_x = runif(250),
                 axis_y = runif(250))

data_graph <- gdpr_violations %>% 
    select(name, price, controller) %>% 
    bind_cols(axis_) %>% 
    mutate(label = str_c(controller, "\n",
                         scales::dollar(price, suffix = "€", prefix = ""), "\n",
                         name))

p1 <- 
    ggplot() +
    geom_point(data = data_graph, aes(axis_x, axis_y, size = price), colour = "#39b185", alpha = 0.7) +
    scale_size(range = c(2, 80)) +
    geom_point(data = data_graph, aes(axis_x, axis_y), colour = "#353e4a", size = 1.5) +
    geom_text(data = data_graph %>% filter(price > 1000000),
              aes(axis_x, axis_y, label = label),
              size = 4, fontface = "bold",
              family = "Roboto Condensed", color = "grey90") +
    xlim(-0.02, 1) +
    labs(title = "The Universe of GDPR Violations",
         subtitle = "Top Companies",
         caption = "Source: Privacy Affairs | Graphic: @ysamano28 ") +
    theme_ybn(colour_background = "#1b1f2b",
              base_colour = "gray95",
              title_size = 25,
              title_face = "bold",
              title_hjust = 0.5,
              subtitle_size = 18,
              caption_hjust = 0.5,
              plot_margin = margin(20, 10, 20, 10),
              axis_grid = F,
              axis_text = F,
              axis_title = F) +
    theme(legend.position = "none")

ggsave("2020/week_17/gdpr_violations2.png", p1, height = 11, width = 8.5, units = "in", dpi = 300)
