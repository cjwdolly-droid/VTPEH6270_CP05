# The original data file exceeds GitHub's file size limit.
# This script downloads the original dataset directly from the public source.

# Source - https://stackoverflow.com/q/74187411
# Posted by Karimic Magellan, modified by community. See post 'Timeline' for change history
# Retrieved 2026-03-17, License - CC BY-SA 4.0

temp <- tempfile()
download.file("https://health.data.ny.gov/download/tk4g-wdfe/application%2Fx-zip-compressed",temp, mode="wb")
unzip(temp, "NYSDOH_BRFSS_SurveyData_2023.csv")
db <- read.csv("NYSDOH_BRFSS_SurveyData_2023.csv", header=T)
