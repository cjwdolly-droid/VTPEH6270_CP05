# Figures & Reports
library(ggplot2)

# the original data file
temp <- tempfile()
download.file("https://health.data.ny.gov/download/tk4g-wdfe/application%2Fx-zip-compressed",temp, mode="wb")
unzip(temp, "NYSDOH_BRFSS_SurveyData_2023.csv")
brfss <- read.csv("NYSDOH_BRFSS_SurveyData_2023.csv", header=T)

# new subset that includes only eight variables
brfss_sub <- brfss %>%
  select(PA3MIN_, WTKG3, GENHLTH, SEXVAR,
         EDUCA, X_IMPRACE, X_AGE_G, INCOME3
  )

brfss_sub <- brfss_sub %>%
  mutate(
    weight_kg = WTKG3 / 100,
    weekly_activity_hr = PA3MIN_ / 60
  ) %>%
  filter(!is.na(weight_kg), !is.na(SEXVAR), weekly_activity_hr < 168)

# histogram of body weight among Adults in New York State
brfss_sub %>%
  ggplot(aes(x = weight_kg)) + 
  geom_histogram(fill = "lightblue", color = "white") +
  geom_vline(aes(xintercept = mean_wt, color = "Mean")) +
  geom_vline(aes(xintercept = median_wt, color = "Median")) +
  scale_color_manual(
    name = "",
    values = c("Mean" = "green", "Median" = "red")
  ) + 
  labs(
    title = "Distribution of Body Weight among Adults in New York State",
    x = "Body weight (kg)",
    y = "Number of individuals",
    caption = "Histogram of body weight based on BRFSS 2023 data. 
    Vertical lines indicate the mean and median."
  ) +
  theme_minimal() +
  theme(
    plot.caption = element_text(hjust = 0.5),
    plot.margin = margin(t = 10, r = 10, b = 20, l = 10)
  )

# scatter plot for physical activity and body weight
brfss_sub <- brfss_sub %>%
  mutate(weekly_activity_hr = PA3MIN_ / 60)

weekly_activity_possible <- brfss_sub %>%
  filter(weekly_activity_hr < 168)

ggplot(weekly_activity_possible, aes(x = weekly_activity_hr, y = weight_kg)) +
  geom_point(alpha = 0.4, color = "blue") +
  labs(
    title = "Physical Activity and Body Weight among Adults in New York State",
    x = "Weekly physical activity (hours)",
    y = "Body weight (kg)",
    caption = "Scatter plot of weekly physical activity and body weight based on 
    BRFSS 2023 data, after removing implausible values."
  ) +
  theme_minimal() +
  theme(
    plot.caption = element_text(
      hjust = 0.5,     
      size = 8,
      margin = margin(t = 10)
    )
  )

# Data central tendency and dispersion
table(brfss_sub$SEXVAR, useNA = "ifany")
summary(brfss_sub$weight_kg)

brfss_sub %>%
  group_by(SEXVAR) %>%
  summarise(
    n = n(),
    mean_wt = mean(weight_kg, na.rm = TRUE),
    sd_wt   = sd(weight_kg, na.rm = TRUE),
    median_wt = median(weight_kg, na.rm = TRUE),
    iqr_wt = IQR(weight_kg, na.rm = TRUE)
  )
