library("dplyr")
library("tibble")
library("readr")

#journal_addchange_and_delete.R
#Author - Matt Carruthers

#Put journal files to be compared in OCLC Holdings directory
setwd("~/OCLC Holdings")

#Read in the two files you'll be comparing
data_old <- read_csv("Report_Active_20180604_journals.csv", locale = locale(encoding = "UTF-8"))
data_new <- read_csv("Report_Active_20180705_journals.csv", locale = locale(encoding = "UTF-8"))

#Run diff to find rows in newer spreadsheet that are not in older spreadsheet
#Add missing columns required for upload into Worldshare KB
#Reorder columns
data_to_run1 <- setdiff(data_new, data_old) %>%
  mutate(ISBN10 = "", ISBN13 = "", PublicationDate = "", Subject = "", Author = "") %>%
  select(Type, Title, ISSN, eISSN, ISBN10, ISBN13, StartDate, EndDate, PublicationDate, Resource, Subject, URL, Author)

#Run diff to find rows in older spreadsheet that are not in newer spreadsheet
#Add missing columns required for upload into Worldshare KB
#Reorder columns
data_to_run2 <- setdiff(data_old, data_new) %>%
  mutate(ISBN10 = "", ISBN13 = "", PublicationDate = "", Subject = "", Author = "") %>%
  select(Type, Title, ISSN, eISSN, ISBN10, ISBN13, StartDate, EndDate, PublicationDate, Resource, Subject, URL, Author)

#Write the results of the diffs into two files
write_excel_csv(data_to_run1, "Report_Active_20180604_20180705_journals_addchange_test.csv", na = "")
write_excel_csv(data_to_run2, "Report_Active_20180604_20180705_journals_deletions_test.csv", na = "")