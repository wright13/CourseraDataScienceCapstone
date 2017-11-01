# Load packages
library(data.table)
library(tidyverse)
library(quanteda)

# Unzip the dataset
unzip("Coursera-Swiftkey.zip", exdir = "data", overwrite = FALSE, setTimes = FALSE)
path.to.data <- "C:/Users/Sarah/Documents/R/DataScienceCapstone/data/final/en_US/"

# Create a connection to each English dataset (Twitter, news, and blogs)
blogs.con <- file(paste0(path.to.data, "en_US.blogs.txt"), "rb")
news.con <- file(paste0(path.to.data, "en_US.news.txt"), "rb")
twitter.con <- file(paste0(path.to.data, "en_US.twitter.txt"), "rb")

# Answering Quiz 1 questions:
# Count the number of lines in each file
# Find the length of the longest line in news and blogs
# In the twitter dataset, divide the number of lines where the word "love" occurs by the number of lines where the word "hate" occurs
# Find the only tweet in the twitter dataset that has the word "biostats"

# n.blogs <- 0
# max.length.blogs <- 0
# while (length(line <- readLines(blogs.con, n = 1, skipNul = TRUE)) > 0) {
#   n.blogs <- n.blogs + 1
#   if ((l <- nchar(line)) > max.length.blogs) max.length.blogs <- l
# }
# 
# n.news <- 0
# max.length.news <- 0
# while (length(line <- readLines(news.con, n = 1, skipNul = TRUE)) > 0) {
#   n.news <- n.news + 1
#   if ((l <- nchar(line)) > max.length.news) max.length.news <- l
# }
# 
# n.twitter <- 0
# n.love <- 0
# n.hate <- 0
# n.chess <- 0
# while (length(line <- readLines(twitter.con, n = 1, skipNul = TRUE)) > 0) {
#   n.twitter <- n.twitter + 1
#   n.love <- n.love + grepl("love", line)
#   n.hate <- n.hate + grepl("hate", line)
#   n.chess <- n.chess + grepl("A computer once beat me at chess, but it was no match for me at kickboxing", line)
#   if(length(temp <- grep("biostats", line, value = TRUE)) > 0) biostats <- temp
# }

# Sample 25% of the texts and save to a data table
sample <- data.table()
while (length(line <- readLines(blogs.con, n = 20, skipNul = TRUE, encoding = "UTF-8")) > 0) {
  if (rbinom(1, 1, 0.1)) sample <- rbind(sample, line)
}

while (length(line <- readLines(news.con, n = 20, skipNul = TRUE, encoding = "UTF-8")) > 0) {
  if (rbinom(1, 1, 0.1)) sample <- rbind(sample, line)
}

while (length(line <- readLines(twitter.con, n = 20, skipNul = TRUE, encoding = "UTF-8")) > 0) {
  if (rbinom(1, 1, 0.1)) sample <- rbind(sample, line)
}

write_csv(sample, path = "C:/Users/Sarah/Documents/R/DataScienceCapstone/textSample.csv", col_names = FALSE, append = FALSE)


# Close file connections
close(blogs.con)
close(news.con)
close(twitter.con)
