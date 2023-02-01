# Packages ----
library(shiny)
#library(shinythemes)
library(shinydashboard)
library(shinydashboardPlus)
#library(shinyBS)

#library(bslib) #https://rstudio.github.io/bslib/articles/bslib.html _ PER SCEGLIERE/MODIFICARE TEMA
library(shinyWidgets) #per inserire immagini sfondo con setBackgroundImage()
library(tidyverse)
library(lubridate)
#library(shinipsum) #https://github.com/ThinkR-open/shinipsum _ CREA ELEMENTI CASUALI LATO SERVER
library(here)
library(DT)
library(gt)
library(stringr)
library(readxl)
library(shinyjs)
library(gotop) #https://rdrr.io/cran/gotop/man/use_gotop.html
#library(htmlwidgets)
#library(fontawesome)

here()

#Loading functions ----
urlp <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"

shinyInput <- function(FUN, len, id, ...) {
  inputs <- character(len)
  for (i in seq_len(len)) {
    inputs[i] <- as.character(FUN(paste0(id, i), ...))
    }
  inputs
}

# Loading data ----
pub<- readRDS(here("data","processed","pub.rds"))

prj <- readRDS(here("data","processed","prj_2022.rds"))

ric <- read_excel(here("data","raw","ricercatori_test.xlsx"))

centri_ref <- read_excel(here("data","raw","centri_referenza.xlsx"))

news <- read_excel(here("data","raw","news_izsler.xlsx"))



#PUBBLICAZIONI----
pubs <- pub %>% 
  mutate(articoliif = ifelse(Congr == "IF ; Int" | Congr == "IF",  "IF", NA), 
         INT = ifelse(Congr == "IF ; Int" | Congr == "Int",  "Int", NA ), 
         NAZ = ifelse(Congr == "Naz", "Naz", NA), 
         Oth = ifelse(Congr == "Others" , "Others", NA), 
         IF = as.numeric(IF)) 

paper3 <- pubs %>%
  select(Nome, Cognome, Anno = OA, Autori = CAU , Titolo = "TI-INGLESE", Journal = datoBibl, IF) %>%
  unique() %>%
  mutate(Cognome = str_to_title(Cognome),
         Nome = str_to_title(Nome),
         link = str_extract(Journal, urlp),
         link = paste0("<a href='",link,"'target='_blank'","title='",link,"'>","<i class='fa fa-external-link' style='font-size:24px; color:#375a7f'></i>","</a>"),
         link2 = paste0("<a href='",str_extract(Journal, urlp),"'target='_blank","'>",str_extract(Journal, urlp),"</a>"),
         IF = format(round(IF, 3), nsmall = 3)) %>%
  arrange(desc(Anno), desc(IF))

paper3$pubblicazioni <- ifelse(str_detect(paper3$Journal, "http"),
                            paste0("<b>",
                            paper3$Titolo,
                            "</b><br>",
                            paper3$Autori,
                            "<br>",
                            str_extract(paper3$Journal, ".+?(?= http[s]?)"),
                            "<br>",
                            paper3$link2),
                            paste0("<b>",
                            paper3$Titolo,
                            "</b><br>",
                            paper3$Autori,
                            "<br>",
                            paper3$Journal,
                            "<br>"))

#PROGETTI DI RICERCA----
prj_UO <- prj %>%
  mutate(nome_RespScientUO = str_to_title(NomeRSUO),
         cognome_RespScientUO = str_to_title(CognomeRSUO),
         RS_UO = paste(nome_RespScientUO, cognome_RespScientUO),
         nuove_strutture = replace_na(nuove_strutture, "da definire"),
         new_col_strutture = paste0(nuove_strutture," - Responsabile: ", RS_UO)) %>% 
  group_by(CodIDIzsler) %>% 
  summarise(uo_coinvolte = paste(new_col_strutture, collapse = "<br>")) %>% 
  ungroup()

prj <- prj %>%
  left_join(prj_UO, by = c("CodIDIzsler" = "CodIDIzsler"))

prj <- prj %>%
  mutate(DataInizio = make_date(anno_Inizio, mese_Inizio, giorno_Inizio),
         DataFine = make_date(anno_Fine, mese_Fine, giorno_Fine),
         Stato = ifelse(anno_Fine < 2022, "tutti - concluso", "tutti - in corso"),
         STATO_PRJ = ifelse(anno_Fine < 2022, "Concluso", "In corso"),
         DataInizio_slash = format(DataInizio, "%d/%m/%Y"),
         DataFine_slash = format(DataFine, "%d/%m/%Y"),
         nome_RespScientUO = str_to_title(NomeRSUO),
         cognome_RespScientUO = str_to_title(CognomeRSUO),
         RS_UO = paste(nome_RespScientUO, cognome_RespScientUO), 
         RS = paste(nome_RespScientifico, cognome_RespScientifico),
         #nuove_strutture = replace_na(nuove_strutture, " "),
         new_col_strutture = paste0(nuove_strutture," - Responsabile: ", RS_UO),
         Budget = round(BudgetTotale,0))

df_prj <- prj[!duplicated(prj[,c("CodIDIzsler","RS")]),]

df_prj$view <- shinyInput(actionButton,
                          nrow(df_prj),
                          'button_',
                          class = "btn btn-light btn-sm",
                          style = "color: #375a7f; background-color: transparent !important; border-color: transparent !important; padding-left: 0px; padding-right: 0px; padding-top: 0px; padding-bottom: 0px;", #color: #fff; background-color: #337ab7; border-color: #2e6da4
                          label = tags$div(HTML("<i class=\"fa fa-info-circle fa-2x\"></i>")),
                          onclick = paste0('Shiny.setInputValue(\"select_button_prj\",  this.id.concat(\"_\", Math.random()))')
                          )


