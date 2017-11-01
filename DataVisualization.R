# Clear the environment
rm(list = ls())

# Load packages
library(data.table)
library(tidyverse)
library(quanteda)

CountNGrams <- function(n.gram.list, token) {
  n.grams.count <- as.data.table(n.gram.list)
  n.grams.count[, count := .N, by = token]
  setorder(n.grams.count, -count)
  n.grams.count <- unique(n.grams.count)
  n.grams.count[, cumulative.count := cumsum(count),]
  return(n.grams.count)
}

one.grams <- read.csv("C:/Users/Sarah/Documents/R/DataScienceCapstone/one_grams.csv", header = FALSE, as.is = TRUE, col.names = "one.gram")
one.grams.count <- CountNGrams(one.grams, "one.gram")
rm(one.grams)

two.grams <- read.csv("C:/Users/Sarah/Documents/R/DataScienceCapstone/two_grams.csv", header = FALSE, as.is = TRUE, col.names = "two.gram")
two.grams.count <- CountNGrams(two.grams, "two.gram")
rm(two.grams)

three.grams <- read.csv("C:/Users/Sarah/Documents/R/DataScienceCapstone/three_grams.csv", header = FALSE, as.is = TRUE, col.names = "three.gram")
three.grams.count <- CountNGrams(three.grams, "three.gram")
rm(three.grams)

four.grams <- read.csv("C:/Users/Sarah/Documents/R/DataScienceCapstone/four_grams.csv", header = FALSE, as.is = TRUE, col.names = "four.gram")
four.grams.count <- CountNGrams(four.grams, "four.gram")
rm(four.grams)

five.grams <- read.csv("C:/Users/Sarah/Documents/R/DataScienceCapstone/five_grams.csv", header = FALSE, as.is = TRUE, col.names = "five.gram")
five.grams.count <- CountNGrams(five.grams, "five.gram")
rm(five.grams)

six.grams <- read.csv("C:/Users/Sarah/Documents/R/DataScienceCapstone/six_grams.csv", header = FALSE, as.is = TRUE, col.names = "six.gram")
six.grams.count <- CountNGrams(six.grams, "six.gram")
rm(six.grams)

write_csv(one.grams.count, path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/one_grams_count.csv")
write_csv(two.grams.count, path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/two_grams_count.csv")
write_csv(three.grams.count, path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/three_grams_count.csv")
write_csv(four.grams.count, path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/four_grams_count.csv")
write_csv(five.grams.count, path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/five_grams_count.csv")
write_csv(six.grams.count, path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/six_grams_count.csv")
