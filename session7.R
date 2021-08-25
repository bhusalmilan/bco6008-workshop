library(tidymodels)
library(tidyverse)
library(skimr)
install.packages("ranger")
library(ranger)

volcano_raw <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-12/volcano.csv')


skim(volcano_raw)
volcano_raw%>%filter(last_eruption_year!="Unknown")

volcano_raw%>%count(primary_volcano_type, sort = TRUE)

volcano_df <- volcano_raw %>%
  transmute(volcano_type = case_when(str_detect(primary_volcano_type, "Stratovolcano") ~ "Stratovolcano",
                                     str_detect(primary_volcano_type, "Shield") ~ "Shield",
                                     TRUE ~ "Other"),
            volcano_number, latitude, longitude, elevation, 
            tectonic_settings, major_rock_1) %>%
  mutate_if(is.character, factor)

volcano_df%>%count(volcano_type)

#data split, recipe

set.seed(123)

#test vs training portioning

volcano_df_split<-initial_split(volcano_df)
volcano_train<-training(volcano_df_split)
volcano_test<-testing(volcano_df_split)

volcano_train%>%count(volcano_type)
volcano_test%>%count(volcano_type)

#bootstrapping
volcano_boot<-bootstraps(volcano_df)

#recipe

volcano_df%>%count(volcano_number)
class(volcano_df$volcano_number)

volcano_rec <- recipe(volcano_type ~ ., data = volcano_df) %>%
  update_role(volcano_number, new_role = "Id") %>%
  step_other(tectonic_settings) %>%
  step_other(major_rock_1) %>%
  step_dummy(tectonic_settings, major_rock_1) %>%
  step_zv(all_predictors()) %>%
  step_normalize(all_predictors()) %>%
  step_smote(volcano_type)

 #extract data from the one you used in a recipe
juice(volcano_prep)



#modelling

rf_spec <- rand_forest(trees = 1000) %>%
  set_mode("classification") %>%
  set_engine("ranger"
             

