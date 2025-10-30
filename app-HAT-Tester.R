# Based on code from >  changed object names
# https://stackoverflow.com/questions/44569739/r-shiny-how-to-make-selectinput-choices-reactive-to-each-other-while-subsetting

## Table & Plots are Responsive
## LEAFLET WORKING 2025-09-13
## 2025-09-14 screenshots & download button & reset selectInput
## 2025-09-15 got XY variables reactive to ggplot
## 2025-09-17 got slider to work reactively
## Start HAT app 2025-10-06
# Modified 2025-10-07 09:43 >>> 2025-10-19-29 @ 11:05

# Download data
oakhaven_2025_cover <- read.csv("data/oakhaven_2025_cover.csv", header = TRUE, sep = ",")
HAT_sites <- read.csv("data/HAT-Sites.csv", header = TRUE, sep = ",")
OH_metadata <- read.csv("data/HAT-OH-MetaData.csv", header = TRUE, sep = ",")
# Timeline_OH <- read.csv("data/OH_timeline_date.csv", header = TRUE, sep = ",")
Timeline_OH_vis <- read.csv("data/OH_timeline_date_timevis.csv", header = TRUE, sep = ",")
OH_Datasheet_orig <- read.csv("data/HAT-Meadow Monitoring Spreadsheet 2025 - Oak Haven Park example.csv", header = TRUE, sep = ",")

# Package Libraries
library(shiny)
library(DT) # For interactive data tables
library(shinyscreenshot)
library(leaflet)
library(ggplot2)
library(plotly)
library(ggrepel)
library(timevis)

