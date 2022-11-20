
# ______________________________ Packages and Libraries ______________________________

install.packages("data.table")
install.packages("tidyverse")
install.packages('microbenchmark')
install.packages("parallel")
install.packages("lme4")
install.packages("modeest")
install.packages("pastecs")
install.packages("ggpubr")
install.packages("ggplot2")
install.packages("scales")


library(data.table)
library(tidyverse)
library(microbenchmark)
library(parallel)
library(lme4)
library(modeest)
library(pastecs)
library(ggpubr)
library(ggplot2)
library(scales)




# ______________________________ CHAPTER 2 ______________________________

# Read Multiple CSV File

df <- function(i){
  list.files(path = "C:/Users/valor/Downloads/Tesco Grocery 1.0 Dataset/Area-Level Grocery Purchases/", pattern = "*.csv") %>% map_df(~fread(.))
}
df


# Sequential Processing
# Microbenchmark
mbm <- microbenchmark(lapply(1:100, df))
mbm
autoplot(mbm)

# System Time
seq <- system.time(lapply(1:100, df))


# Parallel Processing
numCores <- detectCores()
numCores

cl <- makeCluster(numCores)

clusterEvalQ(cl, {
  library(tidyverse)
  library(parallel)
  library(data.table)
})

system.time({
  parLapply(cl, 1:100, df)
  stopCluster(cl)
})




# ______________________________ CHAPTER 3 ______________________________

# Store the data in the variable "dataBorough"
dataBorough <- read.csv("C:/Users/valor/Downloads/Tesco Grocery 1.0 Dataset/Obesity_Borough.csv")

# Launch Dataset In RStudio Viewer
View(dataBorough)

# Print the first and last 5 rows
options(max.print = 999999)      # Increasing Limit of max.print

head(dataBorough, 5)
tail(dataBorough, 5)

# Utilising names() function to obtain names of object
names(dataBorough)

# Give details about the data's number of rows and columns, as well as the values in each column's corresponding head
str(dataBorough)

# Display statistical summary of the data 
summary(dataBorough)

# Change the value of digits
summary(dataBorough, digits = 1)




# ******************** Descriptive Statistics On Data ********************

# Compute the modal value (mode)
mode = mfv(dataBorough$fat)
print(mode)

# Compute the median value
median(dataBorough$fat)

# Compute the mean value
mean(dataBorough$fat)


# Compute the minimum value
min(dataBorough$fat)

# Compute the maximum value
max(dataBorough$fat)


# Range
range(dataBorough$fat)

# Compute range for each column
sapply(dataBorough[, -5], range)


# Compute the variance
var(dataBorough$fat)

# Compute the standard deviation
sd(dataBorough$fat)


# Quartile
quantile(dataBorough$fat)

# Interquartile
IQR(dataBorough$fat)


# Compute the descriptive statistics of each variable
res <- stat.desc(dataBorough[, -5])
round(res, 2)



# ******************** Graphical Display Of Distributions ********************


# Draw Boxplots based on the variables

# Carbohydrates (carbs)
ggboxplot(dataBorough, y = "carb", width = 0.7) + labs(x = "x", y = "Carbohydrate", title = "Box Plot of Carbohydrate")

# Fat
ggboxplot(dataBorough, y = "fat", width = 0.7) + labs(x = "x", y = "Fat", title = "Box Plot of Fat")

# Protein
ggboxplot(dataBorough, y = "protein", width = 0.7) + labs(x = "x", y = "Protein", title = "Box Plot of Protein")

# Fiber
ggboxplot(dataBorough, y = "fibre", width = 0.7) + labs(x = "x", y = "Fiber", title = "Box Plot of Fiber")

# The prevalence (percentage) of obese people
ggboxplot(dataBorough, y = "f_obese", width = 0.7) + labs(x = "x", y = "Obesity", title = "Box Plot Of Obesity")



# Draw Histograms based on the variables

# Carbohydrates (carbs)
gghistogram(dataBorough, x = "carb", bins = 10, add = "mean") + labs(x = "Carbohydrate", y = "Frequency", title = "Histogram Of Carbohydrate")

# Fat
gghistogram(dataBorough, x = "fat", bins = 10, add = "mean") + labs(x = "Fat", y = "Frequency", title = "Histogram Of Fat")

# Protein
gghistogram(dataBorough, x = "protein", bins = 10, add = "mean") + labs(x = "Protein", y = "Frequency", title = "Histogram Of Protein")

# Fiber
gghistogram(dataBorough, x = "fibre", bins = 10, add = "mean") + labs(x = "Fiber", y = "Frequency", title = "Histogram Of Fiber")

# The prevalence (percentage) of obese people
gghistogram(dataBorough, x = "f_obese", bins = 10, add = "mean") + labs(x = "Obesity", y = "Frequency", title = "Histogram Of Obesity")



# Empirical Cumulative Distribution Function (ECDF)

# Carbohydrates (carbs)
ggecdf(dataBorough, x = "carb") + labs(x = "Carbohydrate", y = "Frequency", title = "ECDF Of Carbohydrate")

# Fat
ggecdf(dataBorough, x = "fat") + labs(x = "Fat", y = "Frequency", title = "ECDF Of Fat")

# Protein
ggecdf(dataBorough, x = "protein") + labs(x = "Protein", y = "Frequency", title = "ECDF Of Protein")

# Fiber
ggecdf(dataBorough, x = "fibre") + labs(x = "Fiber", y = "Frequency", title = "ECDF Of Fiber")

# The prevalence (percentage) of obese people
ggecdf(dataBorough, x = "f_obese") + labs(x = "Obesity", y = "Frequency", title = "ECDF Of Obesity")



# Draw Quantile-Quantile Plots (Q-Q Plots)

# Carbohydrates (carbs)
ggqqplot(dataBorough, x = "carb") + labs(x = "Carbohydrate", y = "Frequency", title = "Q-Q Plot Of Carbohydrate")

# Fat
ggqqplot(dataBorough, x = "fat") + labs(x = "Fat", y = "Frequency", title = "Q-Q Plot Of Fat")

# Protein
ggqqplot(dataBorough, x = "protein") + labs(x = "Protein", y = "Frequency", title = "Q-Q Plot Of Protein")

# Fiber
ggqqplot(dataBorough, x = "fibre") + labs(x = "Fiber", y = "Frequency", title = "Q-Q Plot Of Fiber")

# The prevalence (percentage) of obese people
ggqqplot(dataBorough, x = "f_obese") + labs(x = "Obesity", y = "Frequency", title = "Q-Q Plot Of Obesity")




# Multiple Linear Regression

# Use dataBorough dataset
input <- dataBorough [1:50, c("f_obese", "carb", "fat", "protein", "fibre")]

# Building model
model <- lm(f_obese ~ carb + fat + protein + fibre, data = input)
model

# Display regression model
print(model)
print(summary(model))

# Plot the graph
plot(model)





