library(tidyr)

##############################################################################
# 2021
HAT_Restoration_Crew_Data_MS_2021_test <- read.csv("data/HAT-Restoration-Crew-Data-MASTER-2021-test.csv", fileEncoding="UTF-8")

colnames(HAT_Restoration_Crew_Data_MS_2021_test)

str(HAT_Restoration_Crew_Data_MS_2021_test)
HAT_Restoration_Crew_Data_MS_2021_test$Invasive_Species_Cleared

HAT_Restoration_Crew_Data_MS_2021_test$Invasive_Species_Cleared_orig <- HAT_Restoration_Crew_Data_MS_2021_test$Invasive_Species_Cleared
colnames(HAT_Restoration_Crew_Data_MS_2021_test)


HAT_Restoration_Crew_Data_MS_2021_test_long <- separate_rows(HAT_Restoration_Crew_Data_MS_2021_test, Invasive_Species_Cleared, sep = ",")
print(HAT_Restoration_Crew_Data_MS_2021_test_long)


# Count comma-separated values  # Split and count
HAT_Restoration_Crew_Data_MS_2021_test_long$Count <- lengths(strsplit(HAT_Restoration_Crew_Data_MS_2021_test_long$Invasive_Species_Cleared_orig, ","))

colnames(HAT_Restoration_Crew_Data_MS_2021_test_long)
# create new column for Biomass_Removed_m3_orig & Area_Cleared_m2_orig

HAT_Restoration_Crew_Data_MS_2021_test_long$Biomass_Removed_m3_orig <-  HAT_Restoration_Crew_Data_MS_2021_test_long$Biomass_Removed_m3
HAT_Restoration_Crew_Data_MS_2021_test_long$Area_Cleared_m2_orig <-  HAT_Restoration_Crew_Data_MS_2021_test_long$Area_Cleared_m2
colnames(HAT_Restoration_Crew_Data_MS_2021_test_long)

HAT_Restoration_Crew_Data_MS_2021_test_long$Biomass_Removed_m3 <- HAT_Restoration_Crew_Data_MS_2021_test_long$Biomass_Removed_m3_orig / HAT_Restoration_Crew_Data_MS_2021_test_long$Count

##############################################################################
# 2022

##############################################################################
# 2023

##############################################################################
# 2024

##############################################################################
# 2025

HAT_Restoration_Crew_Data_MS_2025_test <- read.csv("data/HAT-Restoration-Crew-Data-MASTER-2025-test.csv", fileEncoding="UTF-8")

colnames(HAT_Restoration_Crew_Data_MS_2025_test)
str(HAT_Restoration_Crew_Data_MS_2025_test)

# Rename columns
names(HAT_Restoration_Crew_Data_MS_2025_test)[names(HAT_Restoration_Crew_Data_MS_2025_test) == "Biomass.Removed..m3."] <- "Biomass_Removed_m3"
names(HAT_Restoration_Crew_Data_MS_2025_test)[names(HAT_Restoration_Crew_Data_MS_2025_test) == "Area.Cleared..m2."] <- "Area_Cleared_m2"
names(HAT_Restoration_Crew_Data_MS_2025_test)[names(HAT_Restoration_Crew_Data_MS_2025_test) == "Invasive.Species.Cleared"] <- "Invasive_Species_Cleared"
names(HAT_Restoration_Crew_Data_MS_2025_test)[names(HAT_Restoration_Crew_Data_MS_2025_test) == "Crew.Hours"] <- "Crew_Hours"
names(HAT_Restoration_Crew_Data_MS_2025_test)[names(HAT_Restoration_Crew_Data_MS_2025_test) == "Work.Site"] <- "Site"
colnames(HAT_Restoration_Crew_Data_MS_2025_test)

HAT_Restoration_Crew_Data_MS_2025_test$Invasive_Species_Cleared_orig <- HAT_Restoration_Crew_Data_MS_2025_test$Invasive_Species_Cleared
colnames(HAT_Restoration_Crew_Data_MS_2025_test)

