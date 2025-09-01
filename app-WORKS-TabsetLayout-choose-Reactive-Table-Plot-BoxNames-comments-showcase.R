# Based on code from >  changed object names
# https://stackoverflow.com/questions/44569739/r-shiny-how-to-make-selectinput-choices-reactive-to-each-other-while-subsetting

## Table & Plots are Responsive
## LEAFLET NOT WORKING ??? 2025-08-28

# Download data
geo_eccc_sites_2 <- read.csv("geo_eccc_all_site_data.csv", header = TRUE, sep = ",")

# Package Libraries
library(shiny)
library(leaflet)
library(ggplot2)
library(plotly)

#ui
ui <- fluidPage(
  # app Title
  titlePanel("Exploring GOE Monitoring Dataviz"),
sidebarLayout(
  # sidebarPanel
  sidebarPanel(width = 3,
    span(style = "font-weight:bold; font-size:11px;", "Using the App: "),
    span(style = "font-size:12px;", "Choose All or one Subregion/Site; click tab results: Table, Comparing Subregions, Comparing Sites"),
    br(),br(),
    selectInput("Menu1","Choose a Subregion", choices = c("All", unique(geo_eccc_sites_2$Subregion))),
    selectInput("Menu2","Choose an Site", choices = c("All", unique(geo_eccc_sites_2$Site))),
    span(style = "font-weight:bold; font-size:11px;", "About the Data: "),
    span(style = "font-size:12px;", "GOE Data from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems. Restoration Futures Lab at the University of Victoria.
")
  ),
  # mainPanel
  mainPanel(
    # tabsetPanel
tabsetPanel(
  id = "tabset",
  selected = "Data Table",
tabPanel("About Proposed App",  htmlOutput("text")),
tabPanel("Data Table", p(style = "font-size:9px;", "GOE Data from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems. Restoration Futures Lab at the University of Victoria.
"), tableOutput("table1")),
tabPanel("Compare Subregions",
         p(style = "font-size:9px;", "GOE Data from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems. Restoration Futures Lab at the University of Victoria."),
         fluidRow(
            column(6, plotOutput("plot2")),
            #column(6, plotOutput("plot3")),
            #column(6, plotOutput("plot8")),
            column(6, plotOutput("plot9"))
         )),
# tabs seem to break if I try to reuse plot
tabPanel("Compare Sites",
         p(style = "font-size:9px;", "GOE Data from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems. Restoration Futures Lab at the University of Victoria.
"),
         p(style = "font-size:11px;", "Note: Charts are interactive by hovering or clicking the data"),
         fluidRow(
           column(6, plotlyOutput("plot5")),
#           column(6, plotlyOutput("plot10")),
           column(6, plotlyOutput("plot6"))
#,
#           column(6, plotlyOutput("plot11"))
         ))
#,
# tabPanel("Plot Output",  plotOutput("plot")),
# tabPanel("Subregion Plots Output",  plotOutput("plot2")),
# tabPanel("Comparing Site Plots Output",  plotOutput("plot4")),
# tabPanel("More Subregion Plots Output",  plotOutput("plot5")),
# tabPanel("More Subregion Plots Output",  plotOutput("plot6")),
# tabPanel("Plotly Output",  plotlyOutput("plot7"))
# ,
# tabPanel("Map Output",  leafletOutput("map",height = 650,width=605))

# end tabsetPanel
)
# end mainPanel
  )
# end sidebarLayout
)
# end Fluid Page
)

# server
server <- function(input, output, session){

  data_1 <- reactive({
    if(input$Menu1 == "All"){
      geo_eccc_sites_2
    }else{
      geo_eccc_sites_2[which(geo_eccc_sites_2$Subregion == input$Menu1),]
    }
  })

  data_2 <- reactive({
    if (input$Menu2 == "All"){
      geo_eccc_sites_2
    }else{
      geo_eccc_sites_2[which(geo_eccc_sites_2$Site == input$Menu2),]
    }
  })

  observe({
    if(input$Menu1 != "All"){
      updateSelectInput(session,"Menu2","Choose a Site", choices = c("All",unique(data_1()$Site)))
    }
    else if(input$Menu2 != 'All'){
      updateSelectInput(session,"Menu1","Choose a name", choices = c('All',unique(data_2()$Subregion)))
    }
    else if (input$Menu1 == "All" & input$Menu2 == "All"){
      updateSelectInput(session,"Menu2","Choose a Site", choices = c('All',unique(geo_eccc_sites_2$Site)))
      updateSelectInput(session,"Menu1","Choose a Subregion", choices = c('All',unique(geo_eccc_sites_2$Subregion)))
    }
  })


  data3 <- reactive({
    if(input$Menu2 == "All"){
      data_1()
    }else if (input$Menu1 == "All"){
      data_2()
    }else if (input$Menu2 == "All" & input$Menu1 == "All"){
      geo_eccc_sites_2
    }
    else{
      geo_eccc_sites_2[which(geo_eccc_sites_2$Site == input$Menu2 & geo_eccc_sites_2$Subregion == input$Menu1),]
    }
  })


  # text output
  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  # https://stackoverflow.com/questions/33392784/make-bold-text-in-html-output-r-shiny
  output$text <- renderUI({
    str1 <- paste("Proposed Interactive Data Viz Tool")
    str1a <- paste("to be customized for HAT's GOE Monitoring Data")
    str2 <- paste("Here is what I propose to offer ...")
    str3 <- paste("I. Deliverables: Final Products")
    str3a <- paste("Shiny Interactive Dataviz Tool, RMarkdown Code Document that cleans data, and creates dataviz")
    str4 <- paste("II. Data Preparation")
    str4a <- paste("Cleaning data, ensure consistent naming and data formats, data transformation, saving outputs, storing data")
    str5 <- paste("III. Interactive Data Tables")
    str5a <- paste("Filter by Subregion Group or Site; Search; Save Results")
    str6 <- paste("IV. Plots")
    str6a <- paste("Dot plots, bar charts, violin plots, Individual Sites, Subregion Group, multi-year, save results")
    str7 <- paste("V. Maps")
    str7a <- paste("Markers sized equally, or by a variable value, with Site information embedded in pop-ups")
    str7b <- paste(' e.g. <a href="https://wendyanthony.github.io/ECCC_map_radius-1.html" target="_blank">Interactive Webpage Leaflet Map</a>')
    HTML(paste0('<H2>', str1, '</H2>',
                '<H3>', str1a, '</H3>',
                str2, '<br/>',
                '<H4>', str3, '</H4>',
                '° ', str3a, '<br/>',
                '<H4>', str4, '</H4>',
                '° ', str4a, '<br/>',
                '<H4>', str5, '</H4>',
                '° ', str5a, '<br/>',
                '<H4>', str6, '</H4>',
                '° ', str6a, '<br/>',
                '<H4>', str7, '</H4>',
                '° ', str7a, str7b, '<br/>','<br/>'
                ))
  })

  # table output
  output$table1 <- renderTable({
    data3()
  })

# Plot works
# output$plot <- renderPlot({
#   d <- data3()
#   plot(d$Exotic_species,d$Composite_Index)
# })


# Plot works
output$plot <- renderPlot({
  d <- data3()
  ggplot(d,
         aes(x = Site, y = Percentage_ns)) +
    geom_point(shape = 18, size = 2) +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
    labs(title='Plotting Site by Percentage Native Species',
         subtitle='ECCC (Malloff & Shackelford, 2024)',
         caption = "Chart by Wendy Anthony \n 2025-08-04")
})

# Plot works
output$plot2 <- renderPlot({
  d <- data3()

  ggplot(d,
         aes(x = Subregion, y = Exotic_species)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(vjust = 1, size = 9)) +
    labs(title='Plotting Subregion by Exotic Species',
         subtitle='ECCC (Malloff & Shackelford, 2024)',
         caption = "Chart by Wendy Anthony \n 2025-08-27")
})


# Plot works
output$plot3 <- renderPlot({
  d <- data3()

  ggplot(d,
         aes(x = Subregion, y = Composite_Index)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(vjust = 1, size = 9)) +
    labs(title='Plotting Subregion by Composite_Index',
         subtitle='ECCC (Malloff & Shackelford, 2024)',
         caption = "Chart by Wendy Anthony \n 2025-08-04")
})

# Plot works
output$plot8 <- renderPlot({
  d <- data3()

  ggplot(d,
         aes(x = Subregion, y = Cultural_species_richness)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(vjust = 1, size = 9)) +
    labs(title='Plotting Subregion by Cultural_species_richness',
         subtitle='ECCC (Malloff & Shackelford, 2024)',
         caption = "Chart by Wendy Anthony \n 2025-08-04")
})

# Plot works
output$plot9 <- renderPlot({
  d <- data3()
names(geo_eccc_sites_2)
  ggplot(d,
         aes(x = Subregion, y = Percentage_ns)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(vjust = 1, size = 9)) +
    labs(title='Plotting Subregion by Percentage Native Species',
         subtitle='ECCC (Malloff & Shackelford, 2024)',
         caption = "Chart by Wendy Anthony \n 2025-08-27")
})


# Plot works
output$plot4 <- renderPlot({
  d <- data3()

  d %>% arrange(desc(Percentage_ns)) %>%
    # updates Site with new arrangement
    mutate(Site = factor(Site, levels = Site)) %>%
    ggplot(
      aes(x = Site, y = Percentage_ns, fill = Subregion, color = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparinging Sites by Percentage Native Species',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})


# Plot works
output$plot5 <- renderPlotly({
  d <- data3()

  d %>% arrange(desc(Exotic_species)) %>%
    # updates Site with new arrangement
    mutate(Site = factor(Site, levels = Site)) %>%
    ggplot(
      aes(x = Site, y = Exotic_species, fill = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparing Sites by Exotic Species (High-Low)',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-27")
})



# Plot works
output$plot6 <- renderPlotly({
  d <- data3()

  d %>% arrange(desc(Percentage_ns)) %>%
    # updates Site with new arrangement
    mutate(Site = factor(Site, levels = Site)) %>%
    ggplot(
      aes(x = Site, y = Percentage_ns, fill = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Compare Sites by % Native Species (High-Low)',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-27")
})


# Plot works
output$plot10 <- renderPlotly({
  d <- data3()

  # d %>% arrange(desc(Exotic_species)) %>%
  #   # updates Site with new arrangement
  #   mutate(Site = factor(Site, levels = Site)) %>%
  d %>% ggplot(
      aes(x = Site, y = Exotic_species, fill = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Compare Sites by Exotic Species (alpha)',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-27")
})



# Plot works
output$plot11 <- renderPlotly({
  d <- data3()

  # d %>% arrange(desc(Herbivory)) %>%
  #   # updates Site with new arrangement
  #   mutate(Site = factor(Site, levels = Site)) %>%
  d %>% ggplot(
      aes(x = Site, y = Percentage_ns, fill = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Compare Sites by % Native Species (alpha)',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})

# Plot works
output$plot7 <- renderPlotly({
  d <- data3()

  d %>% arrange(desc(Herbivory)) %>%
    # updates Site with new arrangement
    mutate(Site = factor(Site, levels = Site)) %>%
    ggplot(
      aes(x = Site, y = Herbivory, fill = Subregion, color = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparinging Sites by Herbivory',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})

# # Create the base map
# output$map <- renderLeaflet({
#   leaflet() %>%
#     addProviderTiles("Esri.WorldImagery") %>%
#     setView(-123.44799, 48.64919, 9) # Center of US
# })
#
# # Observer to update markers when filtered data changes
# observe({
#   data <- data3()
#
#   leafletProxy("map") %>%
#     clearMarkers() %>%  # Remove existing markers
#     addCircleMarkers(
#       color = ~pal(Subregion),
#       # size by multiple of Composite_Index
#       radius = ~Composite_Index * 5,
#       stroke = FALSE, fillOpacity = 0.5,
#       data = data,
#       lng = ~Lng,
#       lat = ~Lat,
#       popup = ~paste0("<b>Site:</b> ", "<b>", Site, "</b>", "<br><br>", "<b>Subregion:</b> ", Subregion, "<br>",
#                       "<b>Latitude:</b> ", Lat, "<br>", "<b>Longitude:</b> ", Lng,  "<br><br>",
#                       "<b>Land Manager:</b> ", Land_Manager, "<br>",
#                       "<b>Main Restoration:</b> ", Main_Restoration_Type, "<br>",
#                       "<b>Restoration Intensity:</b> ", Restoration_Intensity, "<br>",
#                       "<b> Area:</b> ", Area_ha, " ha",
#                       "<br><br>",
#                       "<b>Proportion of native species:</b> ", Proportion_of_native_species, "<br>",
#                       "<b>Cultural species richness:</b> ", Cultural_species_richness, "<br>",
#                       "<b>Exotic species:</b> ", Exotic_species, "<br>",
#                       "<b>Trampling:</b> ", Trampling, "<br>",
#                       "<b>Herbivory:</b> ", Herbivory, "<br>",
#                       "<b>Composite Index:</b> ", Composite_Index, "<br>"
#       )
#     )
# })

# end of server
}

shinyApp(ui,server)
