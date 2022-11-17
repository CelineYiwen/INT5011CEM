
# ______________________________ Packages and Libraries ______________________________


install.packages("data.table")
install.packages("tidyverse")
install.packages('microbenchmark')
install.packages("parallel")

install.packages("ggplot2")



library(data.table)
library(tidyverse)
library(microbenchmark)
library(parallel)

library(ggplot2)





# ______________________________ CHAPTER 2 ______________________________


# Load Data And Read Multiple CSV File
df <- function(i){
  list.files(path = "C:/Users/valor/Downloads/Tesco Grocery 1.0 Dataset/Area-Level Grocery Purchases/Jan_borough_grocery/", pattern = "*.csv") %>% map_df(~fread(.))
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












# ______________________________        ______________________________











# ______________________________        ______________________________












