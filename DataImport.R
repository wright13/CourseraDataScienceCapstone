# Load packages
library(data.table)
library(tidyverse)
library(quanteda)
library(readr)
library(R.utils)
setwd("M:/STAFF/WrightS/Classes/Data Science Capstone")

# Unzip the dataset
#unzip("Coursera-Swiftkey.zip", exdir = "data", overwrite = FALSE, setTimes = FALSE)
path.to.data <- paste0(getwd(), "/data/final/en_US/")

# Create a read connection to each English dataset (Twitter, news, and blogs)
blogs.con <- file(paste0(path.to.data, "en_US.blogs.txt"), "rb")
news.con <- file(paste0(path.to.data, "en_US.news.txt"), "rb")
twitter.con <- file(paste0(path.to.data, "en_US.twitter.txt"), "rb")

# Create a write connection to sample files
blogs.sample <- file(paste0(path.to.data, "blogs_sample.txt"), "w")
news.sample <- file(paste0(path.to.data, "news_sample.txt"), "w")
twitter.sample <- file(paste0(path.to.data, "twitter_sample.txt"), "w")

# Get the number of lines in each file
blogs.n <- countLines(paste0(path.to.data, "en_US.blogs.txt"))
news.n <- countLines(paste0(path.to.data, "en_US.news.txt"))
twitter.n <- countLines(paste0(path.to.data, "en_US.twitter.txt"))

p <- 0.1    # Proportion of text to sample
lines.n <- 1    #Number of lines to sample at a time

# Set seed
set.seed(110317)

# Sample texts
all.data <- data.table()

sample.line <- rbinom(blogs.n, 1, p)
for (i in 1:blogs.n) {
    line <- readLines(blogs.con, n = lines.n, skipNul = TRUE, encoding = "UTF-8")
    if (sample.line[i]) writeLines(line, con = blogs.sample)
}

sample.line <- rbinom(news.n, 1, p)
for (i in 1:news.n) {
    line <- readLines(news.con, n = lines.n, skipNul = TRUE, encoding = "UTF-8")
    if (sample.line[i]) writeLines(line, con = news.sample)
}

sample.line <- rbinom(twitter.n, 1, p)
for (i in 1:twitter.n) {
    line <- readLines(twitter.con, n = lines.n, skipNul = TRUE, encoding = "UTF-8")
    if (sample.line[i]) writeLines(line, con = twitter.sample)
}


# Close file connections
close(blogs.con)
close(news.con)
close(twitter.con)

close(blogs.sample)
close(news.sample)
close(twitter.sample)
