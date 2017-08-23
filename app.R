library(shiny)
library(shinydashboard)
library(googleVis)
library(rwunderground)

rwunderground::set_api_key("[your WU API key here]")

ui <- dashboardPage(
        dashboardHeader(title = "ShinyWeather",
                        titleWidth = 260),
        dashboardSidebar(
                width = 260,
                selectInput(
                        inputId = "location_id",
                        label = "Select a location:",
                        choices = c(
                                "Africa/Ouagadougou",
                                "Australia/Woolloomooloo",
                                "Canada/Tuktoyaktuk",
                                "French_Polynesia/Puka-Puka"
                        )
                ),
                actionButton(inputId = "submit_loc",
                             label = "Submit")
        ),
        dashboardBody(
                fluidRow(
                        box(
                                title = "Documentation",
                                background = "teal",
                                collapsible = TRUE,
                                "Select a location from the list and click Submit to display current conditions and a 24-hour forecast.",
                                br(),br(),
                                "Note that it may take a few seconds to update the data when switching between locations.
                                Also, if you hit Submit more than five times within a minute, the results may fail to load.
                                This is due to a limit in the (free) API that provides the weather data."
                        )
                ),
                conditionalPanel(
                        condition = "output.dataLoaded!=1",
                        fluidRow(
                                valueBoxOutput("currentTempValueBox"),
                                valueBoxOutput("currentFeelsLikeValueBox"),
                                valueBoxOutput("currentHumidityValueBox"),
                                tags$style("#currentTempValueBox {width:16em}"),
                                tags$style("#currentHumidityValueBox {width:16em}"),
                                tags$style("#currentFeelsLikeValueBox {width:16em}")
                        ),
                        fluidRow(
                                valueBoxOutput("currentWeatherDescValueBox"),
                                tags$style("#currentWeatherDescValueBox {width:48em}")
                        ),
                        fluidRow(
                                tabBox(
                                        title = "Next 24 Hours",
                                        id = "tabset1",
                                        height = "400px",
                                        width = 5,
                                        tabPanel("Temperature", htmlOutput("forecast")),
                                        tabPanel("Atmospheric Pressure", htmlOutput("pressurefcast"))
                                )
                        )
                )
                        )
)

server <- function(input, output) {
        rv_data = reactiveValues(current = NULL,
                                 forecast = NULL)
        
        observeEvent(eventExpr = input[["submit_loc"]],
                     handlerExpr = {
                             current <-
                                     rwunderground::conditions(input[["location_id"]], use_metric = TRUE)
                             forecast <-
                                     rwunderground::hourly(input[["location_id"]], use_metric = TRUE)
                             rv_data$current <- current
                             rv_data$forecast <- forecast[1:24, ]
                     })
        
        output$dataLoaded <- reactive({
                is.null(rv_data$current)
        })
        
        outputOptions(output, "dataLoaded", suspendWhenHidden = FALSE)
        
        output$forecast <- renderGvis({
                gvisAreaChart(
                        rv_data$forecast,
                        xvar = "date",
                        yvar = c("temp"),
                        options = list(
                                legend = "none",
                                height = 350,
                                vAxis = "{title: 'temperature (°C)'}",
                                vAxes = "[{viewWindowMode:'explicit',viewWindow:{min:0, max:45}}]",
                                legend = "{position: 'bottom'}"
                        )
                )
        })
        
        output$pressurefcast <- renderGvis({
                gvisAreaChart(
                        rv_data$forecast,
                        xvar = "date",
                        yvar = "mslp",
                        options = list(
                                colors = "['orange']",
                                height = 350,
                                vAxis = "{title: 'mean sea level pressure (kPa)'}",
                                legend = "none"
                        )
                )
        })
        
        output$currentTempValueBox <- renderValueBox({
                valueBox(
                        paste0(rv_data$current$temp, "°C"),
                        "Current Temperature",
                        icon = icon("thermometer-full"),
                        color = "maroon"
                )
        })
        
        output$currentWeatherDescValueBox <- renderValueBox({
                valueBox(
                        rv_data$current$weather,
                        "Current Conditions",
                        icon = icon("sun-o"),
                        color = "olive"
                )
        })
        
        output$currentFeelsLikeValueBox <- renderValueBox({
                valueBox(
                        paste0(rv_data$current$feelslike, "°C"),
                        "Feels Like",
                        icon = icon("meh-o"),
                        color = "aqua"
                )
        })
        
        output$currentHumidityValueBox <- renderValueBox({
                valueBox(
                        paste0(rv_data$current$pct_humidity, "%"),
                        "Humidity",
                        icon = icon("tint", lib = "glyphicon"),
                        color = "orange",
                        width = 3
                )
        })
}

shinyApp(ui, server)