#ui
ui <- fluidPage(
  # app Title
  # titlePanel("Exploring HAT GOE Monitoring Dataviz"),
  titlePanel(windowTitle = "HAT GOEM Dataviz",
             fluidRow(
               column(9, "Exploring HAT GOE Monitoring Dataviz"),
               column(3, img(height = 50, src = "HAT-logo-ss.png"))
             )
  ),
  # https://images.squarespace-cdn.com/content/v1/5e3c5b7e5460c55405a6d4d6/a8c2fb30-96fd-4042-925f-e76c7040dce6/Black+Logo+2.png?format=5w
  # titlePanel( div(column(width = 3, tags$img(src = "HAT-logo-white-ss.png", height="1-%", width="10%", align="left")), column(width = 9, h2("Exploring HAT GOE Monitoring Dataviz")))),
  sidebarLayout(
    # sidebarPanel
    sidebarPanel(width = 3,
                 tags$style(HTML('
                       #sidebar_panel {
                          background-color: #fcfaf0
                       }
                      body {
                      background-color: #fff
                      }
                  ')),
                 # body, label, input, button, select {
                 # font-family: "Arial";
                 # }
                 id = "sidebar_panel",
                 span(style = "font-weight:bold; font-size:11px;", "Using the App: "),
                 br(),
                 span(style = "font-size:12px;", "° Choose All or one Municipality/Site"),
                 br(),
                 span(style = "font-size:12px;", "° Click tab to view results"),
                 br(),
                 span(style = "font-size:12px;", "° Reset choices to All before choosing new Data to visualize"),
                 br(),br(),
                 span(id = "input_panel",
                      selectInput("Menu1","Choose a Municipality", choices = c("All", unique(HAT_sites$Municipality))),
                      selectInput("Menu2","Choose an Site", choices = c("All", unique(HAT_sites$Site)))
                 ),
                 span(style = "font-weight:bold; font-size:11px;", "About the Data: "),
                 br(),
                 span(style = "font-size:12px;", "° HAT GOE Monitoring Data"),
                 br(),br(),
                 actionButton("resetBtn", "Reset Selection"),
                 tags$div(HTML("<hr style='height:2px;border-width:0;color:gray;background-color:gray'>")),
                 ## Screenshot buttons
                 tags$div(HTML("<b>Take Screenshots<br></b>")),
                 tags$div(HTML("<p style='font-size:10px;font-style:italic;'>(Note: Screenshots are saved to Image folder in same location as Shiny app)</p>")), # server_dir="." - same location; or server_dir="AppImages"
                 screenshotButton(label = "Entire page", filename = paste0("HAT-Screenshot-entirePage-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = TRUE, server_dir="."),
                 screenshotButton(label = "Input panel", id = "input_panel", filename = paste0("HAT-Screenshot-entirePage-inputPanel-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = TRUE, server_dir="."),
                 # Footer
#                 img(src = "HAT-logo-white-ss.png", height = "15%", width = "15%", align = "right"),
                 br(),br(),
                 span(style = "font-size:10px; font-style:italic;", "HAT Shiny App Showcase Example created by Wendy Anthony, modified 2025-10-29"),
                 br(),br()
    ),

    ########################################################################
    # mainPanel
    mainPanel(
      # Tab colours
      tags$style(HTML("
    .tabbable > .nav > li > a                  {background-color: #f7f4db;  color:black}
    .tabbable > .nav > li[class=active]    > a {background-color: #999960; color:white}
  ")),
      # tabsetPanel
      tabsetPanel(
        id = "tabset",
        selected = "Reactive Site Map",
        tabPanel(id = "about", "About Proposed App",  htmlOutput("text")),
        tabPanel(id = "tables", "Data Tables",
                 ## -----------------------------------------
                 # Nested tabsetPanel for tables
                 tabsetPanel(
                   # this H3 will show at top of each sub tabPanel
                   #                   h3("HAT GOE Data"),
                   #                   p(style = "font-size:11px;", "Note: The table is reactive to user-choice variable"),
                   # screenshotButton(label = "Table", id = "table1", filename = paste0("HAT-Screenshot-table-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = TRUE, server_dir="."),
                   # downloadButton("downloadData", label = "Download Site Data"),


                   ## -----------------------------------------
                   # Nested tabPanel
                   tabPanel("Sites Table",
                            h3("3 HAT Monitoring Sites"),
                            p(style = "font-size:11px;", "Note: The table is reactive to user-choice variable; Data is also used for the Reactive Site Map"),
                            DTOutput("sites"),
                   ),
                   # end of tabPanel
                   ## -----------------------------------------
                   # Nested tabPanel
                   tabPanel("Timeline Table",
                            h3("HAT Monitoring Timeline"),
                            p(style = "font-size:11px;", "Note: This data is used for the HAT Timeline"),
                            DTOutput("time"),
                   ),
                   # end of tabPanel
                   ## -----------------------------------------
                   # Nested tabPanel
                   tabPanel("OH Metadata",
                            h3("Oak Haven Park Monitoring Metadata"),
                            p(style = "font-size:11px;", "Note: Data from April 2025 quadrat cover data assessment"),
                            DTOutput("meta"),
                   ),
                   # end of tabPanel
                   ## -----------------------------------------
                   # Nested tabPanel
                   tabPanel("OH Cover DataTable",
                            h3("Oak Haven Park Cover Data 2025"),
                            p(style = "font-size:11px;", "Note: This data is used for the Interactive Oak Haven Cover Dataviz Plots"),
                            DTOutput("coverOH"),
                   ),
                   # end of tabPanel
                   ## -----------------------------------------
                   # Nested tabPanel
                   tabPanel("OH Original Datasheet",
                            h3("Oak Haven Park Original Data 2025"),
                            p(style = "font-size:11px;", "Note: This data needed to be totally reformatted to create Oak Haven Park Cover Data 2025"),
                            DTOutput("DataOHorig")),
                 ),
                 # end of tabPanel
        ),
        ## end of nested tabPanels
        ## -----------------------------------------

        tabPanel(id = "HAT_time", "HAT Timeline",
                 p(style = "font-size:11px;", "Note: Timeline is NOT reactive to user choice"),
                 screenshotButton(label = "Timevis", id = "timevis", filename = paste0("HAT-Screenshot-timeline-plot-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = TRUE, server_dir="."),
                 timevisOutput("timevis")),
        tabPanel(id = "OH_dv", "Oak Haven Park Dataviz",
                 p(style = "font-size:11px;", "Note: Charts are interactive by hovering or clicking the data; Plots are NOT reactive to sidebar user choice"),
                 screenshotButton(label = "Species", id = "OH_plot_species_quadrat", filename = paste0("HAT-Screenshot-species-plot-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = TRUE, server_dir="."),
                 screenshotButton(label = "Quadrats", id = "OH_plot_quadrat_species", filename = paste0("HAT-Screenshot-quadrat-plot-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = TRUE, server_dir="."),
                 screenshotButton(label = "Nat/Inv", id = "OH_plot_nat_inv_species", filename = paste0("HAT-Screenshot-nat-invplot-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S")), download = TRUE, server_dir="."),
                 plotlyOutput("OH_plot_species_quadrat"),
                 hr(),
                 plotlyOutput("OH_plot_quadrat_species"),
                 hr(),
                 plotlyOutput("OH_plot_nat_inv_species")),
        tabPanel(id = "map", "Reactive Site Map",
                 p(style = "font-size:11px;", "HAT GOE Data from HAT Website, and Oak Haven Park Cover Monitoring"),
                 p(style = "font-size:11px;", "Note: Click markers to open popup data. Site markers are coloured by Municipality."),
                 p(style = "font-size:11px;", "The interactive leaflet map is reactive to user-choice variable!!"),
                 #p(style = "font-size:11px;", "The interactive leaflet map is also a stand-alone webpage"),
                 HTML('<a href="https://wendyanthony.github.io/HAT_site_map.html" target="_blank", "font-size:11px;">Interactive Leaflet Map</a> is also a stand-alone webpage'),
                 br(),
                 # screenshot doesn't include background map
                 #        screenshotButton(label = "Reactive Map", id = "reactiveMap", filename = "ECCC-Screenshot-map", download = TRUE, server_dir="."),
                 fluidRow(
                   leafletOutput("reactiveMap", width = "100%")
                   #leafletOutput("reactiveMap", height = "600px")
                   # end leaflet
                 ))
        # end tabsetPanel
      )
      # end mainPanel
    )
    # end sidebarLayout
  )
  # end Fluid Page
)

########################################################################
########################################################################
# server
server <- function(input, output, session){

  data_1 <- reactive({
    if(input$Menu1 == "All"){
      HAT_sites
    }else{
      HAT_sites[which(HAT_sites$Municipality == input$Menu1),]
    }
  })

  data_2 <- reactive({
    if (input$Menu2 == "All"){
      HAT_sites
    }else{
      HAT_sites[which(HAT_sites$Site == input$Menu2),]
    }
  })

  observe({
    if(input$Menu1 != "All"){
      updateSelectInput(session,"Menu2","Choose a Site", choices = c("All",unique(data_1()$Site)))
    }
    else if(input$Menu2 != 'All'){
      updateSelectInput(session,"Menu1","Choose a name", choices = c('All',unique(data_2()$Municipality)))
    }
    else if (input$Menu1 == "All" & input$Menu2 == "All"){
      updateSelectInput(session,"Menu2","Choose a Site", choices = c('All',unique(HAT_sites$Site)))
      updateSelectInput(session,"Menu1","Choose a Municipality", choices = c('All',unique(HAT_sites$Municipality)))
    }
  })

  data3 <- reactive({
    if(input$Menu2 == "All"){
      data_1()
    }else if (input$Menu1 == "All"){
      data_2()
    }else if (input$Menu2 == "All" & input$Menu1 == "All"){
      HAT_sites
    }
    else{
      HAT_sites[which(HAT_sites$Site == input$Menu2 & HAT_sites$Municipality == input$Menu1),]
    }
  })

  data_OH_cover <- reactive({
    oakhaven_2025_cover
  })

  meta_OH <- reactive({
    OH_metadata
  })

  time_HAT <- reactive({
    Timeline_OH_vis
  })

  # when I try this I get an Shiny error
  # time_HAT_vis <- reactive({
  #   Timeline_OH_vis
  # })



  OH_Data_orig <- reactive({
    OH_Datasheet_orig
  })


  ########################################################################
  ########################################################################
  # text output
  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  # https://stackoverflow.com/questions/33392784/make-bold-text-in-html-output-r-shiny
  output$text <- renderUI({
    str1 <- paste("Proposed Interactive Data Viz Tool")
    str2 <- paste("Here is what I propose to offer ...")
    str3 <- paste("I. Deliverables: Final Products")
    str3a1 <- paste("Note: Data visualizations created will be based on the management decision questions HAT wants the data to help answer")
    str3a <- paste("Shiny Interactive Dataviz Tool is one of the proposed final product deliverables for ER390 Final Project,
                   created with code written in RMarkdown Code Document")
    str3b <- paste("To be customized for HAT's GOE Monitoring Data with HAT preferences for logo, background, color, colour of tabs, coloured theme, styles for plots, etc.")
    str3c <- paste("I have added screenshot buttons to all pages (except map as it doesn't include background map), plus reactive table data download")
    str3d <- paste("I would also like to add choosing different variables to display interactively in plots, or perhaps even choose the type of plot to use")
    str4 <- paste("II. Data Preparation")
    str4a <- paste("GOE Data used in the demonstration app is from Oak Haven Park Cover Data 2025-April")
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
    str7c <- paste(' e.g. <a href="https://wendyanthony.github.io/HAT_site_map.html" target="_blank">Interactive Leaflet Map</a>')
    str7d <- paste("Shiny App Proposal created by Wendy Anthony, modified 2025-10-06")

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

  ########################################################################
  # Reset button
  observeEvent(input$resetBtn, {
    updateSelectInput(session, "Menu1", selected = "All") # Reset to "B"
    updateSelectInput(session, "Menu2", selected = "All") # Reset to "B"
  })

  ########################################################################
  # HAT_sites table output
  output$sites <- renderDT({
    datatable(data3(), options = list(dom = 'frtip')) # hides show entries dropdown for small tables
  })

  # table output
  output$coverOH <- renderDT({
    datatable(data_OH_cover())
  })

  # table output
  output$meta <- renderDT({
    datatable(meta_OH(), options = list(dom = 'frtip'))
  })

  # table output
  output$time <- renderDT({
    datatable(time_HAT(), options = list(dom = 'frtip'))
  })

  output$DataOHorig <- renderDT({
    datatable(OH_Data_orig(), options = list(dom = 'frtip'))
  })

  ########################################################################

  # Download Button for reactive table data
  output$downloadData <- downloadHandler(
    filename = paste0("ReactiveHAT-SiteData-", format(Sys.time(), "%Y-%m-%d_%H.%M.%S"), ".csv"),
    content = function(file){
      write.csv(data3(), file)
    })

  ########################################################################
  # Go to button


  ########################################################################

  # Quadrat per Species Plot
  output$OH_plot_species_quadrat <- renderPlotly({
    data <- req(oakhaven_2025_cover)
    data %>%  ggplot(
      aes(x = Species, y = PercentCover, fill = QUniqueID)) +
      ylim(0, 100) +
      geom_bar(stat = "identity") +
      theme_minimal() + #get rid of grey background and tick marks
      theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
      labs(title='Comparing Quadrats: Cumulative Percentage Species Coverage',
           subtitle='Oak Haven Park',
           caption = "Chart by Wendy Anthony \n 2025-10-05") +
      scale_fill_discrete(name = "Unique Quadrat ID")
  })

  output$OH_plot_quadrat_species <- renderPlotly({
    data <- req(oakhaven_2025_cover)
    data %>% ggplot(
      aes(x = QUniqueID, y = PercentCover, fill = Species)) +
      ylim(0, 100) +
      geom_bar(stat = "identity") +
      theme_minimal() + #get rid of grey background and tick marks
      theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
      labs(title='Comparing Quadrats Percentage Species Coverage',
           subtitle='Oak Haven Park',
           caption = "Chart by Wendy Anthony \n 2025-10-05")
  })

  output$OH_plot_nat_inv_species <- renderPlotly({
    data <- req(oakhaven_2025_cover)
    data %>% ggplot(
      aes(x = QUniqueID, y = PercentCover, fill = Native_or_Invasive)) +
      ylim(0, 100) +
      #geom_bar(stat = "identity", fill = "seagreen") +
      geom_bar(stat = "identity") +
      theme_minimal() + #get rid of grey background and tick marks
      theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
      labs(title='Comparing Quadrats Percentage Native and Invasive Species Coverage',
           subtitle='Oak Haven Park',
           caption = "Chart by Wendy Anthony \n 2025-10-05")
  })

  ########################################################################

  output$timevis <-
    renderTimevis(timevis(Timeline_OH_vis))

  # Timeline Plot
  output$timeline <- renderPlot({
    Timeline_OH$When <- as.Date(Timeline_OH$When)
    ggplot(Timeline_OH, aes(x = When, y = EventType, label = paste(Where, When, sep = "-"))) +
      #OH_timeline_plot <- ggplot(OH_timeline, aes(x = When, y = EventType, label = What)) +

      geom_line() +
      geom_point(data = . %>% filter(Where != "")) +
      # geom_point(data = . %>% filter(What != "")) +
      #      geom_text(aes(colour = EventType), hjust = -0.3, angle = 45) +
      geom_text_repel(aes(colour = EventType),
                      direction = "y",
                      size = 3.5,
                      point.padding = 0.5,
                      hjust = 0,
                      box.padding = 1,
                      seed = 123) +
      scale_x_date(name = "When", date_breaks = "4 months",
                   expand = expansion(mult = c(0.05, 0.9))) +
      # scale_x_continuous(limits = c(2024-01-01, 2026-01-01)) +
      scale_y_discrete(name = "",
                       expand = expansion(mult = c(0.2, 0.95))) +
      scale_colour_manual(values = c(Cover_Monitor = "seagreen", Treatment_Event = "purple"), guide = "none") +
      theme_minimal() +
      labs(title='Timeline',
           subtitle='HAT GOE Monitoring',
           caption = "Chart by Wendy Anthony \n 2025-10-07")
  })

  ########################################################################
  ########################################################################
  # Create the base map
  output$reactiveMap <- renderLeaflet({
    d <- data3()
    title <- '<p style="text-align: center; height: 18px; "><img src="https://images.squarespace-cdn.com/content/v1/5e3c5b7e5460c55405a6d4d6/a8c2fb30-96fd-4042-925f-e76c7040dce6/Black+Logo+2.png?format=5w"><span style="font-size:9px;font-weight:bold; background-color: rgba(255, 255, 255, 0.9;");>GOE Monitoring Covenant Sites Map</span></p>'
    pal <- colorFactor(c("#1b9e77", "#7570b3", "#d95f02"), domain = c("Central Saanich", "Colwood", "Esquimalt"))
    HAT_sites_map  <-  leaflet(d) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addCircleMarkers(
        ~ Lng, ~ Lat,
        color = ~pal(Municipality),
        weight = 1, # size of circle border
        stroke = TRUE, fillOpacity = 1, #fillOpacity = 0.5
        radius = 4,
        popup = paste0(
          "<img src = 'https://images.squarespace-cdn.com/content/v1/5e3c5b7e5460c55405a6d4d6/a8c2fb30-96fd-4042-925f-e76c7040dce6/Black+Logo+2.png?format=5w'>",  "<br>","<br>",
          #          "<img src = 'https://images.squarespace-cdn.com/content/v1/5e3c5b7e5460c55405a6d4d6/1598403372283-K87T43UT6OOCVYEYLO51/white+HAT+logo.png?format=25w'>",  "<br>",
          "<b>Site:</b> ", "<b>", HAT_sites$Site, "</b>",  "<br>",
          "<b>Municipality:</b> ", HAT_sites$Municipality, "<br>",
          "<b>Size:</b> ", HAT_sites$Size_ha, " (ha)", "<br>",
          "<b>First Nations:</b> ", HAT_sites$FirstNations, "<br>",
          "<b>HAT Status:</b> ", HAT_sites$HAT_Status, "<br>",
          "<b>Co-Covenant:</b> ", HAT_sites$Co_Covenant, " (", HAT_sites$Date, ")", "<br>",
          "<b>Ecosystems:</b> ", HAT_sites$Ecosystems, "<br>",
          "<b>Volunteer Stewardship:</b> ", HAT_sites$Volunteer_Stewardship, "<br>"
        ))  %>%
      addLegend("bottomright", pal = pal, values = HAT_sites$Municipality, title = "Municipality") %>%

      setView(-123.44799, 48.52919, 10) %>%
      # add controls
      #  addMiniMap(width = 150, height = 150, zoomLevelOffset = -4) %>%
      addControl(title, position = "topright")

    # Display map
    HAT_sites_map
  })

  # Observer to update markers when filtered data changes
  observe({
    d <- data3()
    title <- '<p style="text-align: center; height: 18px; "><span style="font-size:9px;font-weight:bold; background-color: rgba(255, 255, 255, 0.9;");>HAT Covenant GOE Monitoring Sites Map</span></p>'
    pal <- colorFactor(c("#1b9e77", "#7570b3", "#d95f02"), domain = c("Central Saanich", "Colwood", "Esquimalt"))
    HAT_sites_map  <-  leaflet(d) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addCircleMarkers(
        ~ Lng, ~ Lat,
        #
        color = ~pal(Municipality),
        weight = 1, # size of circle border
        stroke = TRUE, fillOpacity = 1, #fillOpacity = 0.5
        radius = 4,
        popup = paste0(
          "<b>Site:</b> ", "<b>", HAT_sites$Site, "</b>",  "<br>",
          "<b>Municipality:</b> ", HAT_sites$Municipality, "<br>",
          "<b>Size:</b> ", HAT_sites$Size_ha, " (ha)", "<br>",
          "<b>First Nations:</b> ", HAT_sites$FirstNations, "<br>",
          "<b>HAT Status:</b> ", HAT_sites$HAT_Status, "<br>",
          "<b>Co-Covenant:</b> ", HAT_sites$Co_Covenant, " (", HAT_sites$Date, ")", "<br>",
          "<b>Ecosystems:</b> ", HAT_sites$Ecosystems, "<br>",
          "<b>Volunteer Stewardship:</b> ", HAT_sites$Volunteer_Stewardship, "<br>"
        ))
  })
  ########################################################################

  # end of server
}
########################################################################

shinyApp(ui,server)

