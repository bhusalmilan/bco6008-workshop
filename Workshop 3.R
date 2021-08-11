library(tidymodels)
library(skimr)
library(janitor)

recipes_muffins_cupcakes%>%skim()

#clean variable name
muffin_cupcake<-recipes_muffins_cupcakes%>%
  clean_names()

muffin_cupcake%>%count(type)

#splitting the cleaned data set into training vs testing - inter mate structure
muffin_cupcake_split<-initial_split(muffin_cupcake)
muffin_cupcake_split

#save training and testing data sets separately
muffin_cupcake_training<-training(muffin_cupcake_split)
muffin_cupcake_testing<-testing(muffin_cupcake_split)

#create a recipe

muffin_recipe<-recipe(type~flour+milk+sugar+egg, data = muffin_cupcake_training)
muffin_recipe

muffin_recipe_steps<-muffin_recipe%>%
  step_impute_mean(all_numeric())%>%
  step_center(all_numeric())%>%
  step_scale(all_numeric())
muffin_recipe_steps

#prep the recipe
prepped_recipe<-prep(muffin_recipe_steps, training=muffin_cupcake_training)
prepped_recipe

#bake
muffin_train_preprocessed<-bake(prepped_recipe, muffin_cupcake_training)

muffin_testing_preprocessed<-bake(prepped_recipe, muffin_cupcake_testing)

  