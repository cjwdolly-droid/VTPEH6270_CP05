# VTPHE6270 Final Project

## Project Description

This project explores selected variables from the 2023 New York State Department of Health Behavioral Risk Factor Surveillance System (NYSDOH BRFSS) dataset. The analysis focuses on the relationship between weekly physical activity and body weight among adults in New York State.

The project includes:

- Data cleaning and analysis
- Descriptive data exploration
- Multiple linear regression analysis
- Assumption checking
- Interactive Shiny application

---

## Author Information

**Jiawen Chen**  
Cornell University  

Contact: jc3783@cornell.edu

---

## Research Objectives

The objectives of this project are to:

- Examine the association between weekly physical activity and body weight
- Explore demographic differences in body weight
- Evaluate linear regression model assumptions
- Demonstrate statistical concepts using simulation methods

---

## Data Source

The primary data source is the 2023 NYSDOH BRFSS Survey Data.

Because the original raw dataset exceeds GitHub file size limits, it is not directly stored in this repository. The data can be accessed from the New York State Health Data website and imported using the provided R scripts.

Selected variables used in the analytic subset include:

- PASMIN_
- WTKG3
- GENHLTH
- SEXVAR
- EDUCA
- X_IMPRACE
- X_AGE_G
- INCOME3
- weight_kg
- weekly_activity_hr

---

## Repository Structure

```text
data/               # Original and processed data files
scripts/            # Data exploration and simulation scripts
final_report/       # Final report (.Rmd and outputs)
shiny_app/          # Shiny application files
project_files/      # Previous checkpoint materials
```

---

## Required Packages

This project was developed in R using the following packages:

```r
library(tidyverse)
library(ggplot2)
library(dplyr)
library(shiny)
library(knitr)
library(kableExtra)
```

Additional packages may be required depending on the local R environment.

---

## Reproducibility Instructions

To reproduce this project:

1. Clone this repository
2. Install the required R packages
3. Run scripts in the `scripts/` folder
4. Open and knit the R Markdown file in `final_report/`
5. Run the Shiny application using:

```r
shiny::runApp("shiny_app")
```

---

## Shiny Application

The interactive Shiny application allows users to explore body weight distributions among New York State adults by:

- Sex
- Age group
- Income level

---

## Deliverables

This repository contains:

- Final report
- Data exploration scripts
- Simulation scripts
- Processed dataset
- Data dictionary
- Shiny application
- Course checkpoint materials

---

## AI Tool Disclosure

ChatGPT was used to assist with wording, repository organization, troubleshooting, and documentation support. All analyses, statistical interpretations, coding decisions, and final outputs were completed and verified by the author.

---

## References

New York State Department of Health. Behavioral Risk Factor Surveillance System (BRFSS) Survey Data 2023.

Available from:  
[https://health.data.ny.gov/](https://health.data.ny.gov/Health/Behavioral-Risk-Factor-Surveillance-Survey-2023/tk4g-wdfe/about_data)
