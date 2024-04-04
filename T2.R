library(reshape)

# Read the data
bloodPressure <- readRDS('bloodPressure.RDS')

# Reshape the data
bloodPressure_long <- reshape(
  data = bloodPressure,
  varying = list(
    grep("^systolic", names(bloodPressure), value = TRUE),
    grep("^diastolic", names(bloodPressure), value = TRUE)
  ),
  direction = "long",
  idvar = "person",
  timevar = "measurement",
  times = c("systolic", "diastolic"),
  v.names = c("systolic", "diastolic")
)

# Convert the date column to a proper date format
bloodPressure_long$date <- as.Date(bloodPressure_long$date, format = "%Y-%b-%d")

# Calculate mean diastolic and systolic by day of the week
bloodPressure_summary <- aggregate(value ~ measurement + format(date, "%A"), data = bloodPressure_long, FUN = mean)

# Print the resulting summary
print(bloodPressure_summary)
