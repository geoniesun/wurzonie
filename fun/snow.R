#===============================================================================
# 2019-12-07 -- twitter
# Generate snow and animate it
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

library(tidyverse)
library(magrittr)
library(gganimate)


# generate the init df
n <- 1e2

df <- tibble(
  id = 1:n,
  x = runif(n),
  y = runif(n),
  size = runif(n, min = 4, max = 20)
) 




# helper function to ensure the snowflakes don't disappear ----------------

# function for one snowflake
loop_single <- function(value){
  if(value %>% is_less_than(0)){value <- 1}
  if(value %>% is_greater_than(1)){value <- 0}
  return(value)
}

# vectorize
loop_multiple <- function(values){
  values %>% map_dbl(loop_single)
}



# create a larger dataframe with frames for snowflake movement ------------


# function to create smooth frames for snowflake falling
fun_framing <- function(df, n_frames = 100, wind = 0){
  
  # frames vector
  frames <- seq(1, n_frames)
  
  # empty list
  out <- list()
  
  # place the init df in the first element
  out[[1]] <- df
  
  # length of the df
  len <- nrow(df)
  
  
  for (i in seq_along(frames)) {
    
    # calculate x shift,  unique for each snowflake
    x_shift <- runif(len, -.5, .5) %>% add(wind)
    
    dfi <- out[[i]] %>% 
      mutate(
        x = x %>% 
          add(x_shift %>% multiply_by(size/1e3)) %>% 
          loop_multiple(),
        y = y %>% 
          subtract(size/1e3) %>% 
          loop_multiple()
      ) 
    out[[i+1]] <- dfi
  }
  
  # bind list
  out <- out %>% 
    bind_rows(.id = "frame") %>% 
    mutate(frame = frame %>% as.numeric)
  return(out)
}


# generate the data and plot/animate --------------------------------------

# generate df for animation    
df_anim <- df %>% fun_framing(n_frames = 1e2, wind = -1)


# plot to animate
p <- df_anim %>% 
  ggplot(aes(x, y, size = size)) + 
  geom_point(color = "white", shape = 42)+
  scale_size_identity()+
  coord_cartesian(c(0, 1), c(0, 1), expand = FALSE)+
  theme_void()+
  theme(panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black"))

# add transition
ani <- p + 
  transition_time(frame)+ 
  ease_aes('linear')+
  enter_fade()+
  exit_fade()

# define the number of data points
nfr <- df_anim %>% pull(frame) %>% unique() %>% length()

# animate
animate(
  ani, 
  nframes = nfr, fps = 10, 
  # device = "svg", renderer = magick_renderer(loop = TRUE),
  width = 500, height = 500
)

# save the output
anim_save("animated-snow.gif")