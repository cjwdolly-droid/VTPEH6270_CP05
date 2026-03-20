# VTPEH6270 Checkpoint 5

## Project title and brief description
This project explores selected variables from the 2023 New York State Department of Health Behavioral Risk Factor Surveillance System (NYSDOH BRFSS) dataset. The project includes data acquisition, variable selection, descriptive data exploration, and a simulation exercise examining how effect size, sample size, and noise level can influence statistical results. Output files include figures and other generated results from the analysis.

## Author(s) and affiliations
Jiawen Chen  
Cornell University

## Contact information
jc3783@cornell.edu

## Research question/objectives
The objectives of this project are:
1. Inspect the original NYSDOH BRFSS 2023 dataset.
2. Create a smaller analytic subset containing selected variables of interest.
3. Explore patterns in demographic and health-related variables.
4. Use simulation to demonstrate how statistical findings may vary under different combinations of effect size, sample size, and noise.

## Data source and description
The primary data source is the 2023 NYSDOH BRFSS Survey Data, which is publicly available from the New York State Health Data website. Because the original unprocessed data file exceeds GitHub's file size limit, it is not stored directly in this repository. The file can be downloaded from the public NYSDOH source using the script `Original data file.R`.

Selected variables in the analytic subset include:
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

These variables were used for descriptive exploration and simulation-related analysis.

## Links to reports, apps, or other deliverables
Project files and deliverables are organized in this repository, including:
- Original data file
- Processed data file
- Data dictionary
- Scripts for data exploration
- Scripts for data simulation
- Output files (Figures & Reports)

## AI tool disclosure
ChatGPT was used to assist with wording, organization, and troubleshooting during the development of this project and repository documentation. The analysis design, code execution, and final decisions were completed by the author.

## References/citations
New York State Department of Health. Behavioral Risk Factor Surveillance System (BRFSS) Survey Data 2023. Available from the New York State Health Data website.