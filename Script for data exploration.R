# Data exploration

# the original data file
temp <- tempfile()
download.file("https://health.data.ny.gov/download/tk4g-wdfe/application%2Fx-zip-compressed",temp, mode="wb")
unzip(temp, "NYSDOH_BRFSS_SurveyData_2023.csv")
brfss <- read.csv("NYSDOH_BRFSS_SurveyData_2023.csv", header=T)

# create a subset containing right variables
brfss_sub <- brfss %>%
  select(
    PA3MIN_,
    WTKG3,
    GENHLTH,
    SEXVAR,
    EDUCA,
    X_IMPRACE,
    X_AGE_G,
    INCOME3
  )

brfss_sub <- brfss_sub %>%
  mutate(weight_kg = WTKG3 / 100)

# preview the subset
head(brfss_sub)

# Generate a table including all selected variables and their types and classes
kable(data.frame(
  Variable = c("PA3MIN", "WTKG3", "GENHLTH", "SEXVAR", "EDUCA", "_X_IMPRACE", 
               "_X_AGE_G", "INCOME3", "weight_kg"),
  Description = c(
    "Weekly minutes of physical activity",
    "Body weight",
    "Self-rated general health",
    "Sex of respondent",
    "Education level",
    "Race/ethnicity",
    "Age group",
    "Household income",
    "Body weight in kg"
  ),
  Type = c("Continuous", "Continuous", "Categorical", "Categorical", 
           "Categorical", "Categorical", "Categorical", "Categorical", "Continuous"),
  Class = c("Numeric", "Numeric", "Character", "Character", "Character", 
            "Character", "Character", "Character", "Numeric")
))