HAT_Restoration_Crew_Data_MS_2025_test_long <- separate_rows(HAT_Restoration_Crew_Data_MS_2025_test, Invasive_Species_Cleared, sep = ",")

# Count comma-separated values  # Split and count
HAT_Restoration_Crew_Data_MS_2025_test_long$Count <- lengths(strsplit(HAT_Restoration_Crew_Data_MS_2025_test_long$Invasive_Species_Cleared_orig, ","))

# create new column for Biomass_Removed_m3_orig & Area_Cleared_m2_orig
HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3_orig <-  HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3
HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2_orig <-  HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2
HAT_Restoration_Crew_Data_MS_2025_test_long$Crew_Hours_orig <-  HAT_Restoration_Crew_Data_MS_2025_test_long$Crew_Hours
colnames(HAT_Restoration_Crew_Data_MS_2025_test_long)
str(HAT_Restoration_Crew_Data_MS_2025_test_long)

# change character to numeric
HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2 <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2))
HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3 <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3))
HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2_orig <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2_orig))
HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3_orig <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3_orig))
str(HAT_Restoration_Crew_Data_MS_2025_test_long)

HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3 <- HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3_orig / HAT_Restoration_Crew_Data_MS_2025_test_long$Count
HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2 <- HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2_orig / HAT_Restoration_Crew_Data_MS_2025_test_long$Count
HAT_Restoration_Crew_Data_MS_2025_test_long$Crew_Hours <- HAT_Restoration_Crew_Data_MS_2025_test_long$Crew_Hours_orig / HAT_Restoration_Crew_Data_MS_2025_test_long$Count

## change to one decimal
HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3 <- sprintf("%.1f", HAT_Restoration_Crew_Data_MS_2025_test_long$Biomass_Removed_m3)
HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2 <- sprintf("%.1f", HAT_Restoration_Crew_Data_MS_2025_test_long$Area_Cleared_m2)
HAT_Restoration_Crew_Data_MS_2025_test_long$Crew_Hours <- sprintf("%.1f", HAT_Restoration_Crew_Data_MS_2025_test_long$Crew_Hours)

## New column for Data_Change_Assumptions

HAT_Restoration_Crew_Data_MS_2025_test_long$Data_Change_Assumptions <- paste("estimate 1/", HAT_Restoration_Crew_Data_MS_2025_test_long$Count, " of biomass, area, and work hours",  sep = "")

##############################################################################
##############################################################################
##############################################################################

# Combine all 2021-2025 files


HAT_Restoration_Crew_Data_MS_2021_test <- read.csv("data/HAT-Restoration-Crew-Data-MASTER-2021-test.csv", fileEncoding="UTF-8")
HAT_Restoration_Crew_Data_MS_2022_test <- read.csv("data/HAT-Restoration-Crew-Data-MASTER-2022-test.csv", fileEncoding="UTF-8")
HAT_Restoration_Crew_Data_MS_2023_test <- read.csv("data/HAT-Restoration-Crew-Data-MASTER-2023-test.csv", fileEncoding="UTF-8")
HAT_Restoration_Crew_Data_MS_2024_test <- read.csv("data/HAT-Restoration-Crew-Data-MASTER-2024-test.csv", fileEncoding="UTF-8")
HAT_Restoration_Crew_Data_MS_2025_test <- read.csv("data/HAT-Restoration-Crew-Data-MASTER-2025-test.csv", fileEncoding="UTF-8")

colnames(HAT_Restoration_Crew_Data_MS_2021_test)
colnames(HAT_Restoration_Crew_Data_MS_2022_test)
colnames(HAT_Restoration_Crew_Data_MS_2023_test)
colnames(HAT_Restoration_Crew_Data_MS_2024_test)
colnames(HAT_Restoration_Crew_Data_MS_2025_test)

# need to add empty Polygon column to 2023-2025 & change column order
HAT_Restoration_Crew_Data_MS_2023_test[, "Polygon"] <- NA
HAT_Restoration_Crew_Data_MS_2024_test[, "Polygon"] <- NA
HAT_Restoration_Crew_Data_MS_2025_test[, "Polygon"] <- NA

