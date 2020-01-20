# Setting Library
library(dplyr)
library(ggvis)
library(data.table)

# Preparing Dataset
df <- read.csv("googleplaystore.csv",sep = ",")
summary(df)

# Generate unique values for filter
cat_df <- df %>% distinct(Category)
rated_df <- df %>% distinct(Content.Rating)

function(input, output) {
  
  # Filter the movies, returning a data frame
  apps <- reactive({
    # Due to dplyr issue #318, we need temp variables for input values
    minrating <- input$ratings[1]
    maxrating <- input$ratings[2]
    minsize <- input$size[1]
    maxsize <- input$size[2]
    
    # Apply filters
    m <- df %>%
      filter(
        Rating >= minrating,
        Rating <= maxrating,
        Size..MB. >= minsize,
        Size..MB. <= maxsize
      ) 
    
    # Optional: filter by category
    if (input$category != "All") {
      m <- m %>% filter(Category == input$category )
    }
    # Optional: filter by content rated
    if (input$content_rate != "All") {
      m <- m %>% filter(Content.Rating == input$content_rate)
    }
    
    m <- as.data.frame(m)
    m
  })
  
  # Function for generating tooltip text
  apps_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    if (is.null(x$ID)) return(NULL)
    
    # Pick out the movie with this ID
    all_apps <- isolate(apps())
    application <- all_apps[all_apps$ID == x$ID, ]
    
    paste0("<b>", application$App, "</b><br>",
           "Genres: ",application$Genres, "<br>",
           "Rated: ",application$Content.Rating,"<br>",
           "Install: ",application$Installs
    )
  }
  
  # A reactive expression with the ggvis plot to plot
  vis <- reactive({
    # Lables for axes
    xvar_name <- names(axis_vars)[axis_vars == input$xvar]
    yvar_name <- names(axis_vars)[axis_vars == input$yvar]
    
    # Normally we could do something like props(x = ~BoxOffice, y = ~Reviews),
    # but since the inputs are strings, we need to do a little more work.
    xvar <- prop("x", as.symbol(input$xvar))
    yvar <- prop("y", as.symbol(input$yvar))
    
    apps %>%
      ggvis(x = xvar, y = yvar) %>%
      layer_points(size := 50, size.hover := 200,
                   fillOpacity := 0.5, fillOpacity.hover := 0.5,
                   stroke = ~Type, key := ~ID) %>%
      add_tooltip(apps_tooltip, "hover") %>%
      add_axis("x", title = xvar_name) %>%
      add_axis("y", title = yvar_name, title_offset = 100) %>%
      add_legend("stroke", title = "App Types", values = c("Free", "Paid")) %>%
      set_options(width = 500, height = 500)
  })
  
  output$table <- DT::renderDataTable(DT::datatable({
    data <- apps()
    data
  }))
  
  vis %>% bind_shiny("plot1")
}
