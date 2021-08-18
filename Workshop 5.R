install.packages("MASS")
install.packages("ISLR")

library(tidymodels)
library(MASS)
library(ISLR)
set.seed(123)

#specify the model
lm_spec<-linear_reg()%>%
  set_mode("regression")%>%
set_engine("lm")

data("Boston")

#2 take model specification from step 1 and apply to your data = use fit()
#and put formula y~x
lm_fit<-lm_spec%>%
  fit(data=Boston, medv~lstat)

lm_fit%>%pluck("fit") %>%
  summary()

tidy(lm_fit)

#use the fitted model from step2 to predict new y in the new data
predict(lm_fit, new_data = Boston)

#examining the new predicted values
final_model<-augment(lm_fit, new_data = Boston)


rm(list = ls())
data(Boston)
#1
model_spec<-linear_reg()%>%
  set_mode("regression")%>%
  set_engine("lm")
#2
model_fit<-model_spec%>%fit(data=Boston, medv~age+crim+rm)

#3
model_predict_augument<-augument(model_fit, new_data = Boston)

#
model_lm_fit<-model_lm_spec%>%
  fit(data=Boston, medv~.)

#
model_lm_augm<-augument(model_lm_fit, new_data=Boston)


augument()

#
model_rf_spec<-rand_forest()%>%
  set_mode("regression")%>%
  set_engine("ranger")

install.packages("ranger")