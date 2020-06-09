# Variables that can be put on the x and y axes
axis_vars <- c(
  "Category" = "Category",
  "Numeric Rating" = "Rating",
  "Number of reviews" = "Reviews",
  "Size in MB" = "Size..MB.",
  "Price" = "Price"
)

# Setting Library
library(dplyr)
library(ggvis)
library(data.table)

# Preparing Dataset
df <- read.csv("googleplaystore.csv",sep = ",")
summary(df)

# Generate unique values for filter
cat_df <- df %>% distinct(Category)
rated_df <- df %>% distinct(Content.Rating)