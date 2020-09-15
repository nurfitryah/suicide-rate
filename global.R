library(dplyr)
library(ggplot2)
library(tidyverse)
library(plotly)
library(glue)
library(ggthemes)
library(highcharter)
library(shiny)
library(shinydashboard)

age_suicide <- read.csv("Age-standardized suicide rates.csv")

crude <- read.csv("Crude suicide rates.csv")

colnames(crude) <- c("Country", "Sex", "80_above", "70to79", "60to69", "50to59", "40to49", "30to39", "20to29", "10to19")

facilities <- read.csv("Facilities.csv")

h_resouces <- read.csv("Human Resources.csv")

suicide_sex <- age_suicide %>% 
  group_by(Sex) %>% 
  summarise("2016" = sum(X2016),
            "2015" = sum(X2015),
            "2010" = sum(X2010),
            "2000" = sum(X2000)) %>%
  pivot_longer(cols = c("2016", 
                        "2015", 
                        "2010", 
                        "2000"),
               names_to = "year")



