library(tidyverse)
library(lubridate)
library(readr)
library(readxl)
library(here)
library(lubridate)
library(DBI)
library(odbc)
library(openxlsx)

#CONNESSIONI AI DATABASE-------
#### dati   ore lavorate dal personale izsler----
conOre <- DBI::dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "dbtest02",
                      Database = "DW_COGE_DEV", Port = 1433)

source(here("R","sql.R"))


ore <- conOre %>% tbl(sql(queryOre)) %>% as_tibble()  ### FTEq
names(ore)[1:6] <- c("Dipartimento", "Reparto", "Laboratorio", "CDC", "CodiceCC", "ANNO")

##DATI DA PROGETTI DI RICERCA----

prj <- read_excel(sheet = "Foglio1", here("data", "raw", "progetti_2022.xlsx"))
recoding_descrUO <- read_excel(sheet = "Foglio1", here("data", "raw", "recoding_descrUO.xlsx"))
recoding_RespScientifico <- read_excel(sheet = "Foglio1", here("data", "raw", "recoding_RespScientifico.xlsx"))



# prj <- prj %>%
#   mutate(
#     Stato = ifelse(DataFine < 2022, "tutti - terminati", "tutti - in corso"),
#     DataInizio = format(as.Date(ymd(ymd_hms(DataInizio)), '%Y-%m-%d'), '%d/%m/%Y'),
#     DataFine = format(as.Date(ymd(ymd_hms(DataFine)), '%Y-%m-%d'), '%d/%m/%Y')) %>%
#   separate(DataInizio, c('dayDataInizio', 'monthDataInizio', 'yearDataInizio'), '/', remove = FALSE)
`
prj <- prj %>%
  left_join(recoding_descrUO, by = c("DescrUO" = "strutture"))

prj <- prj %>%
  left_join(recoding_RespScientifico, by = c("RespScientifico" = "RespScientifico"))

View(prj)

prj %>% 
saveRDS(., file = here( "data", "processed",  "prj_2022.rds"))

progetti <- prj[!duplicated(prj[,c("Codice","RespScientifico")]),]
View(progetti)


# dt <- table(factor(prj$nuove_strutture))
# View(dt)
# write.xlsx(dt, 'UO_nuove strutture.xlsx')


prj_in_corso <- prj %>%
  #filter(yearDataInizio >= 2019)
  filter(Stato == "tutti - in corso") %>%
  filter(!is.na(dipartimenti)) %>%
 filter(!str_detect(dipartimenti,"Sanitaria")) %>%
 filter(!str_detect(dipartimenti,"Amministrativo")) %>%
 filter(!str_detect(dipartimenti,"Generale")) %>%
  select(dipartimenti) %>% unique() %>% View()
  
 
progetti <- prj_in_corso[!duplicated(prj_in_corso[,c("Codice")]),]
View(progetti)


#  write.xlsx('PROGETTI_IN_CORSO.xlsx') 


anag <- ore %>%
  mutate(annoraplav = year(FineRapporto)) %>%
  filter(annoraplav > 2018)%>%
  mutate(Nome = gsub("\\s.*$", "", Nome)) %>%
  select(-Ore)
 # distinct(Matricola, .keep_all = TRUE)


anag <- anag %>%
  group_by(Matricola, Mese, ANNO) %>%
  top_n(1, Percentuale)
# 
# 
# prova <- prj %>%
#   left_join(anag, by = c("MatricolaRespScientUO" = "Matricola")) %>% 
#   mutate(Dipartimento = casefold(Dipartimento, upper = TRUE))  %>%
#   select(-day, -Tipo_P_A, -CodiceNUM, -Laboratorio, -CDC, -CodiceCC, -SmartWorking, -Dirigente,
#          - Contratto, -FineRapporto, -annoraplav) %>%
#   filter(!str_detect(Dipartimento, "LUNGHE ASSENZE")) %>% 
#   filter(!str_detect(Dipartimento, "DIREZIONE")) %>% 
#   filter(!str_detect(Dipartimento, 'COMUNI'))



#saveRDS(., file = here( "data", "processed",  "prj_clean.rds"))



##DATI DA PUBBLICAZIONI####
pubblicazioni <- read_excel(here("data", "raw", "pubblicazioni_agg_luglio_2022.xlsx")) #old version --> pubblicazioni_agg
pubblicazioni$AU <- str_to_upper(pubblicazioni$AU)
pubblicazioni$AU <- str_remove(pubblicazioni$AU, " ")
pubblicazioni$AU <- gsub("_", " ", pubblicazioni$AU)
pubblicazioni$Nome <- str_extract( pubblicazioni$AU, ",.*$")
pubblicazioni$Nome <- str_remove(pubblicazioni$Nome, ",")
pubblicazioni$Nome <- gsub("\\s.*$", "", pubblicazioni$Nome)
pubblicazioni$Cognome <- gsub(",.*$", "", pubblicazioni$AU)

pubblicazioni %>% filter(OA >= 2019) %>%
  left_join(anag, by = c("Cognome" = "Cognome", "Nome" = "Nome", "OA" = "ANNO")) %>%
  # filter(Dirigente == "S") %>%
  mutate(Dipartimento = casefold(Dipartimento, upper = TRUE)) %>%
saveRDS(., file = here( "data", "processed",  "pub.rds"))

