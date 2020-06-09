fluidPage(
  
  # Application title
  titlePanel("Google Play Apps Data Explorer"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(2,
    wellPanel(
      selectInput("xvar", "X-axis variable", axis_vars, selected = "Rating"),
      selectInput("yvar", "Y-axis variable", axis_vars, selected = "Reviews"),
      selectInput("category", "Apps Category in Google Play",
                  c("All",cat_df)
      ),
      selectInput("content_rate", "Apps Rated",
                  c("All",rated_df)
      ),
      sliderInput("ratings",
                  "Apps rating:",
                  min = 1,
                  max = 5,
                  sep = "",
                  value = c(1,5)),
      sliderInput("size",
                  "Apps size:",
                  min = 0,
                  max = 100,
                  sep = "",
                  value = c(50,100))
      
      )
    ),
    
    # Show a plot of the generated distribution
    column(10,
      tabsetPanel(
        tabPanel("Plot",
                 "Google Apps Data Exploration Plot",
                 ggvisOutput("plot1")), 
        tabPanel("Table",
                 "Google Apps Exploration Data",
                 DT::dataTableOutput("table")), 
        tabPanel("Help", includeMarkdown("Documentation.Rmd"))
      )
    )
  )
)

