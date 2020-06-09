# Google Play Apps Data Explorer

## Introduction

This shiny apps is a data exploratory tools the see data correlation from Google Play Data in the form of scatter plot and tables. 
The aims of this shiny app to help user exploring Google Play Apps data based on choosen x and y axis. 

## Data Sources
Data source for this task was donwloaded from Kaggle that include google apps data that last updated on January 2019 which can be found here: https://www.kaggle.com/lava18/google-play-store-apps.

Then library that required for this apps are (dplyr,ggvis, data.table)

## How to Use

The step to use this app is straight forward. Once it launched, it automatically shows some default value in **Plot** and **Tables** Tabs. Then there are some customisable filter that can be used to explores the data and modify the visualisation.

Some filter that can be used:<br>
1. X-axis variable : Change x-axis value on the chart <br>
2. Y-axis variable : Change y-axis value on the chart <br>
3. Apps Category in Google Play : Filter the chart and table to only specific category (i.e.BUSINESS, BEAUTY, FINANCE,...) <br>
4. Apps Rated : Filter the chart and table to only show specific rated, (i.e. Everyone, Teen, Mature 17, ...) <br>
5. Apps Rating : Filter min and max rating given by users <br>
6. Apps Size : Filter based on min and max apps size in MB

This chart and table will be automatically updated once you change the filters.

## Thank you
