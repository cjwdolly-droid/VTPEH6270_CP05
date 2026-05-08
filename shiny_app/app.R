library(shiny)
library(dplyr)
library(ggplot2)

# -------------------------
# Data preparation
# -------------------------

brfss <- read.csv("NYSDOH_BRFSS_SurveyData_2023.csv", stringsAsFactors = FALSE)

brfss_sub <- brfss %>%
  select(WTKG3, SEXVAR, X_AGE_G, INCOME3) %>%
  mutate(
    SEXVAR = iconv(SEXVAR, from = "", to = "UTF-8"),
    X_AGE_G = iconv(X_AGE_G, from = "", to = "UTF-8"),
    INCOME3 = iconv(INCOME3, from = "", to = "UTF-8"),
    weight_kg = WTKG3 / 100
  ) %>%
  filter(
    !is.na(weight_kg),
    !is.na(SEXVAR),
    !is.na(X_AGE_G),
    !is.na(INCOME3)
  )

# -------------------------
# UI
# -------------------------

ui <- fluidPage(
  titlePanel("Body Weight Distribution Among Adults in New York State"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Project Context"),
      p("This Shiny app explores body weight distributions among adults in New York State using 2023 BRFSS survey data."),
      
      p(strong("Research question:"),
        "How does body weight vary across sex, age group, and income level among adults in New York State?"),
      
      p(strong("Data source:"),
        "New York State Department of Health Behavioral Risk Factor Surveillance System (BRFSS), 2023."),
      
      p(strong("Methods:"),
        "Users can select demographic characteristics to generate a histogram of body weight. The app provides a visual summary and the number of respondents matching the selected group."),
      
      p(strong("Author:"), "Jiawen Chen"),
      
      tags$a(
        "GitHub repository",
        href = "https://github.com/cjwdolly-droid/VTPEH6270",
        target = "_blank"
      ),
      
      hr(),
      
      p(strong("AI disclosure:"),
        "ChatGPT was used to assist with code organization, wording, and formatting. The final content and interpretation were reviewed by the author."),
      
      hr(),
      
      selectInput(
        "sex",
        "Choose sex:",
        choices = sort(unique(brfss_sub$SEXVAR))
      ),
      
      selectInput(
        "age",
        "Choose age group:",
        choices = sort(unique(brfss_sub$X_AGE_G))
      ),
      
      selectInput(
        "income",
        "Choose income level:",
        choices = sort(unique(brfss_sub$INCOME3))
      ),
      
      actionButton("run", "Generate Histogram")
    ),
    
    mainPanel(
      h3("Body Weight Histogram"),
      plotOutput("hist_plot"),
      br(),
      h4("Interpretation"),
      textOutput("description")
    )
  )
)

# -------------------------
# Server
# -------------------------

server <- function(input, output) {
  
  filtered_data <- eventReactive(input$run, {
    brfss_sub %>%
      filter(
        SEXVAR == input$sex,
        X_AGE_G == input$age,
        INCOME3 == input$income
      )
  })
  
  output$hist_plot <- renderPlot({
    data <- filtered_data()
    
    validate(
      need(nrow(data) > 0, "No data are available for this combination.")
    )
    
    ggplot(data, aes(x = weight_kg)) +
      geom_histogram(binwidth = 5, fill = "lightblue", color = "black") +
      labs(
        title = "Body Weight Distribution",
        x = "Body weight (kg)",
        y = "Number of respondents"
      ) +
      theme_minimal(base_size = 14)
  })
  
  output$description <- renderText({
    data <- filtered_data()
    
    if (nrow(data) == 0) {
      return("No respondents matched the selected characteristics.")
    }
    
    paste(
      "This histogram shows the body weight distribution among respondents who are",
      input$sex,
      "in the",
      input$age,
      "age group and the",
      input$income,
      "income category.",
      "The selected group includes",
      nrow(data),
      "respondents."
    )
  })
}

# -------------------------
# Run app
# -------------------------

shinyApp(ui = ui, server = server)
