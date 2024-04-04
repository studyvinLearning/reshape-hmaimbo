# Load the required package
data(federalistPapers, package='syllogi')

# A. Create a data frame that has paper number, author, journal, date

# Initialize empty vectors
paper_numbers <- character(86)
authors <- character(86)
journals <- character(86)
dates <- character(86)  # Initialize as character vector

# Loop through each element of the list
for (i in seq_along(federalistPapers)) {
  # Extract the meta dataframe from each element
  paper_meta <- federalistPapers[[i]]$meta
  
  # Store the extracted values in the corresponding vectors
  paper_numbers[i] <- paper_meta$number
  authors[i] <- paper_meta$author
  journals[i] <- paper_meta$journal
  dates[i] <- as.character(paper_meta$date)  # Convert to character
}

# Convert dates to Date format with the specified format
dates <- as.Date(dates, format = "%Y-%m-%d")

# Create the dataframe
federalist_df <- data.frame(
  Paper_Number = paper_numbers,
  Author = authors,
  Journal = journals,
  Date = dates
)

print(federalist_df)

# B. Determine the day of the week that each paper was published.
federalist_df$Day_of_Week <- weekdays(federalist_df$Date)
print(federalist_df)

# C. Get the count of papers by day of the week and author
count_by_day_author <- table(federalist_df$Day_of_Week, federalist_df$Author)
print(count_by_day_author)

# D. create a new data frame that has authors as column names and dates of publication as the values
library(reshape2)
# Pivot the data frame
author_date_df <- dcast(federalist_df, Date ~ Author, value.var = "Date")
print(author_date_df)


