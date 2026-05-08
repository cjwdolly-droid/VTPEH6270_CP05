# Data simulation

# the original data file
temp <- tempfile()
download.file("https://health.data.ny.gov/download/tk4g-wdfe/application%2Fx-zip-compressed",temp, mode="wb")
unzip(temp, "NYSDOH_BRFSS_SurveyData_2023.csv")
brfss <- read.csv("NYSDOH_BRFSS_SurveyData_2023.csv", header=T)

# create a subset containing only eight variables
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

# Data simulation
simulate_activity <- function(effect_size, noise, sample_size) {
  prop_male <- 0.52
  m_F <- 7.55
  m_M <- m_F + effect_size
  
  SEXVAR <- sample(
    c("Female", "Male"),
    size = sample_size,
    replace = TRUE,
    prob = c(1 - prop_male, prop_male)
  )
  
  weekly_activity_hr <- numeric(sample_size)
  idx_F <- SEXVAR == "Female"
  idx_M <- SEXVAR == "Male"
  weekly_activity_hr[idx_F] <- rnorm(sum(idx_F), mean = m_F, sd = noise)
  weekly_activity_hr[idx_M] <- rnorm(sum(idx_M), mean = m_M, sd = noise)
  weekly_activity_hr <- pmax(weekly_activity_hr, 0)
  
  sim_data <- data.frame(
    SEXVAR = SEXVAR,
    weekly_activity_hr = weekly_activity_hr
  )
  
  sim_summary <- sim_data %>%
    group_by(SEXVAR) %>%
    summarise(
      n = n(),
      mean_activity = mean(weekly_activity_hr),
      sd_activity = sd(weekly_activity_hr),
      median_activity = median(weekly_activity_hr),
      q1_activity = quantile(weekly_activity_hr, 0.25),
      q3_activity = quantile(weekly_activity_hr, 0.75),
      iqr_activity = IQR(weekly_activity_hr),
      .groups = "drop"
    )
  
  return(list(
    data = sim_data,
    summary = sim_summary
  ))
  
}

effect_sizes <- seq(0, 3, length.out = 10)
sample_sizes <- c(10, 50, 100, 200, 500, 800, 1000, 2000, 4000, 8000)
noise_levels <- c(5, 8, 12)

set.seed(123)

simulation_results <- list()
run_id <- 1

for (e in effect_sizes) {
  for (n in sample_sizes) {
    for (s in noise_levels) {
      
      sim_out <- simulate_activity(
        effect_size = e,
        noise = s,
        sample_size = n
      )
      
      simulation_results[[run_id]] <- list(
        effect_size = e,
        noise = s,
        sample_size = n,
        data = sim_out$data,
        summary = sim_out$summary
      )
      
      run_id <- run_id + 1
    }
  }
}

length(simulation_results)
names(simulation_results[[1]])
