# Load packages
library(data.table)
library(tidyverse)
library(quanteda)
library(readr)
library(R.utils)

#setwd("M:/STAFF/WrightS/Classes/Data Science Capstone")

# Unzip the dataset
#unzip("Coursera-Swiftkey.zip", exdir = "data", overwrite = FALSE, setTimes = FALSE)
path.to.data <- paste0(getwd(), "/data/final/en_US/")

# Create a read connection to each English dataset (Twitter, news, and blogs)
blogs.con <- file(paste0(path.to.data, "en_US.blogs.txt"), "rb", encoding = "UTF-8")
news.con <- file(paste0(path.to.data, "en_US.news.txt"), "rb", encoding = "UTF-8")
twitter.con <- file(paste0(path.to.data, "en_US.twitter.txt"), "rb", encoding = "UTF-8")

# Create a write connection to testing data
train <- lapply(paste0(getwd(), "/data/final/en_US/train_", 1:10, ".txt"), file, "w")
test <- file(paste0(path.to.data, "test.txt"), "w")

# Get the number of lines in each file
blogs.n <- countLines(paste0(path.to.data, "en_US.blogs.txt"))
news.n <- countLines(paste0(path.to.data, "en_US.news.txt"))
twitter.n <- countLines(paste0(path.to.data, "en_US.twitter.txt"))

p <- 0.8    # Proportion of text to sample

# Set seed
set.seed(110317)

# Split texts into training and testing sets. Write the training data to multiple files so that tokenization can be done in chunks
splitTexts <- function(read.con, lines.n) {
    is.training <- rbinom(lines.n, 1, p)
    file.number <- rep_along(is.training, 1:10)
    for (i in 1:lines.n) {
        line <- readLines(read.con, n = 1, skipNul = TRUE, encoding = "UTF-8")
        if (is.training[i]) {
            writeLines(line, con = train[[file.number[i]]])
        } else {
            writeLines(line, con = test)
        }
    }
    close(read.con)
}

splitTexts(blogs.con, blogs.n)
splitTexts(news.con, news.n)
splitTexts(twitter.con, twitter.n)

# Close file connections
invisible(lapply(train, close))
close(test)