install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")
install.packages("tidymodels")


library(tidyverse)
library(tidymodels)
library(skimr)
library(janitor)

olympics<-read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-27/olympics.csv')
olympics%>%head()
