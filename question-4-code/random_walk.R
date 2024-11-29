#install.packages("ggplot2")
#install.packages("gridExtra")

library(ggplot2)
library(gridExtra)

# Creation of reproducible Brownian motion
# addition of a random seed into the function allowing for outputs to be reproducible
# set.seed() function should assign seed input to a specific random walk Brownian
# motion output

# seed number is now specified after the number of steps argument in the reproducible 
# random walk function inputs

random_walk  <- function (n_steps, seed) {
  
  set.seed(seed)
  
  df <- data.frame(x = rep(NA, n_steps), y = rep(NA, n_steps), time = 1:n_steps)
  
  df[1,] <- c(0,0,1)
  
  for (i in 2:n_steps) {
    
    h <- 0.25
    
    angle <- runif(1, min = 0, max = 2*pi)
    
    df[i,1] <- df[i-1,1] + cos(angle)*h
    
    df[i,2] <- df[i-1,2] + sin(angle)*h
    
    df[i,3] <- i
    
  }
  
  return(df)
  
}

data1 <- random_walk(500, 12)

plot1 <- ggplot(aes(x = x, y = y), data = data1) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")

data2 <- random_walk(500, 12)

plot2 <- ggplot(aes(x = x, y = y), data = data2) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")


(grid.arrange(plot1, plot2, ncol=2))

# Comparison of the two graphs
# Both should show the same pattern if the seed argument is working as both have
# the same seed number input of 12

# The same pattern is shown in both indicating that the seed generation and 
# reproducibility are working



# The steps below were for the previous sections of code to help describe the 
# patterns seen on the random walk plot

# (randomwalkplots.png <- grid.arrange(plot1, plot2, ncol=2))
# ggsave(randomwalkplots.png, file = "randomwalkplots.png", width = 5.5)