# need to add empty Polygon column to 2023-2025 & change column order
HAT_Restoration_Crew_Data_MS_2021_test[, "Location"] <- NA

colnames(HAT_Restoration_Crew_Data_MS_2021_test)
colnames(HAT_Restoration_Crew_Data_MS_2022_test)
colnames(HAT_Restoration_Crew_Data_MS_2023_test)
colnames(HAT_Restoration_Crew_Data_MS_2024_test)
colnames(HAT_Restoration_Crew_Data_MS_2025_test)

HAT_Restoration_Crew_Data_MS_2021_test <- HAT_Restoration_Crew_Data_MS_2021_test %>%
  relocate(Year, Date, Work.Site,  Location, Polygon, Area.Cleared..m2., Biomass.Removed..m3.,  Invasive.Species.Cleared,  Crew.Hours, Notes )
HAT_Restoration_Crew_Data_MS_2022_test <- HAT_Restoration_Crew_Data_MS_2022_test %>%
  relocate(Year, Date, Work.Site,  Location, Polygon, Area.Cleared..m2., Biomass.Removed..m3.,  Invasive.Species.Cleared,  Crew.Hours, Notes )
HAT_Restoration_Crew_Data_MS_2023_test <- HAT_Restoration_Crew_Data_MS_2023_test %>%
  relocate(Year, Date, Work.Site,  Location, Polygon, Area.Cleared..m2., Biomass.Removed..m3.,  Invasive.Species.Cleared,  Crew.Hours, Notes )
HAT_Restoration_Crew_Data_MS_2024_test <- HAT_Restoration_Crew_Data_MS_2024_test %>%
  relocate(Year, Date, Work.Site,  Location, Polygon, Area.Cleared..m2., Biomass.Removed..m3.,  Invasive.Species.Cleared,  Crew.Hours, Notes )
HAT_Restoration_Crew_Data_MS_2025_test <- HAT_Restoration_Crew_Data_MS_2025_test %>%
  relocate(Year, Date, Work.Site,  Location, Polygon, Area.Cleared..m2., Biomass.Removed..m3.,  Invasive.Species.Cleared,  Crew.Hours, Notes )

HAT_Restoration_Crew_Data_MS_all_test <- rbind(HAT_Restoration_Crew_Data_MS_2021_test, HAT_Restoration_Crew_Data_MS_2022_test, HAT_Restoration_Crew_Data_MS_2023_test, HAT_Restoration_Crew_Data_MS_2024_test, HAT_Restoration_Crew_Data_MS_2025_test)

names(HAT_Restoration_Crew_Data_MS_all_test)[names(HAT_Restoration_Crew_Data_MS_all_test) == "Biomass.Removed..m3."] <- "Biomass_Removed_m3"
names(HAT_Restoration_Crew_Data_MS_all_test)[names(HAT_Restoration_Crew_Data_MS_all_test) == "Area.Cleared..m2."] <- "Area_Cleared_m2"
names(HAT_Restoration_Crew_Data_MS_all_test)[names(HAT_Restoration_Crew_Data_MS_all_test) == "Invasive.Species.Cleared"] <- "Invasive_Species_Cleared"
names(HAT_Restoration_Crew_Data_MS_all_test)[names(HAT_Restoration_Crew_Data_MS_all_test) == "Crew.Hours"] <- "Crew_Hours"
names(HAT_Restoration_Crew_Data_MS_all_test)[names(HAT_Restoration_Crew_Data_MS_all_test) == "Work.Site"] <- "Site"
colnames(HAT_Restoration_Crew_Data_MS_all_test)

str(HAT_Restoration_Crew_Data_MS_all_test)

