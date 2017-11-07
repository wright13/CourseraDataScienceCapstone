# Clear the environment
rm(list = ls())

# Load packages
library(data.table)
library(tidyverse)
library(quanteda)

setwd("M:/STAFF/WrightS/Classes/Data Science Capstone")

CountNGrams <- function(n.gram.table, token) {
  #n.grams.count <- as.data.table(n.gram.list)
  n.gram.table[, count := .N, by = token]
  setorder(n.gram.table, -count)
  n.gram.table <- unique(n.gram.table)
  n.gram.table[, cumulative.count := cumsum(count)]
  n.gram.table[, cumulative.proportion := cumulative.count/sum(count)]
  return(n.gram.table)
}

one.grams <- fread(paste0(getwd(), "/one_grams.txt"), header = FALSE, col.names = "one.gram")
one.grams.count <- CountNGrams(one.grams, "one.gram")
rm(one.grams)

two.grams <- fread(paste0(getwd(), "/two_grams.txt"), header = FALSE, col.names = "two.gram")
two.grams.count <- CountNGrams(two.grams, "two.gram")
rm(two.grams)

three.grams <- fread(paste0(getwd(), "/three_grams.txt"), header = FALSE, col.names = "three.gram")
three.grams.count <- CountNGrams(three.grams, "three.gram")
rm(three.grams)

four.grams <- fread(paste0(getwd(), "/four_grams.txt"), header = FALSE, col.names = "four.gram")
four.grams.count <- CountNGrams(four.grams, "four.gram")
rm(four.grams)

write_csv(one.grams.count, path = paste0(getwd(), "/one_grams_count.txt"))
write_csv(two.grams.count, path = paste0(getwd(), "/two_grams_count.txt"))
write_csv(three.grams.count, path = paste0(getwd(), "/three_grams_count.txt"))
write_csv(four.grams.count, path = paste0(getwd(), "/four_grams_count.txt"))
