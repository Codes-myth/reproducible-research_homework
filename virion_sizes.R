# Looking at question 5 
# Probing the relationship between virus genome size and virion volume

# install.packages("dplyr")

library(dplyr)
library(ggplot2)

# Importing of dataset
Cui_etal2014.csv <- read_csv("question-5-data/Cui_etal2014.csv")

# How many rows and columns does the data have? ----
summary(virionvolumes)

# data has 13 columns with 33 observations meaning there are 33 rows excluding
# the title row 


# What type of transformation allows for fitting of linear model? ----

# creation of new data set with only virion volume and genome length columns 
# and the spaces in column header names removed

virionvolumes <- Cui_etal2014.csv %>% rename(virion_volume = `Virion volume (nm×nm×nm)`,
                                             genome_length = `Genome length (kb)`) %>%
  select(virion_volume, genome_length)

# Virion volume is in nm^3 while the genome length is in kb


# Looking at the relationship between genome length and virion volume
(ggplot(data = virionvolumes, aes(x = genome_length, y = virion_volume) ) + 
    geom_point())

# Performance of transformation ----
# addition of log columns for the transformation
# log in r is base e 
# careful as if run again this would overwrite object
virionvolumes <- virionvolumes %>% mutate(log_volume = log(virion_volume)) %>% 
  mutate(log_genome = log(genome_length))


# Running of linear model to find the exponent and scaling factor ----
log_vol_model <- lm(log_volume ~ log_genome, virionvolumes)
summary(log_vol_model)

# intercept is the log base e of the scaling factor which has a value of 7.0748
# gradient is the exponent which has a value of 1.5152

# therefore scaling factor value = 
exp(7.0748)
# 1181.807

# Reproducing plot ----

(genome_volume_plot.png <- ggplot(data = virionvolumes) + 
    geom_point(data = virionvolumes, aes(x = log_genome, y = log_volume), size = 0.75) +
    geom_smooth(method = "lm", aes(x = log_genome, y = log_volume)) +
    xlab("log[Genome length (kb)]") +
    ylab("log[Virion volume (nm3)]") +
    theme_bw() +
   theme(
      axis.text.x = element_text(size = 6), 
      axis.text.y = element_text(size = 6), 
      axis.title = element_text(size = 7)
    ))

ggsave(filename = "genome_volume_plot.png")


# Finding estimated volume of a 300 kb dsDNA virus ----
# Use of the equation provided and calculated values of the exponent and scaling
# factor
1181.807*(300^1.5152)

# volume is 6697006 nm^3 or 6.70 x10^6 (3sf) 