# create duplicate original columns before splitting
HAT_Restoration_Crew_Data_MS_all_test$Biomass_Removed_m3_orig <-  HAT_Restoration_Crew_Data_MS_all_test$Biomass_Removed_m3
HAT_Restoration_Crew_Data_MS_all_test$Area_Cleared_m2_orig <-  HAT_Restoration_Crew_Data_MS_all_test$Area_Cleared_m2
HAT_Restoration_Crew_Data_MS_all_test$Crew_Hours_orig <-  HAT_Restoration_Crew_Data_MS_all_test$Crew_Hours
HAT_Restoration_Crew_Data_MS_all_test$Invasive_Species_Cleared_orig <-  HAT_Restoration_Crew_Data_MS_all_test$Invasive_Species_Cleared
colnames(HAT_Restoration_Crew_Data_MS_all_test)
str(HAT_Restoration_Crew_Data_MS_all_test)

# change character to numeric
HAT_Restoration_Crew_Data_MS_all_test$Area_Cleared_m2 <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test$Area_Cleared_m2))
HAT_Restoration_Crew_Data_MS_all_test$Biomass_Removed_m3 <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test$Biomass_Removed_m3))
HAT_Restoration_Crew_Data_MS_all_test$Crew_Hours <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test$Crew_Hours))
HAT_Restoration_Crew_Data_MS_all_test$Area_Cleared_m2_orig <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test$Area_Cleared_m2_orig))
HAT_Restoration_Crew_Data_MS_all_test$Biomass_Removed_m3_orig <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test$Biomass_Removed_m3_orig))
HAT_Restoration_Crew_Data_MS_all_test$Crew_Hours_orig <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test$Crew_Hours_orig))
str(HAT_Restoration_Crew_Data_MS_all_test)


##############################
### Fix dates first
# make duplicate original date column
HAT_Restoration_Crew_Data_MS_all_test$Date_orig <- HAT_Restoration_Crew_Data_MS_all_test$Date
colnames(HAT_Restoration_Crew_Data_MS_all_test)

#  relocate columns
HAT_Restoration_Crew_Data_MS_all_test <- HAT_Restoration_Crew_Data_MS_all_test %>%
  relocate(Year, Date, Date_orig, Site,  Location, Polygon, Area_Cleared_m2, Biomass_Removed_m3,  Invasive_Species_Cleared,  Crew_Hours, Notes, Biomass_Removed_m3_orig, Area_Cleared_m2_orig, Crew_Hours_orig, Invasive_Species_Cleared_orig, Count)
colnames(HAT_Restoration_Crew_Data_MS_all_test)

write.csv(HAT_Restoration_Crew_Data_MS_all_test, "data/HAT_Restoration_Crew_Data_MS_all_test.csv")
# fix dates in Excel
HAT_Restoration_Crew_Data_MS_all_test_fixDate <- read.csv("data/HAT_Restoration_Crew_Data_MS_all_test.csv", fileEncoding="UTF-8")

# separate values
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep <- HAT_Restoration_Crew_Data_MS_all_test_fixDate %>% separate(Date, into = c("Day", "Month"), sep = "-")




# convert month name to number
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Month <- match(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Month, month.abb)

# create new column for Date
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Date <- NA

HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Date <- paste(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Year, HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Month,HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Day,sep =  "-")
str(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep)


HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Date <- as.Date(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Date)
str(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep)

########################3

HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep <- subset(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep, select = -c(1))

#  relocate columns
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep <- HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep %>%
  relocate(Year, Date, Date_orig, Site,  Location, Polygon, Area_Cleared_m2, Biomass_Removed_m3,  Invasive_Species_Cleared,  Crew_Hours, Notes, Biomass_Removed_m3_orig, Area_Cleared_m2_orig, Crew_Hours_orig, Invasive_Species_Cleared_orig, Count)
colnames(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep)


# Count comma-separated values  # Split and count
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Count <- lengths(strsplit(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep$Invasive_Species_Cleared_orig, ","))

# separate rows
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long <- separate_rows(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep, Invasive_Species_Cleared, sep = ",")
str(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long)






# Calculate values after separating species
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Biomass_Removed_m3 <- HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Biomass_Removed_m3_orig / HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Count
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Area_Cleared_m2 <- HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Area_Cleared_m2_orig / HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Count
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Crew_Hours <- HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Crew_Hours_orig / HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Count
str(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long)

