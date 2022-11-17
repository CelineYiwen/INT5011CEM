
# ______________________________ Packages and Libraries ______________________________

install.packages("data.table")
install.packages("tidyverse")
install.packages('microbenchmark')
install.packages("parallel")
install.packages("lme4")
install.packages("modeest")
install.packages("ggpubr")
install.packages("ggplot2")
install.packages("scales")


library(data.table)
library(tidyverse)
library(microbenchmark)
library(parallel)
library(lme4)
library(modeest)
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



# ******************** Descriptive Analysis ********************

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

# Compute the variance
var(dataBorough$fat)

# Compute the standard deviation
sd(dataBorough$fat)





# Quartile
quantile(dataBorough$fat)

# Compute quartiles for each column
sapply(dataBorough[, -5], quantile)


# Deciles
quantile(my_data$Sepal.Length, seq(0, 1, 0.1))


# Interquartile
IQR(dataBorough$fat)


install.packages("pastecs")
library(pastecs)
res <- stat.desc(my_data[, -5])
round(res, 2)






# ______________________________        ______________________________



Obesity








