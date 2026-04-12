library(data.table)
library(ranger)

payroll <- data.table::fread(
  "prorated_annual_Citywide_Payroll_Data_(Fiscal_Year)_20260227.csv",
  select = c(
    "Fiscal Year",
    "Regular Gross Paid",
    "Total OT Paid",
    "Base Salary",
    "Regular Hours",
    "OT Hours",
    "Pay Basis"
  )
)

payroll <- payroll[toupper(trimws(`Pay Basis`)) == "PRORATED ANNUAL"]

payroll$`Regular Gross Paid` <- as.numeric(gsub("[^0-9.-]", "", as.character(payroll$`Regular Gross Paid`)))
payroll$`Total OT Paid` <- as.numeric(gsub("[^0-9.-]", "", as.character(payroll$`Total OT Paid`)))
payroll$`Total OT Paid`[is.na(payroll$`Total OT Paid`)] <- 0

payroll$Total_Paid <- payroll$`Regular Gross Paid` + payroll$`Total OT Paid`

payroll$`Fiscal Year` <- as.numeric(as.character(payroll$`Fiscal Year`))
payroll$`Regular Hours` <- as.numeric(gsub("[^0-9.-]", "", as.character(payroll$`Regular Hours`)))
payroll$`Base Salary` <- as.numeric(gsub("[^0-9.-]", "", as.character(payroll$`Base Salary`)))
payroll$`OT Hours` <- as.numeric(gsub("[^0-9.-]", "", as.character(payroll$`OT Hours`)))

payroll <- payroll[, c(
  "Fiscal Year",
  "Regular Hours",
  "Base Salary",
  "OT Hours",
  "Total_Paid"
)]

payroll <- na.omit(payroll)

names(payroll) <- c("Fiscal_Year", "Regular_Hours", "Base_Salary", "OT_Hours", "Total_Paid")

set.seed(42)
train_idx <- sample(seq_len(nrow(payroll)), size = floor(0.8 * nrow(payroll)))

train <- payroll[train_idx, ]
test <- payroll[-train_idx, ]

rf_model <- ranger::ranger(
  Total_Paid ~ Fiscal_Year + Regular_Hours + Base_Salary + OT_Hours,
  data = train,
  num.trees = 200,
  max.depth = 12,
  min.node.size = 5,
  seed = 42
)

pred_rf <- predict(rf_model, data = test)$predictions

mae_rf <- mean(abs(test$Total_Paid - pred_rf))
rmse_rf <- sqrt(mean((test$Total_Paid - pred_rf)^2))

r2_rf <- 1 - sum((test$Total_Paid - pred_rf)^2) /
  sum((test$Total_Paid - mean(test$Total_Paid))^2)

n <- nrow(test)
p <- 4
adj_r2_rf <- 1 - (1 - r2_rf) * (n - 1) / (n - p - 1)

cat("MAE:", round(mae_rf, 3), "\n")
cat("RMSE:", round(rmse_rf, 3), "\n")
cat("Adjusted R^2:", round(adj_r2_rf, 6), "\n")