
# ______________________________ Packages and Libraries ______________________________

install.packages("data.table")
install.packages("tidyverse")
install.packages('microbenchmark')
install.packages("parallel")
install.packages("lme4")


install.packages("ggplot2")


library(data.table)
library(tidyverse)
library(microbenchmark)
library(parallel)
library(lme4)

library(ggplot2)




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


# Load And Read Grocery Dataset
groceryData_Borough <- read.csv("C:/Users/valor/Downloads/Tesco Grocery 1.0 Dataset/Obesity_Borough/")

# Launch Dataset In RStudio Viewer
View(groceryData_Borough)

# Display the first and last 5 rows of data
head(groceryData_Borough, 5)
tail(groceryData_Borough, 5)










# ______________________________        ______________________________




Obesity






# ______________________________        ______________________________