#RICERCATORI----
boxricer <- ric %>%
  mutate(email_2 = str_replace(email, email, sprintf('<a href="mailto:%s">%s</a>',  email, email))) %>%
  mutate(AU = paste0(Nome," ", Cognome)) %>%
  mutate(foto = paste0(Nome," ",Cognome,".jpg")) %>%
  arrange(Cognome)

research_df_table <- boxricer %>%
  select(AU, Nome, Cognome, Titolo, Dipartimento, Reparto, Laboratorio, email, telefono, image_ext, email_2, foto, picture)
  
research_df_table$picture[research_df_table$picture == "no"] <- paste0('<img class="profile-table-img" src="no_picture.png"></img>')

research_df_table$picture <- str_replace(research_df_table$picture, "si",
                                         sprintf('<img class="profile-table-img" src="foto_profilo/%s_%s.%s"></img>',
                                                 paste(research_df_table$Cognome),
                                                 paste(research_df_table$Nome),
                                                 paste(research_df_table$image_ext)
                                                 )
                                         )
  
research_df_table$ricercatore <- paste0("<b>",
                                        research_df_table$Nome,
                                        " ",
                                        research_df_table$Cognome,
                                        "</b><br>",
                                        '<div class = "table-sub-title">',
                                        research_df_table$Titolo,
                                        "</div>")
  
research_df_table$email <- str_replace(research_df_table$email, research_df_table$email, sprintf('<a href="mailto:%s">%s</a>', research_df_table$email, research_df_table$email))



research_df_table_lom <- research_df_table %>%
  filter(str_detect(Dipartimento,"Lombardia"))

research_df_table_lom$view <- shinyInput(actionButton,
                                     nrow(research_df_table_lom),
                                     'button_',
                                     class = "btn btn-light btn-sm",
                                     style = "color: #fff; background-color: #375a7f; border-color: #375a7f", #color: #fff; background-color: #337ab7; border-color: #2e6da4
                                     label = tags$div(HTML("<i class=\"fa fa-book fa-2x\"></i>")),
                                     onclick = paste0('Shiny.setInputValue(\"select_button_lom\",  this.id.concat(\"_\", Math.random()))')
                                     )


research_df_table_emi <- research_df_table %>%
  filter(str_detect(Dipartimento,"Emilia"))

research_df_table_emi$view <- shinyInput(actionButton,
                                     nrow(research_df_table_emi),
                                     'button_',
                                     class = "btn btn-light btn-sm",
                                     style = "color: #fff; background-color: #375a7f; border-color: #375a7f", #color: #fff; background-color: #337ab7; border-color: #2e6da4
                                     label = tags$div(HTML("<i class=\"fa fa-book fa-2x\"></i>")),
                                     onclick = paste0('Shiny.setInputValue(\"select_button_emi\",  this.id.concat(\"_\", Math.random()))')
                                     )

research_df_table_tut <- research_df_table %>%
  filter(str_detect(Dipartimento,"Tutela"))

research_df_table_tut$view <- shinyInput(actionButton,
                                     nrow(research_df_table_tut),
                                     'button_',
                                     class = "btn btn-light btn-sm",
                                     style = "color: #fff; background-color: #375a7f; border-color: #375a7f", #color: #fff; background-color: #337ab7; border-color: #2e6da4
                                     label = tags$div(HTML("<i class=\"fa fa-book fa-2x\"></i>")),
                                     onclick = paste0('Shiny.setInputValue(\"select_button_tut\",  this.id.concat(\"_\", Math.random()))')
                                     )

research_df_table_sic <- research_df_table %>%
  filter(str_detect(Dipartimento,"Sicurezza"))

research_df_table_sic$view <- shinyInput(actionButton,
                                     nrow(research_df_table_sic),
                                     'button_',
                                     class = "btn btn-light btn-sm",
                                     style = "color: #fff; background-color: #375a7f; border-color: #375a7f", #color: #fff; background-color: #337ab7; border-color: #2e6da4
                                     label = tags$div(HTML("<i class=\"fa fa-book fa-2x\"></i>")),
                                     onclick = paste0('Shiny.setInputValue(\"select_button_sic\",  this.id.concat(\"_\", Math.random()))')
                                     )


research_df_table_all <- research_df_table

research_df_table_all$view <- shinyInput(actionButton,
                                     nrow(research_df_table_all),
                                     'button_',
                                     class = "btn btn-light btn-sm",
                                     style = "color: #fff; background-color: #375a7f; border-color: #375a7f", #color: #fff; background-color: #337ab7; border-color: #2e6da4
                                     label = tags$div(HTML("<i class=\"fa fa-book fa-2x\"></i>")),
                                     onclick = paste0('Shiny.setInputValue(\"select_button_all\",  this.id.concat(\"_\", Math.random()))')
                                     )


# #Write JavaScript to select the HTML elements and change their CSS
# callbackDT <- c(
#   "$('#DataTables_Table_0_filter input').css('background-color', 'lightsteelblue');"
# )


# “Portale della Ricerca” in cui saranno integrate tutte le informazioni che caratterizzano la ricerca in IZSLER:
# progetti di ricerca,
# attività dei centri di referenza,
# pagine personali dei ricercatori,
# partecipazioni a convegni nazionali e internazionali,
# pubblicazioni,
# indici bibliometrici,
# prodotti della ricerca quali linee guida, metodi di prova, reagenti e diagnostici, vaccini, ecc.
# Questo per garantire condivisione delle informazioni fra i ricercatori e fornire uno strumento di monitoraggio delle attività alla Direzione.























