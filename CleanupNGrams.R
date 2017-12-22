library(tidyverse)
library(quanteda)
library(data.table)

#setwd("M:/STAFF/WrightS/Classes/Data Science Capstone")
setwd("C:/Users/sewright/Documents/R/Classes/CourseraDataScienceCapstone")

# Read in 1- through 6-grams
one.grams <- fread("one_grams_count.txt")
two.grams <- fread("two_grams_count.txt")
three.grams <- fread("three_grams_count.txt")
four.grams <- fread("four_grams_count.txt")

# Calculate total occurrences of all n-grams
n.one.grams <- sum(one.grams$count)
n.two.grams <- sum(two.grams$count)
n.three.grams <- sum(three.grams$count)
n.four.grams <- sum(four.grams$count)

# Add column calculating n-gram cumulative percentage of total occurences
nrow(one.grams[cumulative.proportion <= 0.90])
nrow(two.grams[cumulative.proportion <= 0.90])
nrow(three.grams[cumulative.proportion <= 0.90])
nrow(four.grams[cumulative.proportion <= 0.90])