## change to one decimal
# this changes back to character
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Biomass_Removed_m3 <- sprintf("%.1f", HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Biomass_Removed_m3)
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Area_Cleared_m2 <- sprintf("%.1f", HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Area_Cleared_m2)
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Crew_Hours <- sprintf("%.1f", HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Crew_Hours)
str(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long)

# needed again after calculation change character to numeric
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Area_Cleared_m2 <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Area_Cleared_m2))
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Biomass_Removed_m3 <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Biomass_Removed_m3))
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Crew_Hours <- as.numeric(as.character(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Crew_Hours))
str(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long)


## New column for Data_Change_Assumptions
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Data_Change_Assumptions <- paste("estimate 1/", HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Count, " of biomass, area, and work hours",  sep = "")

# consistent Site Names
unique(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site)
# trim trailing while spaces
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site <- trimws(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site)

# change site name to short version for easier charting
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site <- gsub("Matson Conservation Area", "Matson", HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site)
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site <- gsub("Oak Haven Park", "Oak Haven", HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site)
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site <- gsub("Havenwood Park", "Havenwood", HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long$Site)

str(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long)


# removed unnedded columns
colnames(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long)
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub <- subset(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long, select = -c(2,11,12,13,14,15,16,17))



## need to clear Invasive_Species_Cleared
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared_unclean <- HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared
colnames(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub)

unique(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared)

# trim trailing while spaces
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared_spelling <- trimws(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared)
colnames(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub)
unique(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared_spelling)

# replace Invasive_Species_Cleared with trailing spaces removed
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared <- HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared_spelling

#  create column for Invasive MixedGrass
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Native_or_Invasive <- NA

## change spelling and capitalization of species
unique(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared)
library(stringr)

# sort Invasive_Species_Cleared column in R to see which values need to be made consistent
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Himalayan Blackberry|Blackberry|h.blackberry|H blackberry|Hymalayan Blackberry", "Himalayan blackberry")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "S.broom|Broom|Scotch Broom (note: much had been previously cut by volunteer)|Daphne (mostly)|S broom|scotch broom|Scotch broom|Scotch Broom|Scotch Broom also present|Scotch broom also present", "Scotch broom")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Cleaver", "cleaver")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Creeping buttercup", "creeping buttercup")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Daphne|Daphne (mostly)", "daphne")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Dead Nettle", "dead nettle")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "English Hawthorn", "English hawthorn")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "E ivy|english ivy|English Ivy|ivy|Ivy|some English Ivy", "English ivy")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "English English ivy", "English ivy")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Hanging sedge", "hanging sedge")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Holly", "holly")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Orchard grass|Orchardgrass", "orchard grass")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Periwinkle|periwinkle.", "periwinkle")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Privet", "privet")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Sedges|invasive sedge|hanging sedge", "sedge")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Shiny geranium|Shiny Geranium", "shiny geranium")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Sweet Vernal Grass", "sweet vernal grass")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Thatch", "thatch")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Thistle", "thistle")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Velvet Grass", "velvet grass")
HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared  <- str_replace(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared, "Vinca", "periwinkle")

unique(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub$Invasive_Species_Cleared)


## Populate Native Invasive
colnames(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub)

write.csv(HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub, "data/HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub.csv")

HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub_natinv <- read.csv("data/HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub.csv", fileEncoding="UTF-8")

# library(dplyr)
# doing the second mutate cancels the first WTF ???
# HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub_mut$Native_or_Invasive <- HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub %>%
#   mutate(Native_or_Invasive = ifelse(Invasive_Species_Cleared == "Himalayan blackberry", "Invasive", Native_or_Invasive))
# HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub_mut$Native_or_Invasive <- HAT_Restoration_Crew_Data_MS_all_test_fixDate_sep_long_sub %>%
#   mutate(Native_or_Invasive = ifelse(Invasive_Species_Cleared == "periwinkle", "Invasive", Native_or_Invasive))


