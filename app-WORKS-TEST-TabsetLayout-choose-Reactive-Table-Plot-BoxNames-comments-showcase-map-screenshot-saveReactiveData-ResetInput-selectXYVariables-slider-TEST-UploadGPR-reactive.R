# Based on code from >  changed object names
# https://stackoverflow.com/questions/44569739/r-shiny-how-to-make-selectinput-choices-reactive-to-each-other-while-subsetting

## Table & Plots are Responsive
## LEAFLET WORKING 2025-09-13
## 2025-09-14 screenshots & download button & reset selectInput
## 2025-09-15 got XY variables reactive to ggplot
## 2025-09-17 got slider to work reactively
## 2025-09-19 add upload file and separate GRP data table
## 2025-09-10 make all separate for GRP data

# Download data
grp_site_data <- read.csv("data/GRP_all_site_data_sql.csv", header = TRUE, sep = ",")

# Package Libraries
library(shiny)
library(leaflet)
library(ggplot2)
library(plotly)
library(shinyscreenshot)

#ui
ui <- fluidPage(
  # app Title
  titlePanel("Exploring GRP GOE Monitoring Dataviz"),
  sidebarLayout(
    # sidebarPanel
    sidebarPanel(width = 3,
                 id = "sidebar_panel",
                 span(style = "font-weight:bold; font-size:11px;", "Using the App: "),
                 br(),
##########################################
# remove until code gets done for GRP
##########################################
                 # span(style = "font-size:12px;", "° Choose Example GRP file or upload GRP file. If choosing upload, then example, and back to upload, you need to reupload the file"),
                 # br(),
##########################################
# remove until code gets done for GRP
##########################################

                 span(style = "font-size:12px;", "° Choose All or one Subregion/Site"),
                 br(),
                 span(style = "font-size:12px;", "° Click tab to view results: Data Table, Compare Subregions, Compare Sites"),
                 br(),
                 span(style = "font-size:12px;", "° Reset choices to All before choosing new Site Data to visualize"),
                 br(),br(),
                 span(id = "input_panel",
##########################################
# remove until code gets done for GRP
##########################################
                      # checkboxInput("use_example_data", "Use Example GRP Data", value = FALSE),
                      # fileInput("upload_file", "Upload GRP Data File", accept = c(".csv", ".tsv", ".txt")),
                      # actionButton("load_example", "Load Example GRP Data"), # Optional: if you prefer a button over a checkbox
##########################################
# remove until code gets done for GRP
##########################################
                      selectInput("Menu1","Choose a Subregion", choices = c("All", unique(grp_site_data$Subregion))),
                      selectInput("Menu2","Choose an Site", choices = c("All", unique(grp_site_data$Site))),
                      # how do I get this to not include Subregion and Site ???
                      # how do I make this reactive to Menu1 and Menu2 ???
                      # selectInput("Menu3", "Choose a Variable", choices =  c("All", colnames(grp_site_data)),
                      #            multiple = TRUE),

                 ),
                 # br(),
                 # br(),

                 span(style = "font-weight:bold; font-size:11px;", "About the Data: "),
                 br(),
                 span(style = "font-size:12px;", "° GRP GOE Data (Shackelford, et.al., 2024). "),
                 span(style = "font-size:12px;", "Restoration Futures Lab at the University of Victoria.
"),
                 br(),br(),
                 actionButton("resetBtn", "Reset Selection"),
                 tags$div(HTML("<hr style='height:2px;border-width:0;color:gray;background-color:gray'>")),
                 ## Screenshot buttons
                 tags$div(HTML("<b>Take Screenshots<br></b>")),
                 tags$div(HTML("<p style='font-size:10px;font-style:italic;'>(Note: Screenshots are saved to Image folder in same location as Shiny app)</p>")), # server_dir="." - same location; or server_dir="AppImages"
                 # Works
                 screenshotButton(label = "Entire page", filename = paste0("GRP-Screenshot-entirePage-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
                 screenshotButton(label = "Input panel", id = "input_panel", filename = paste0("GRP-Screenshot-entirePage-inputPanel-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
                 # Footer
                 br(),br(),
                 span(style = "font-size:10px; font-style:italic;", "Shiny App GRP Showcase Example created by Wendy Anthony, modified 2025-09-20"),

    ),
    # mainPanel
    mainPanel(
      # tabsetPanel
      tabsetPanel(
        id = "tabset",
        selected = "Data Table",
        #tabPanel("About Proposed App",  htmlOutput("text")),
        tabPanel("GRP Data Table",
                 screenshotButton(label = "GRP Table", id = "data_table", filename = paste0("GRP-Screenshot-table-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = TRUE, server_dir="."),
                 downloadButton("downloadGRPData", label = "Download GRP table"),
                 tableOutput("GRP_data_table")),
        tabPanel("Data Table", p(style = "font-size:11px;", "GRP GOE Data"),
                 screenshotButton(label = "Table", id = "table1", filename = paste0("GRP-Screenshot-table-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
                 downloadButton("downloadData", label = "Download table"),
                 tableOutput("table1")),
        tabPanel("Compare Subregions",
                 p(style = "font-size:11px;", "GRP GOE Data"),
                 p(style = "font-size:11px;", "Hover over points to view tooltip ... if chart changes double-click within chart to return to original state"),
                 screenshotButton(label = "Plot 2", id = "plot2", filename = paste0("GRP-Screenshot-plot2-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
                 screenshotButton(label = "Plot 4", id = "plot4", filename = paste0("GRP-Screenshot-plot2-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
                 #screenshotButton(label = "Plot 9", id = "plot9", filename = paste0("GRP-Screenshot-plot9-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
                 fluidRow(
                    column(6, plotOutput("plot2")),
                   column(6,  plotlyOutput("plot4")),
                   #column(6, plotOutput("plot8")),
                   #column(6, plotOutput("plot9"))
                 )),
##########################################
# remove until code gets done for GRP
##########################################
        # tabs seem to break if I try to reuse same plot - keep separate
#         tabPanel("Compare Sites",
#                  p(style = "font-size:11px;", "GOE Data from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems. Restoration Futures Lab at the University of Victoria.
# "),
#                  p(style = "font-size:11px;", "Note: Charts are interactive by hovering or clicking the data"),
#                  screenshotButton(label = "Plot 5", id = "plot5", filename = paste0("GRP-Screenshot-plot5-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
#                  screenshotButton(label = "Plot 6", id = "plot6", filename = paste0("GRP-Screenshot-plot6-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
#
#                  fluidRow(
#                    column(6, plotlyOutput("plot5")),
#                    #           column(6, plotlyOutput("plot10")),
#                    column(6, plotlyOutput("plot6"))
#                    #,
#                    #           column(6, plotlyOutput("plot11"))
#                  )),
##########################################
# remove until code gets done for GRP
##########################################
        # tabPanel("Plot Output",  plotOutput("plot")),
        # from app4-SelectAxisVariables-WORKS.R
#         tabPanel("Plot XY",
#                  p(style = "font-size:11px;", "GOE Data from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems. Restoration Futures Lab at the University of Victoria.
# "),
#                  screenshotButton(label = "Site Plot", id = "my_plot", filename = paste0("GRP-Screenshot-Site-Plot-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
#                  screenshotButton(label = "Subregion Plot", id = "my_plot1", filename = paste0("GRP-Screenshot-Subregion-Plot-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
#
#                  selectInput(inputId = "x_select", label = "Select x-axis",
#                              choices = list("Proportion_of_native_species",
#                                             "Cultural_species_richness",
#                                             "Exotic_species",
#                                             "Trampling",
#                                             "Herbivory",
#                                             "Composite_Index"),
#                              selected = "Exotic_species"),
#                  selectInput(inputId = "y_select", label = "Select y-axis",
#                              choices = list("Proportion of native species" = "Proportion_of_native_species",
#                                             "Cultural species richness" = "Cultural_species_richness",
#                                             "Exotic species" = "Exotic_species",
#                                             "Trampling 1" = "Trampling",
#                                             "Herbivory 1" = "Herbivory",
#                                             "Composite Index" = "Composite_Index"),
#                              selected = "Proportion_of_native_species"),
#                  # basic plot responds to Subregion and Site but not xy varialbes
#                  # plotOutput("plot_xy"),
#                  # tags$div(HTML("<br>")),
#                  ## Just text echoing choices
#                  # strong("X axis: "),
#                  # textOutput(outputId = "check_x_select"),
#                  # tags$div(HTML("<br>")),
#                  # strong("Y axis: "),
#                  # textOutput(outputId = "check_y_select"),
#                  #tags$div(HTML('<br><br>')),
#                  # tags$div(HTML("<hr style='height:2px;border-width:0;color:gray;background-color:gray'>")),
#                  tags$div(HTML("<b>", "Plot1: Resulting ggplot by Site", "</b>")),
#                  plotOutput(outputId = "my_plot", width = 600, height = 600),
#                  tags$div(HTML("<hr style='height:2px;border-width:0;color:gray;background-color:gray'>")),
#                  tags$div(HTML("<b>", "Plot2: Resulting ggplot by Subregion", "</b>")),
#                  plotOutput(outputId = "my_plot1", width = 600, height = 600)
#         ),
##########################################
# remove until code gets done for GRP
##########################################
#         tabPanel("Statistics",
#                  p(style = "font-size:11px;", "Descriptive summary table of data statistics"),
#                  p(style = "font-size:11px;", "GOE Data from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems. Restoration Futures Lab at the University of Victoria.
# "),
#                  screenshotButton(label = "Summary Stats", id = "stats", filename = paste0("GRP-Screenshot-stats-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = FALSE, server_dir="."),
#                  fluidRow(
#                    verbatimTextOutput("stats")
#                  )),
##########################################
# remove until code gets done for GRP
##########################################
        # tabPanel("Range",
        #          p(style = "font-size:11px;", "Choose range of Percentage Native Species to display on plot"),
        #          # select input not working yet
        #          # selectInput("var", "Choose a Variable", choices = list("Proportion_of_native_species",
        #          #                                                        "Cultural_species_richness",
        #          #                                                        "Exotic_species",
        #          #                                                        "Trampling",
        #          #                                                        "Herbivory",
        #          #                                                        "Composite_Index")),
        #          sliderInput("range", "Range: ",
        #                      value = c(0, 100), # needs a value
        #                      step = 0.1,
        #                      min = 0, max = 100),
        #          plotOutput("range_plot")),
##########################################
# remove until code gets done for GRP
##########################################
        tabPanel("GRP Map",
                 leafletOutput("GRPmap", height = "600px"))
##########################################
# remove until code gets done for GRP
##########################################
#         tabPanel("Reactive Map",
#                  p(style = "font-size:11px;", "GOE Data from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems. Restoration Futures Lab at the University of Victoria.
# "),
#                  p(style = "font-size:11px;", "Note: Click markers to open popup data. Site markers are sized to value of Composite Index, and coloured by Subregion."),
#                  p(style = "font-size:11px;", "The interactive leaflet map is now reactive to variable choice !!"),
#                  p(style = "font-size:11px;", "The interactive leaflet map is also a stand-alone webpage"),
#                  HTML('<a href="https://wendyanthony.github.io/GRP_map_radius-1.html" target="_blank">Interactive Webpage Leaflet Map</a>'),
#                  br(),
#                  # screenshot doesn't include background map
#                  #        screenshotButton(label = "Reactive Map", id = "reactiveMap", filename = "GRP-Screenshot-map", download = FALSE, server_dir="."),
#                  fluidRow(
#                    leafletOutput("reactiveMap", height = "600px")
#                  ))
##########################################
# remove until code gets done for GRP
##########################################
        #,
        # tabPanel("Plot Output",  plotOutput("plot")),
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
      grp_site_data
    }else{
      grp_site_data[which(grp_site_data$Subregion == input$Menu1),]
    }
  })

  data_2 <- reactive({
    if (input$Menu2 == "All"){
      grp_site_data
    }else{
      grp_site_data[which(grp_site_data$Site == input$Menu2),]
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
      updateSelectInput(session,"Menu2","Choose a Site", choices = c('All',unique(grp_site_data$Site)))
      updateSelectInput(session,"Menu1","Choose a Subregion", choices = c('All',unique(grp_site_data$Subregion)))
    }
  })


  data3 <- reactive({
    if(input$Menu2 == "All"){
      data_1()
    }else if (input$Menu1 == "All"){
      data_2()
    }else if (input$Menu2 == "All" & input$Menu1 == "All"){
      grp_site_data
    }
    else{
      grp_site_data[which(grp_site_data$Site == input$Menu2 & grp_site_data$Subregion == input$Menu1),]
    }
  })


  # text output
  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  # https://stackoverflow.com/questions/33392784/make-bold-text-in-html-output-r-shiny
  output$text <- renderUI({
    str1 <- paste("Proposed Interactive Data Viz Tool")
    str2 <- paste("Here is what I propose to offer ...")
    str3 <- paste("I. Deliverables: Final Products")
    str3a1 <- paste("Note: Data visualizations created will be based on the questions HAT wants the data to help answer")
    str3a <- paste("Shiny Interactive Dataviz Tool is one of the proposed final product deliverables for ER390 Final Project,
                   created with code written in RMarkdown Code Document")
    str3b <- paste("To be customized for HAT's GOE Monitoring Data with HAT preferences for logo, background, color, colour of tabs, coloured theme, styles for plots, etc.")
    str3c <- paste("I have added screenshot buttons to all pages (except map as it doesn't include background map), plus reactive table data download")
    str3d <- paste("I would also like to add choosing different variables to display interactively in plots, or perhaps even choose the type of plot to use")
    str4 <- paste("II. Data Preparation")
    str4a <- paste("GOE Data used in the demonstration app is from report tables: Malloff, J., & Shackelford, N. (2024). Feeling the Pulse: Monitoring methods and initial outcomes in oak meadow ecosystems.
                   Restoration Futures Lab at the University of Victoria.")
    str4b <- paste("Could also include uploading data. App already saves filtered data both as CSV files and as plot images, creating screen shots.")
    str4c <- paste("Cleaning data, ensure consistent naming and data formats, transforming data, saving outputs, storing data")
    str5 <- paste("III. Interactive Data Tables")
    str5a <- paste("Filter by Subregion Group or Site; Search; Save Results")
    str6 <- paste("IV. Plots")
    str6a <- paste("Dot plots, bar charts, violin plots, Interactive Plotly plots, or HAT’s preferred plot style or type, by Individual Sites or Subregion Group, multi-year, save results")
    str6b <- paste("V. Statistical Analysis")
    str6c <- paste("Interactive choice of variables to analyze for correlation")
    str7 <- paste("VI. Maps")
    str7a <- paste("Markers sized equally, or by a variable value, with Site information embedded in pop-ups")
    str7b <- paste("The leaflet map is now reactive to variable choice!")
    str7c <- paste(' e.g. <a href="https://wendyanthony.github.io/GRP_map_radius-1.html" target="_blank">Interactive Webpage Leaflet Map</a>')
    str7d <- paste("Shiny App Proposal created by Wendy Anthony, modified 2025-09-17")


    HTML(paste0('<H2>', str1, '</H2>',
                str2, '<br/>',
                '<H4>', str3, '</H4>',
                '° ', '<b>', str3a1, '</b>', '<br/>',
                '° ', str3a, '<br/>',
                '° ', str3b, '<br/>',
                '° ', str3c, '<br/>',
                '° ', str3d, '<br/>',
                '<H4>', str4, '</H4>',
                '° ', str4a, '<br/>',
                '° ', str4b, '<br/>',
                '° ', str4c, '<br/>',
                '<H4>', str5, '</H4>',
                '° ', str5a, '<br/>',
                '<H4>', str6, '</H4>',
                '° ', str6a, '<br/>',
                '<H4>', str6b, '</H4>',
                '° ', str6c, '<br/>',
                '<H4>', str7, '</H4>',
                '° ', str7a, '<br/>',
                '° ', str7b, str7c,
                '<br/>','<br/>','<br/>','<br/>',
                '° ', '<i>', str7d, '<i>'
    ))
  })
# Reset button
  observeEvent(input$resetBtn, {
    updateSelectInput(session, "Menu1", selected = "All") # Reset to "B"
    updateSelectInput(session, "Menu2", selected = "All") # Reset to "B"
  })

  # Render the data table
  output$GRP_data_table <- renderTable({
    # req(app_data()) # Require data to be available before rendering
    data3()
  })

  # table output
  output$table1 <- renderTable({
    data3()
  })


  # Download Button for reactive table data
  output$downloadGRPData <- downloadHandler(
    filename = paste0("ReactiveGRPData-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S"), ".csv"),
    content = function(file){
      write.csv(data3(), file)
    })


  # Plot works
  output$plot2 <- renderPlot({
    d <- data3()


    ggplot(d,
           aes(x = Subregion, y = elevation)) +
      #geom_line() +
       geom_violin(fill = "seagreen2") +
       geom_boxplot(width = 0.1, fill = "sandybrown") +
      theme_minimal() + #get rid of grey background and tick marks
      theme(legend.position="none") + #remove legend
      theme(axis.text.x = element_text(vjust = 1, size = 9)) +
      labs(title='Plotting Subregion by Elevation',
           subtitle='GRP (Shackelford, 2025)',
           caption = "Chart by Wendy Anthony \n 2025-09-20")
#
#     ggplot(d,
#            aes(x = Subregion, y = Exotic_species)) +
#       geom_violin(fill = "seagreen2") +
#       geom_boxplot(width = 0.1, fill = "sandybrown") +
#       theme_minimal() + #get rid of grey background and tick marks
#       theme(legend.position="none") + #remove legend
#       theme(axis.text.x = element_text(vjust = 1, size = 9)) +
#       labs(title='Plotting Subregion by Exotic Species',
#            subtitle='GRP (Malloff & Shackelford, 2024)',
#            caption = "Chart by Wendy Anthony \n 2025-08-27")
  })

#
#   # Plot works
#   output$plot9 <- renderPlot({
#     d <- data3()
#     names(grp_site_data)
#     ggplot(d,
#            aes(x = Subregion, y = Percentage_ns)) +
#       geom_violin(fill = "seagreen2") +
#       geom_boxplot(width = 0.1, fill = "sandybrown") +
#       theme_minimal() + #get rid of grey background and tick marks
#       theme(legend.position="none") + #remove legend
#       theme(axis.text.x = element_text(vjust = 1, size = 9)) +
#       labs(title='Plotting Subregion by Percentage Native Species',
#            subtitle='GRP (Malloff & Shackelford, 2024)',
#            caption = "Chart by Wendy Anthony \n 2025-08-27")
#   })

  # Plot works
  output$plot4 <- renderPlotly({
    d <- data3()

    ggplot(d,
       # text = paste("Site:", Site),
      aes(x = precip, y = temp, colour = Subregion)) +
      geom_point(shape = 18, size = 2) +
      scale_x_continuous(limits = c(500, 2000)) +
      scale_y_continuous(limits = c(8, 12)) +
      # Replace default palette of pink & blue
      scale_fill_brewer(palette = "Dark2") +
      theme_minimal() + #get rid of grey background and tick marks
      theme(legend.position="bottom") +
      # theme(legend.position="none") + #remove legend
      theme(axis.text.x = element_text(angle = 0, vjust = 1, hjust=1, size = 7)) +
      labs(title = "GRP Precipitation & Temperature",
           subtitle = "By Subregion",
           caption = "Chart by Wendy Anthony \n 2025-09-21",
           x = "Annual Precipitation (mm)", y = "Annual Temperature (°C)")
    ggplotly(tooltip = c("x", "y", "colour"), GRP_all_site_temp_prec) %>%
      config(displayModeBar = FALSE) %>% # This line disables the modebar
      layout(title = list(
        text = "GRP Annual Precipitation & Temperature by Subregion<br><sup>Data Source: GRP</sup>",
        y = 0.95), # Adjust vertical position if needed
        xaxis = list(title = 'Precipitation (mm)'),
        yaxis = list(title = 'Temperature (°C)'),
        annotations = list(x = 1, y = -0.1, text = "Chart by Wendy Anthony\n2025-09-21",
             showarrow = F, xref='paper', yref='paper',
             xanchor='right', yanchor= 'auto', xshift=0, yshift=0,
             font = list(size=8, color="grey"))
        )
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
           subtitle='GRP GOE Site Monitoring',
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
           subtitle='GRP GOE Site Monitoring',
           caption = "Chart by Wendy Anthony \n 2025-08-27")
  })


  # Statistics summary
  output$stats <- renderPrint({
    d <- data3()
    summary(d)
  })

  #   # Create the GRP base map
  output$GRPmap <- renderLeaflet({
    title <- '<p style="text-align: center; height: 18px; ">
<span style="font-size:9px;font-weight:bold; background-color: rgba(255, 255, 255, 0.9;");>Global Restore Project GOE Monitoring Sites</span><br>
<span style="font-size:6px;font-style:italic; background-color: rgba(255, 255, 255, 0.9;">(Data from Shackelford, et al., 2005-2022)</span></p>'

    # https://rstudio.github.io/leaflet/articles/markers.html
    # Create a palette that maps factor levels to colors
    #####
    # pal <- colorFactor(c("#d7191c", "#2c7bb6"), domain = c("Saanich Peninsula", "Gulf Islands"))
#     pal <- colorFactor(c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#bf5b17"), domain = c("C-SP", "C-GI", "C-EVII", "C-EVI", "US-GI", "US-Wash", "US-Oreg"
# ))
#    pal <- colorFactor(c("#d95f02", "#7570b3", "#d95f02", "#1b9e77", "#7570b3", "#7570b3", "#1b9e77"), domain = c("C-SP", "C-GI", "C-EVII", "C-EVI", "US-GI", "US-Wash", "US-Oreg"))
    pal <- colorFactor(c("#1b9e77", "#7570b3", "#7570b3", "#1b9e77", "#d95f02", "#d95f02", "#d95f02"), domain = c("C-SP", "C-GI", "C-EVII", "C-EVI", "US-GI", "US-Wash", "US-Oreg"))
    leaflet(GRP_Site_data) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addCircleMarkers(
        ~ longitude, ~ latitude,
        #
        color = ~pal(Subregion),
        fill = ~pal(Subregion),
        # color = "yellow",
        weight = 1, # size of circle border
        stroke = TRUE, fillOpacity = 0.5,
        radius = 2,
        # OM_site_data$
        # "<b>Global Restore Project GOE Monitoring Sites</b>", "<br>", "<i>(Shackelford, et. al., 2005-2022)</i>", "<br><br>",
        popup = paste0(
          "<b>Site:</b> ", "<b>", OM_site_data$Site, "</b>",  "<br>",
          "<b>Subregion:</b> ", "<b>", OM_site_data$Subregion, "</b>",  "<br>",
          "<b>Project id:</b> ", "<b>", OM_site_data$projectid, "</b>",  "<br>",
          "<b>Landcover:</b> ", "<b>", OM_site_data$landcover, "</b>",  "<br>",
          "<b>Elevation:</b> ", "<b>", OM_site_data$elevation, "</b>",  "<br>",
          "<b>Aspect:</b> ", "<b>", OM_site_data$aspect, "</b>")
      ) %>%

      setView(-121.799377, 47.801487, 6) %>%
      # add controls
      #  addMiniMap(width = 150, height = 150, zoomLevelOffset = -4) %>%
      addControl(title, position = "topright")
    })

  # # # Observer to update GRP markers when filtered data changes
  observe({
     # https://rstudio.github.io/leaflet/articles/markers.html
     # Create a palette that maps factor levels to colors
     #####
     # pal <- colorFactor(c("#d7191c", "#2c7bb6"), domain = c("Saanich Peninsula", "Gulf Islands"))
    # pal <- colorFactor(c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#bf5b17"), domain = c("C-SP", "C-GI", "C-EVII", "C-EVI", "US-GI", "US-Wash", "US-Oreg"
    # ))
    # colour blind safe from colorbrewer only 3 colors
    pal <- colorFactor(c("#d95f02", "#7570b3", "#d95f02", "#1b9e77", "#7570b3", "#7570b3", "#1b9e77"), domain = c("C-SP", "C-GI", "C-EVII", "C-EVI", "US-GI", "US-Wash", "US-Oreg"
    ))
     d <- data3()
       leafletProxy("GRPmap") %>%
         clearMarkers() %>%  # Remove existing markers
       addCircleMarkers(
         ~ longitude, ~ latitude,
         #
         #     fillColor = ~pal(projectid),
         #color = "yellow",
         color = ~pal(Subregion),
         weight = 1, # size of circle border
         stroke = TRUE, fillOpacity = 0.5,
         radius = 2,
         data = d,
         # OM_site_data$
         # "<b>Global Restore Project GOE Monitoring Sites</b>", "<br>", "<i>(Shackelford, et. al., 2005-2022)</i>", "<br><br>",
         popup = paste0(
           "<b>Site:</b> ", "<b>", d$Site, "</b>",  "<br>",
           "<b>Subregion:</b> ", "<b>", d$Subregion, "</b>",  "<br>",
           "<b>Project id:</b> ", "<b>", d$projectid, "</b>",  "<br>",
           "<b>Landcover:</b> ", "<b>", d$landcover, "</b>",  "<br>",
           "<b>Elevation:</b> ", "<b>", d$elevation, "</b>",  "<br>",
           "<b>Aspect:</b> ", "<b>", d$aspect, "</b>")
       )
   })


  # Basic Plot works
  # output$plot_xy <- renderPlot({
  #   d <- data3()
  #   plot(d$Exotic_species, d$Composite_Index)
  # })


# from app4-SelectAxisVariables-WORKS.R
  output$check_x_select <- renderText({
    print(input$x_select)
  })

  output$check_y_select <- renderText({
    print(input$y_select)
  })

  output$my_plot <- renderPlot({

    #Read in the sample csv
#    dat <- read.csv("data/goe_GRP_all_site_data.csv")
    dat <- data3()

    #Pull out a column for the x and y axis each
    x_axis <- dat[, input$x_select]
    y_axis <- dat[, input$y_select]

    #Create a basic dot plot
    #plot(x = x_axis, y_axis)

    # ggplot
    ggplot() +
      aes(x = x_axis, y_axis, color = dat$Site) +
      geom_point(shape = 18, size = 4) +
      theme_minimal() + #get rid of grey background and tick marks
      theme(legend.position="bottom") + #remove legend
      theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
      labs(title='Plotting Site Variables by Select Input',
           subtitle='GRP GOE Monitoring Data',
           caption = "Chart by Wendy Anthony \n 2025-08-18",
           x = input$x_select, y = input$y_select,
           # legend title by variable used to colour
           color = "Site")
  })

  output$check_y_select <- renderText({
    print(input$y_select)
  })

  output$my_plot1 <- renderPlot({

    #Read in the sample csv
#    dat <- read.csv("data/goe_GRP_all_site_data.csv")
    dat <- data3()

    #Pull out a column for the x and y axis each
    x_axis <- dat[, input$x_select]
    y_axis <- dat[, input$y_select]

    #Create a basic dot plot
    #plot(x = x_axis, y_axis)

    # ggplot
    ggplot() +
      aes(x = x_axis, y_axis, color = dat$Subregion) +
      geom_point(shape = 18, size = 4) +
      theme_minimal() + #get rid of grey background and tick marks
      theme(legend.position="bottom") + #remove legend
      theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
      labs(title='Ploting Subregion Variables by Select Input',
           subtitle='GRP GOE Monitoring Data',
           caption = "Chart by Wendy Anthony \n 2025-08-18",
           x = input$x_select, y = input$y_select,
           # legend title by variable used to colour
           color = "Subregion")
  })


  # range filtered data

  filtered_data <- reactive({
    d <- data3()
    # Assuming 'my_data' is your dataset and 'variable' is the column to filter
    d[d$Percentage_ns >= input$range[1] &
              d$Percentage_ns <= input$range[2], ]
  })

  # range plot
  output$range_plot <- renderPlot({

      ggplot(filtered_data(),
             aes(x = Site, y = Percentage_ns, color = Subregion)) +
        geom_point(shape = 18, size = 2) +
        theme_minimal() + #get rid of grey background and tick marks
        theme(legend.position="none") + #remove legend
        theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
        labs(title='Plotting Site by Percentage Native Species',
             subtitle='GRP',
             caption = "Chart by Wendy Anthony \n 2025-08-04")
    })

  # end of server
}

shinyApp(ui,server)
