library(tidymodels)
data(ames)
ames$Sale_Price%>%head()

library(skimr)
ames<-ames%>%mutate(Sale_Price=log10(Sale_Price))
