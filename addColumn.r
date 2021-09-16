
data$age <- ifelse(data$age < 30, "30under", "30above")

data$customer[data$customer %like% "외국인"] <- "외국인"

data$customer[data$customer %in% ("외국인","재미동포")] <- "외국인"


