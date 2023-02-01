server <- 
   function(input, output, session) {

     
     
# 1. HOME - NEWS ----
df_news <- news %>%
  select(img, type, title, link, dd, dm , dy) %>% 
  arrange(desc(dy), desc(dm), desc(dd))
  
df_news$picture <- sprintf('<img class="profile-table-img" src="%s"></img>',
                                                 paste(df_news$img))

df_news$titolo <- paste0("<b>",
                         "<a href=",
                         df_news$link,
                         " target='_blank'>",
                         df_news$title,
                         "</a></b><br>",
                         '<div class = "table-sub-title">',
                         df_news$type,
                         " - ",
                         df_news$dd,"/",df_news$dm,"/",df_news$dy,
                         "</div>")
  

output$dttable_news <- DT::renderDataTable(server = FALSE, {
  
  table_dt_news <- df_news %>%
    select(titolo)

  table_news <- DT::datatable(
    table_dt_news,
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "T",
                   autoWidth = FALSE
                   #se inserisci picture come prima colonna in select:
                   # columnDefs = list(
                   #   list(className = 'dt-center', targets = c(0)),
                   #   list(width = '50px', targets = c(0))
                   #   )
))
    
})     
     
# 2. DIPARTIMENTI----

# # per cambiare scheda da pagina iniziale dipartimenti a pagina dipartimento lombardia
# # per hidden vedi: https://stackoverflow.com/questions/48210709/show-content-for-menuitem-when-menusubitems-exist-in-shiny-dashboard
# observeEvent(input$sidebarItemExpanded, {
#   if(input$sidebarItemExpanded == "DIPARTIMENTI"){
#     updateTabItems(session, "sidebar", selected = "hiddenDipartimenti")
#     }
#   })

onclick('btn_dip_lombardia', updateTabItems(session, "sidebar", selected = "dt_lombardia"))
onclick('btn_dip_emilia', updateTabItems(session, "sidebar", selected = "dt_emilia"))
onclick('btn_dip_tutela', updateTabItems(session, "sidebar", selected = "dt_tutela"))
onclick('btn_dip_sicurezza', updateTabItems(session, "sidebar", selected = "dt_sicurezza"))


# observeEvent(input$btn_dip_emilia, {
#   updateTabItems(session, "sidebar", selected = "dt_emilia")
#   })



##INFO_DIP----

#https://stackoverflow.com/questions/43733614/align-3-divs-horizontally-with-their-icons
#https://stackoverflow.com/questions/69414391/how-to-align-icon-number-and-text-in-a-column
output$info_dip_ric_lom <-  renderUI({
  boxricer %>% 
    filter(str_detect(Dipartimento, "Lombardia")) %>% 
    count()
})

output$info_dip_pub_lom <-  renderUI({
  pubs %>%
  select(Nome, Cognome, Anno = OA, Autori = CAU , Titolo = "TI-INGLESE", Journal = datoBibl, IF, Dipartimento) %>%
    filter(str_detect(Dipartimento, "LOMBARDIA")) %>%
    filter(Anno == "2021") %>% 
    distinct(Titolo) %>%
    count()
})

output$info_dip_prj_lom <-  renderUI({
  prj %>%
    filter(Stato == "tutti - in corso",
           str_detect(dipartimenti, "Lombardia")) %>%
    count()
})




output$info_dip_ric_emi <-  renderUI({
  boxricer %>% 
    filter(str_detect(Dipartimento, "Emilia")) %>% 
    count()
})

output$info_dip_pub_emi <-  renderUI({
  pubs %>%
  select(Nome, Cognome, Anno = OA, Autori = CAU , Titolo = "TI-INGLESE", Journal = datoBibl, IF, Dipartimento) %>%
    filter(str_detect(Dipartimento, "EMILIA")) %>%
    filter(Anno == "2021") %>% 
    distinct(Titolo) %>%
    count()
})

output$info_dip_prj_emi <-  renderUI({
  prj %>%
    filter(Stato == "tutti - in corso",
           str_detect(dipartimenti, "Emilia")) %>%
    count()})




output$info_dip_ric_tut <-  renderUI({
  boxricer %>% 
    filter(str_detect(Dipartimento, "Tutela")) %>% 
    count()
})

output$info_dip_pub_tut <-  renderUI({
  pubs %>%
  select(Nome, Cognome, Anno = OA, Autori = CAU , Titolo = "TI-INGLESE", Journal = datoBibl, IF, Dipartimento) %>%
    filter(str_detect(Dipartimento, "TUTELA")) %>%
    filter(Anno == "2021") %>% 
    distinct(Titolo) %>%
    count()
})

output$info_dip_prj_tut <-  renderUI({
  prj %>%
    filter(Stato == "tutti - in corso",
           str_detect(dipartimenti, "Tutela")) %>%
    count()})




output$info_dip_ric_sic <-  renderUI({
  boxricer %>% 
    filter(str_detect(Dipartimento, "Sicurezza")) %>% 
    count()
})

output$info_dip_pub_sic <-  renderUI({
  pubs %>%
  select(Nome, Cognome, Anno = OA, Autori = CAU , Titolo = "TI-INGLESE", Journal = datoBibl, IF, Dipartimento) %>%
    filter(str_detect(Dipartimento, "SICUREZZA")) %>%
    filter(Anno == "2021") %>% 
    distinct(Titolo) %>%
    count()
})

output$info_dip_prj_sic <-  renderUI({
  prj %>%
    filter(Stato == "tutti - in corso",
           str_detect(dipartimenti, "Sicurezza")) %>%
    count()
})





###DATATABLE_OUTPUT----

DTproxy_lom <- dataTableProxy("research_table_lom") #a proxy object that can be used to manipulate an existing DataTables instance in a Shiny app, e.g. select rows/columns, or add rows.
observeEvent(input$search_field_lom, {
  updateSearch(DTproxy_lom,
               keywords = list(global = input$search_field_lom, columns = NULL))
  })

DTproxy_emi <- dataTableProxy("research_table_emi") #a proxy object that can be used to manipulate an existing DataTables instance in a Shiny app, e.g. select rows/columns, or add rows.
observeEvent(input$search_field_emi, {
  updateSearch(DTproxy_emi,
               keywords = list(global = input$search_field_emi, columns = NULL))
  })

DTproxy_tut <- dataTableProxy("research_table_tut") #a proxy object that can be used to manipulate an existing DataTables instance in a Shiny app, e.g. select rows/columns, or add rows.
observeEvent(input$search_field_tut, {
  updateSearch(DTproxy_tut,
               keywords = list(global = input$search_field_tut, columns = NULL))
  })

DTproxy_sic <- dataTableProxy("research_table_sic") #a proxy object that can be used to manipulate an existing DataTables instance in a Shiny app, e.g. select rows/columns, or add rows.
observeEvent(input$search_field_sic, {
  updateSearch(DTproxy_sic,
               keywords = list(global = input$search_field_sic, columns = NULL))
  })
  

  
####OUTPUT LOMBARDIA----
output$research_table_lom <- DT::renderDataTable(server = FALSE, {
  
  research_df_table_lom %>% 
  select(Cognome, picture, ricercatore, Dipartimento, Reparto, view, telefono, email, Nome) %>%
  DT::datatable(
    colnames = c("Cognome", " ", "Ricercatore", "Dipartimento", "Reparto", "Pubblicazioni", "Telefono", "Email", "Nome"),
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "ft",
                   searching = TRUE, 
                   pageLength = 100,
                   lengthChange = FALSE,
                   autoWidth = FALSE,
                   columnDefs = list(
                     list(orderData = 0, targets = 2),
                     list(visible = FALSE, targets = c(0, 8)),
                     list(width = '60px', targets =c(1)),
                     list(width = '250px', targets =c(2)),
                     list(width = '120px', targets =c(3)),
                     list(width = '120px', targets =c(4)),
                     list(width = '90px', targets =c(5)),
                     list(width = '90px', targets =c(6)),
                     list(width = '180px', targets =c(7)),
                     list(className = 'dt-center', targets = c(1, 5))
                     ),
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});",
                     "}"),
                     language = list(zeroRecords = "Nessuna corrispondenza trovata")
                   )
    )
})


observeEvent(input$select_button_lom, {
  selectedRow <- as.numeric(strsplit(input$select_button_lom, "_")[[1]][2])
  
  showModal(tags$div(id="MODAL_PUB_LOM", # tags$div per inserire id e modificare css richiamando datatables https://stackoverflow.com/questions/46830173/tagsstyle-specific-modaldialog-element-in-shiny
                     modalDialog(
                       h3(paste(research_df_table_lom$Nome[selectedRow],research_df_table_lom$Cognome[selectedRow])), # HTML("se vuoi scrivere a capo<br>prova questo")
                       size = "l",
                       footer = NULL,
                       easyClose = TRUE,
                       DT::dataTableOutput(
                         paste0("filtered_lom", selectedRow)
                         )
                       )
                     )
            )
                 
output[[paste0("filtered_lom", selectedRow)]] <- DT::renderDataTable(server = FALSE, {
  
  paper3 %>%
    filter(Cognome %in% research_df_table_lom$Cognome[selectedRow], Nome %in% research_df_table_lom$Nome[selectedRow]) %>% 
    select(Anno, pubblicazioni, IF, Autori, Titolo, Journal) %>%
    DT::datatable(
    colnames = c("Anno", "Pubblicazioni IZSLER", "IF", "Autori", "Titolo", "Journal"),
    class = 'cell-border compact',
    rownames = FALSE,
    escape = FALSE, #per leggere entità html
    selection = "none",
    extensions = "Buttons",
   callback = JS("$('#DataTables_Table_1_filter input').css('background-color', '#375a7f');
                  $('#DataTables_Table_1_filter input').css('color', '#fff');
                  $('#DataTables_Table_1_filter').css('font-weight', '500');

                  $('#DataTables_Table_1_info').css('font-weight', '500');
   
                  $('#DataTables_Table_1_paginate').css('font-weight', '500');

                  $('button.buttons-excel').css('background','#375a7f');
                  $('button.buttons-excel').css('color','#fff')"
                 ),
   
   options = list(dom = "iptB",   #iptB se vuoi bottone excel
                  pageLength = 5,
                  paging = TRUE,
                  autoWidth = FALSE,
                  buttons = list(
                       list(extend = "excel", text = "Scarica pubblicazioni", filename = "pubblicazioni", title = "IZSLER - Pubblicazioni", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "all"),
                              columns = c(0, 3, 4, 5, 2)))
                       ),
                 #https://datatables.net/reference/option/columnDefs
                 #https://datatables.net/manual/styling/classes
                     columnDefs = (list(
                                   list(visible = FALSE, targets = c(3, 4, 5)),
                                   list(width = '35px', targets =c(0)),
                                   list(width = '30px', targets =c(2)),
                                   list(className = 'dt-center', targets = c(0, 2)),
                                   list(className = 'dt-head-center', targets = "_all")
                                   )),
                              
                              #prima body e poi head!!!
                              # columnDefs = list(list(className = 'dt-body-center', targets = c(0,4,5)),
                              #                   list(className = 'dt-head-center', targets = c(0,1,2,3,4,5)) #"_all"
                              #                  ),
                 initComplete = htmlwidgets::JS(
                   "function(settings, json) {",
                   paste0("$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});"),
                   paste0("$(this.api().table().container()).css({'font-size': '90%'});"),
                   "}"),
                 language = list(search = "Cerca: ",
                                 paginate = list(previous = "Precedente", `next` = "Successiva"),
                                 info = "_START_ - _END_ di _TOTAL_ pubblicazioni",
                                 infoFiltered = "(su un totale di _MAX_ pubblicazioni)",
                                 infoEmpty = "Nessuna pubblicazione disponibile",
                                 zeroRecords = "- Nessuna pubblicazione disponibile -")
   )
  )
})
})

####OUTPUT EMILIA----
output$research_table_emi <- DT::renderDataTable(server = FALSE, {

  research_df_table_emi %>%
  select(Cognome, picture, ricercatore, Dipartimento, Reparto, view, telefono, email, Nome) %>%
  DT::datatable(
    colnames = c("Cognome", " ", "Ricercatore", "Dipartimento", "Reparto", "Pubblicazioni", "Telefono", "Email", "Nome"),
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "ft",
                   searching = TRUE,
                   pageLength = 100,
                   lengthChange = FALSE,
                   autoWidth = FALSE,
                   columnDefs = list(
                     list(orderData = 0, targets = 2),
                     list(visible = FALSE, targets = c(0, 8)),
                     list(width = '60px', targets =c(1)),
                     list(width = '250px', targets =c(2)),
                     list(width = '120px', targets =c(3)),
                     list(width = '120px', targets =c(4)),
                     list(width = '90px', targets =c(5)),
                     list(width = '90px', targets =c(6)),
                     list(width = '180px', targets =c(7)),
                     list(className = 'dt-center', targets = c(1, 5))
                     ),
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});",
                     "}"),
                     language = list(zeroRecords = "Nessuna corrispondenza trovata")
                   )
    )
})


observeEvent(input$select_button_emi, {
  selectedRow <- as.numeric(strsplit(input$select_button_emi, "_")[[1]][2])

  showModal(tags$div(id="MODAL_PUB_EMI", # tags$div per inserire id e modificare css richiamando datatables https://stackoverflow.com/questions/46830173/tagsstyle-specific-modaldialog-element-in-shiny
                     modalDialog(
                       h3(paste(research_df_table_emi$Nome[selectedRow],research_df_table_emi$Cognome[selectedRow])), # HTML("se vuoi scrivere a capo<br>prova questo")
                       size = "l",
                       footer = NULL,
                       easyClose = TRUE,
                       DT::dataTableOutput(
                         paste0("filtered_emi", selectedRow)
                         )
                       )
                     )
            )

output[[paste0("filtered_emi", selectedRow)]] <- DT::renderDataTable(server = FALSE, {

  filtered_emi <- paper3 %>%
    filter(Cognome %in% research_df_table_emi$Cognome[selectedRow], Nome %in% research_df_table_emi$Nome[selectedRow]) %>% 
    select(Anno, pubblicazioni, IF, Autori, Titolo, Journal) %>%
    DT::datatable(
    colnames = c("Anno", "Pubblicazioni IZSLER", "IF", "Autori", "Titolo", "Journal"),
    class = 'cell-border compact',
    rownames = FALSE,
    escape = FALSE, #per leggere entità html
    selection = "none",
   extensions = "Buttons",
   callback = JS("$('#DataTables_Table_1_filter input').css('background-color', '#375a7f');
                  $('#DataTables_Table_1_filter input').css('color', '#fff');
                  $('#DataTables_Table_1_filter').css('font-weight', '500');

                  $('#DataTables_Table_1_info').css('font-weight', '500');

                  $('#DataTables_Table_1_paginate').css('font-weight', '500');

                  $('button.buttons-excel').css('background','#375a7f');
                  $('button.buttons-excel').css('color','#fff')"
                 ),

   options = list(dom = "iptB",   #iptB se vuoi bottone excel
                  pageLength = 5,
                  paging = TRUE,
                  autoWidth = FALSE,
                  buttons = list(
                       list(extend = "excel", text = "Scarica pubblicazioni", filename = "pubblicazioni", title = "IZSLER - Pubblicazioni", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "all"),
                              columns = c(0, 3, 4, 5, 2)))
                       ),
                 #https://datatables.net/reference/option/columnDefs
                 #https://datatables.net/manual/styling/classes
                     columnDefs = (list(
                                   list(visible = FALSE, targets = c(3, 4, 5)),
                                   list(width = '35px', targets =c(0)),
                                   list(width = '30px', targets =c(2)),
                                   list(className = 'dt-center', targets = c(0, 2)),
                                   list(className = 'dt-head-center', targets = "_all")
                                   )),

                              #prima body e poi head!!!
                              # columnDefs = list(list(className = 'dt-body-center', targets = c(0,4,5)),
                              #                   list(className = 'dt-head-center', targets = c(0,1,2,3,4,5)) #"_all"
                              #                  ),
                 initComplete = htmlwidgets::JS(
                   "function(settings, json) {",
                   paste0("$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});"),
                   paste0("$(this.api().table().container()).css({'font-size': '90%'});"),
                   "}"),
                 language = list(search = "Cerca: ",
                                 paginate = list(previous = "Precedente", `next` = "Successiva"),
                                 info = "_START_ - _END_ di _TOTAL_ pubblicazioni",
                                 infoFiltered = "(su un totale di _MAX_ pubblicazioni)",
                                 infoEmpty = "Nessuna pubblicazione disponibile",
                                 zeroRecords = "- Nessuna pubblicazione disponibile -")
   )
  )
})
})


####OUTPUT TUTELA----
output$research_table_tut <- DT::renderDataTable(server = FALSE, {

  research_df_table_tut %>%
  select(Cognome, picture, ricercatore, Dipartimento, Reparto, view, telefono, email, Nome) %>%
  DT::datatable(
    colnames = c("Cognome", " ", "Ricercatore", "Dipartimento", "Reparto", "Pubblicazioni", "Telefono", "Email", "Nome"),
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "ft",
                   searching = TRUE,
                   pageLength = 100,
                   lengthChange = FALSE,
                   autoWidth = FALSE,
                   columnDefs = list(
                     list(orderData = 0, targets = 2),
                     list(visible = FALSE, targets = c(0, 8)),
                     list(width = '60px', targets =c(1)),
                     list(width = '250px', targets =c(2)),
                     list(width = '120px', targets =c(3)),
                     list(width = '120px', targets =c(4)),
                     list(width = '90px', targets =c(5)),
                     list(width = '90px', targets =c(6)),
                     list(width = '180px', targets =c(7)),
                     list(className = 'dt-center', targets = c(1, 5))
                     ),
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});",
                     "}"),
                     language = list(zeroRecords = "Nessuna corrispondenza trovata")
                   )
    )
})


observeEvent(input$select_button_tut, {
  selectedRow <- as.numeric(strsplit(input$select_button_tut, "_")[[1]][2])

  showModal(tags$div(id="MODAL_PUB", # tags$div per inserire id e modificare css richiamando datatables https://stackoverflow.com/questions/46830173/tagsstyle-specific-modaldialog-element-in-shiny
                     modalDialog(
                       h3(paste(research_df_table_tut$Nome[selectedRow],research_df_table_tut$Cognome[selectedRow])), # HTML("se vuoi scrivere a capo<br>prova questo")
                       size = "l",
                       footer = NULL,
                       easyClose = TRUE,
                       DT::dataTableOutput(
                         paste0("filtered_tut", selectedRow)
                         )
                       )
                     )
            )

output[[paste0("filtered_tut", selectedRow)]] <- DT::renderDataTable(server = FALSE, {

  filtered_tut <- paper3 %>%
    filter(Cognome %in% research_df_table_tut$Cognome[selectedRow], Nome %in% research_df_table_tut$Nome[selectedRow]) %>% 
    select(Anno, pubblicazioni, IF, Autori, Titolo, Journal) %>%
    DT::datatable(
    colnames = c("Anno", "Pubblicazioni IZSLER", "IF", "Autori", "Titolo", "Journal"),
    class = 'cell-border compact',
    rownames = FALSE,
    escape = FALSE, #per leggere entità html
    selection = "none",
   extensions = "Buttons",
   callback = JS("$('#DataTables_Table_1_filter input').css('background-color', '#375a7f');
                  $('#DataTables_Table_1_filter input').css('color', '#fff');
                  $('#DataTables_Table_1_filter').css('font-weight', '500');

                  $('#DataTables_Table_1_info').css('font-weight', '500');

                  $('#DataTables_Table_1_paginate').css('font-weight', '500');

                  $('button.buttons-excel').css('background','#375a7f');
                  $('button.buttons-excel').css('color','#fff')"
                 ),

   options = list(dom = "iptB",   #iptB se vuoi bottone excel
                  pageLength = 5,
                  paging = TRUE,
                  autoWidth = FALSE,
                  buttons = list(
                       list(extend = "excel", text = "Scarica pubblicazioni", filename = "pubblicazioni", title = "IZSLER - Pubblicazioni", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "all"),
                              columns = c(0, 3, 4, 5, 2)))
                       ),
                 #https://datatables.net/reference/option/columnDefs
                 #https://datatables.net/manual/styling/classes
                     columnDefs = (list(
                                   list(visible = FALSE, targets = c(3, 4, 5)),
                                   list(width = '35px', targets =c(0)),
                                   list(width = '30px', targets =c(2)),
                                   list(className = 'dt-center', targets = c(0, 2)),
                                   list(className = 'dt-head-center', targets = "_all")
                                   )),

                              #prima body e poi head!!!
                              # columnDefs = list(list(className = 'dt-body-center', targets = c(0,4,5)),
                              #                   list(className = 'dt-head-center', targets = c(0,1,2,3,4,5)) #"_all"
                              #                  ),
                 initComplete = htmlwidgets::JS(
                   "function(settings, json) {",
                   paste0("$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});"),
                   paste0("$(this.api().table().container()).css({'font-size': '90%'});"),
                   "}"),
                 language = list(search = "Cerca: ",
                                 paginate = list(previous = "Precedente", `next` = "Successiva"),
                                 info = "_START_ - _END_ di _TOTAL_ pubblicazioni",
                                 infoFiltered = "(su un totale di _MAX_ pubblicazioni)",
                                 infoEmpty = "Nessuna pubblicazione disponibile",
                                 zeroRecords = "- Nessuna pubblicazione disponibile -")
   )
  )
})
})


####OUTPUT SICUREZZA----
output$research_table_sic <- DT::renderDataTable(server = FALSE, {

  research_df_table_sic %>%
  select(Cognome, picture, ricercatore, Dipartimento, Reparto, view, telefono, email, Nome) %>%
  DT::datatable(
    colnames = c("Cognome", " ", "Ricercatore", "Dipartimento", "Reparto", "Pubblicazioni", "Telefono", "Email", "Nome"),
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "ft",
                   searching = TRUE,
                   pageLength = 100,
                   lengthChange = FALSE,
                   autoWidth = FALSE,
                   columnDefs = list(
                     list(orderData = 0, targets = 2),
                     list(visible = FALSE, targets = c(0, 8)),
                     list(width = '60px', targets =c(1)),
                     list(width = '250px', targets =c(2)),
                     list(width = '120px', targets =c(3)),
                     list(width = '120px', targets =c(4)),
                     list(width = '90px', targets =c(5)),
                     list(width = '90px', targets =c(6)),
                     list(width = '180px', targets =c(7)),
                     list(className = 'dt-center', targets = c(1, 5))
                     ),
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});",
                     "}"),
                     language = list(zeroRecords = "Nessuna corrispondenza trovata")
                   )
    )
})


observeEvent(input$select_button_sic, {
  selectedRow <- as.numeric(strsplit(input$select_button_sic, "_")[[1]][2])

  showModal(tags$div(id="MODAL_PUB", # tags$div per inserire id e modificare css richiamando datatables https://stackoverflow.com/questions/46830173/tagsstyle-specific-modaldialog-element-in-shiny
                     modalDialog(
                       h3(paste(research_df_table_sic$Nome[selectedRow],research_df_table_sic$Cognome[selectedRow])), # HTML("se vuoi scrivere a capo<br>prova questo")
                       size = "l",
                       footer = NULL,
                       easyClose = TRUE,
                       DT::dataTableOutput(
                         paste0("filtered_sic", selectedRow)
                         )
                       )
                     )
            )

output[[paste0("filtered_sic", selectedRow)]] <- DT::renderDataTable(server = FALSE, {

  filtered_sic <- paper3 %>%
    filter(Cognome %in% research_df_table_sic$Cognome[selectedRow], Nome %in% research_df_table_sic$Nome[selectedRow]) %>% 
    select(Anno, pubblicazioni, IF, Autori, Titolo, Journal) %>%
    DT::datatable(
    colnames = c("Anno", "Pubblicazioni IZSLER", "IF", "Autori", "Titolo", "Journal"),
    class = 'cell-border compact',
    rownames = FALSE,
    escape = FALSE, #per leggere entità html
    selection = "none",
   extensions = "Buttons",
   callback = JS("$('#DataTables_Table_1_filter input').css('background-color', '#375a7f');
                  $('#DataTables_Table_1_filter input').css('color', '#fff');
                  $('#DataTables_Table_1_filter').css('font-weight', '500');

                  $('#DataTables_Table_1_info').css('font-weight', '500');

                  $('#DataTables_Table_1_paginate').css('font-weight', '500');

                  $('button.buttons-excel').css('background','#375a7f');
                  $('button.buttons-excel').css('color','#fff')"
                 ),

   options = list(dom = "iptB",   #iptB se vuoi bottone excel
                  pageLength = 5,
                  paging = TRUE,
                  autoWidth = FALSE,
                  buttons = list(
                       list(extend = "excel", text = "Scarica pubblicazioni", filename = "pubblicazioni", title = "IZSLER - Pubblicazioni", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "all"),
                              columns = c(0, 3, 4, 5, 2)))
                       ),
                 #https://datatables.net/reference/option/columnDefs
                 #https://datatables.net/manual/styling/classes
                     columnDefs = (list(
                                   list(visible = FALSE, targets = c(3, 4, 5)),
                                   list(width = '35px', targets =c(0)),
                                   list(width = '30px', targets =c(2)),
                                   list(className = 'dt-center', targets = c(0, 2)),
                                   list(className = 'dt-head-center', targets = "_all")
                                   )),

                              #prima body e poi head!!!
                              # columnDefs = list(list(className = 'dt-body-center', targets = c(0,4,5)),
                              #                   list(className = 'dt-head-center', targets = c(0,1,2,3,4,5)) #"_all"
                              #                  ),
                 initComplete = htmlwidgets::JS(
                   "function(settings, json) {",
                   paste0("$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});"),
                   paste0("$(this.api().table().container()).css({'font-size': '90%'});"),
                   "}"),
                 language = list(search = "Cerca: ",
                                 paginate = list(previous = "Precedente", `next` = "Successiva"),
                                 info = "_START_ - _END_ di _TOTAL_ pubblicazioni",
                                 infoFiltered = "(su un totale di _MAX_ pubblicazioni)",
                                 infoEmpty = "Nessuna pubblicazione disponibile",
                                 zeroRecords = "- Nessuna pubblicazione disponibile -")
   )
  )
})
})

#3. RICERCATORI ----
DTproxy_all <- dataTableProxy("research_table_all") #a proxy object that can be used to manipulate an existing DataTables instance in a Shiny app, e.g. select rows/columns, or add rows.
observeEvent(input$search_field_all, {
  updateSearch(DTproxy_all,
               keywords = list(global = input$search_field_all, columns = NULL))
  })

output$research_table_all <- DT::renderDataTable(server = FALSE, {
  
  research_df_table_all %>%
  select(Cognome, picture, ricercatore, Dipartimento, Reparto, view, telefono, email, Nome) %>%
  DT::datatable(
    colnames = c("Cognome", " ", "Ricercatore", "Dipartimento", "Reparto", "Pubblicazioni", "Telefono", "Email", "Nome"),
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "ft",
                   searching = TRUE,
                   pageLength = 100,
                   lengthChange = FALSE,
                   autoWidth = FALSE,
                   columnDefs = list(
                     list(orderData = 0, targets = 2),
                     list(visible = FALSE, targets = c(0, 8)),
                     list(width = '60px', targets =c(1)),
                     list(width = '250px', targets =c(2)),
                     list(width = '120px', targets =c(3)),
                     list(width = '120px', targets =c(4)),
                     list(width = '90px', targets =c(5)),
                     list(width = '90px', targets =c(6)),
                     list(width = '180px', targets =c(7)),
                     list(className = 'dt-center', targets = c(1, 5))
                     ),
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});",
                     "}"),
                     language = list(zeroRecords = "Nessuna corrispondenza trovata")
                   )
    )
})


observeEvent(input$select_button_all, {
  selectedRow <- as.numeric(strsplit(input$select_button_all, "_")[[1]][2])
  
  showModal(tags$div(id="MODAL_PUB_ALL", # tags$div per inserire id e modificare css richiamando datatables https://stackoverflow.com/questions/46830173/tagsstyle-specific-modaldialog-element-in-shiny
                     modalDialog(
                       h3(paste(research_df_table_all$Nome[selectedRow],research_df_table_all$Cognome[selectedRow])), # HTML("se vuoi scrivere a capo<br>prova questo")
                       size = "l",
                       footer = NULL,
                       easyClose = TRUE,
                       DT::dataTableOutput(
                         paste0("filtered_all", selectedRow)
                         )
                       )
                     )
            )
                 
output[[paste0("filtered_all", selectedRow)]] <- DT::renderDataTable(server = FALSE, {
  
  paper3 %>%
    filter(Cognome %in% research_df_table_all$Cognome[selectedRow], Nome %in% research_df_table_all$Nome[selectedRow]) %>% 
    select(Anno, pubblicazioni, IF, Autori, Titolo, Journal) %>%
    unique() %>%
    
    DT::datatable(
    colnames = c("Anno", "Pubblicazioni IZSLER", "IF", "Autori", "Titolo", "Journal"),
    class = 'cell-border compact',
    rownames = FALSE,
    escape = FALSE, #per leggere entità html
    selection = "none",
    extensions = "Buttons",
   callback = JS("$('#DataTables_Table_1_filter input').css('background-color', '#375a7f');
                  $('#DataTables_Table_1_filter input').css('color', '#fff');
                  $('#DataTables_Table_1_filter').css('font-weight', '500');

                  $('#DataTables_Table_1_info').css('font-weight', '500');
   
                  $('#DataTables_Table_1_paginate').css('font-weight', '500');

                  $('button.buttons-excel').css('background','#375a7f');
                  $('button.buttons-excel').css('color','#fff')"
                 ),
   
   options = list(dom = "iptB",   #iptB se vuoi bottone excel
                  pageLength = 5,
                  paging = TRUE,
                  autoWidth = FALSE,
                  buttons = list(
                       list(extend = "excel", text = "Scarica pubblicazioni", filename = "pubblicazioni", title = "IZSLER - Pubblicazioni", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "all"),
                              columns = c(0, 3, 4, 5, 2)))
                       ),
                 #https://datatables.net/reference/option/columnDefs
                 #https://datatables.net/manual/styling/classes
                     columnDefs = (list(
                                   list(visible = FALSE, targets = c(3, 4, 5)),
                                   list(width = '35px', targets =c(0)),
                                   list(width = '30px', targets =c(2)),
                                   list(className = 'dt-center', targets = c(0, 2)),
                                   list(className = 'dt-head-center', targets = "_all")
                                   )),

                              
                              #prima body e poi head!!!
                              # columnDefs = list(list(className = 'dt-body-center', targets = c(0,4,5)),
                              #                   list(className = 'dt-head-center', targets = c(0,1,2,3,4,5)) #"_all"
                              #                  ),
                 initComplete = htmlwidgets::JS(
                   "function(settings, json) {",
                   paste0("$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});"),
                   paste0("$(this.api().table().container()).css({'font-size': '90%'});"),
                   "}"),
                 language = list(search = "Cerca: ",
                                 paginate = list(previous = "Precedente", `next` = "Successiva"),
                                 info = "_START_ - _END_ di _TOTAL_ pubblicazioni",
                                 infoFiltered = "(su un totale di _MAX_ pubblicazioni)",
                                 infoEmpty = "Nessuna pubblicazione disponibile",
                                 zeroRecords = "- Nessuna pubblicazione disponibile -")
   )
  )
})
})

#4. PUBBLICAZIONI ----
DTproxy_pubbl <- dataTableProxy("pubbl") #a proxy object that can be used to manipulate an existing DataTables instance in a Shiny app, e.g. select rows/columns, or add rows.
observeEvent(input$search_field_pubbl, {
  updateSearch(DTproxy_pubbl,
               keywords = list(global = input$search_field_pubbl, columns = NULL))
  })     

output$pubbl <- DT::renderDataTable(server = FALSE, {

  paper3 %>%
    select(Anno, pubblicazioni, IF, Titolo, Autori, Journal, link2) %>%
    unique() %>%
    DT::datatable(
      colnames = c("Anno", "Pubblicazioni IZSLER", "IF", "Titolo", "Autori", "Journal", "DOI"),
      class = 'cell-border compact',
      rownames = FALSE,
      escape = FALSE,
      selection = "none",
      extensions = "Buttons",
      #per applicare una funzione di callback in JavaScript
      callback = JS("$('#DataTables_Table_1_filter input').css('background-color', '#375a7f');
                     $('#DataTables_Table_1_filter input').css('color', '#fff');
                     $('#DataTables_Table_1_filter').css('font-weight', '500');

                     $('#DataTables_Table_1_info').css('font-weight', '500');
                     
                     $('#DataTables_Table_1_paginate').css('font-weight', '500');
 
                     $('button.buttons-excel').css('background','#375a7f');
                     $('button.buttons-excel').css('color','#fff')"),
      options = list(dom = "ilftBp",
                     pageLength = 10,
                     searching = TRUE,
                     autoWidth = FALSE,
                     buttons = list(
                       list(extend = "excel", text = "Scarica Tutto", filename = "pubblicazioni", title = "IZSLER - Pubblicazioni", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "all"),
                              columns = c(0,4,3,5,2,6))),
                       list(extend = "excel", text = "Scarica Selezione", filename = "pubblicazioni", title = "IZSLER - Pubblicazioni", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "current"),
                              columns = c(0,4,3,5,2,6)))
                       ),
                     # buttons = list(list(extend = 'collection',
                     #                     buttons = c('csv', 'excel', 'pdf'),
                     #                     text = 'Download')
                     #                ),
                     #https://datatables.net/reference/option/columnDefs
                     #https://datatables.net/manual/styling/classes
                     #prima body e poi head!!!
                     columnDefs = list(
                                  list(visible = FALSE, targets = c(3, 4, 5, 6)),
                                  list(width = '35px', targets =c(0)),
                                  list(width = '30px', targets =c(2)),
                                  list(className = 'dt-center', targets = c(0, 2)),
                                  list(className = 'dt-head-center', targets = "_all")
                                  ),
                     initComplete = JS(
                       "function(settings, json) {",
                       "$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});",
                       "}"),
                     language = list(search = "Cerca: ",
                                     paginate = list(previous = "Precedente", `next` = "Successiva"),
                                     info = "_START_ - _END_ di _TOTAL_ pubblicazioni",
                                     infoFiltered = "(su un totale di _MAX_ pubblicazioni)",
                                     infoEmpty = "Nessuna pubblicazione disponibile",
                                     zeroRecords = "- Nessuna pubblicazione disponibile -",
                                     lengthMenu = "Mostra _MENU_ pubblicazioni")))
})




# 5. PROGETTI DI RICERCA----
# Prj <- reactive({
#   prj %>%
#     group_by(CodIDIzsler, Tipologia, DataInizio, DataFine, Descrizione, RespScientifico, BudgetTotale, NumUOProgetto) %>%
#     count( ) %>%  
#     select(-n)  
# })

 #reactive df
# df_prj <- reactiveVal({prj})
#   #reactive df filtered
# df_showed_prj <- reactiveVal({})
#   
#   #create proxy dt once
#   
#   observeEvent(input$select_status_proj, {
#     #filter a row matching the internal id
#     df_showed_prj(df_prj() %>% filter(Stato==input$select_status_proj))
#     #render dt


# filtered_proj <- reactive({
#       rows <- (input$select_status_proj == "Tutti" | prj$Stato == input$select_status_proj)
#       prj[rows,,drop = FALSE]
#     })

#a proxy object that can be used to manipulate an existing DataTables instance in a Shiny app, e.g. select rows/columns, or add rows.
DTproxy_proj <- dataTableProxy("proj")  

observeEvent(input$search_field_proj, {
  updateSearch(DTproxy_proj,
               keywords = list(global = input$search_field_proj, columns = NULL))
  })

# research_df_table$view <- shinyInput(actionButton,
#                                      nrow(research_df_table),
#                                      'button_',
#                                      class = "btn btn-light btn-sm",
#                                      style = "color: #fff; background-color: #375a7f; border-color: #375a7f", #color: #fff; background-color: #337ab7; border-color: #2e6da4
#                                      label = tags$div(HTML("<i class=\"fa fa-book fa-2x\"></i>")),
#                                      onclick = paste0('Shiny.setInputValue(\"select_button\",  this.id.concat(\"_\", Math.random()))')
#                                      )

# df_prj <- prj %>%
#     group_by(CodIDIzsler, Tipologia, DataInizio, DataFine, DataInizio_slash, DataFine_slash, Descrizione, RespScientifico, Stato) %>%
#     count() %>%  
#     arrange(desc(DataInizio),desc(DataFine)) %>%
#     ungroup () %>% 
#     select(DataInizio, DataFine, DataInizio_slash, DataFine_slash, Descrizione, RespScientifico, Tipologia, Stato, CodIDIzsler)


#https://stackoverflow.com/questions/71173757/combining-selectinput-and-dtdatatable-editing-in-shiny
#https://stackoverflow.com/questions/38511717/how-do-i-get-the-data-from-the-selected-rows-of-a-filtered-datatable-dt
df_prj_selected_0 <- reactive({df_prj %>% 
    select(DataInizio, DataFine, DataInizio_slash, DataFine_slash, Descrizione, RS, Tipologia, Budget, view, Stato, CodIDIzsler)
})

df_prj_selected <- reactive({
      if (length(input$select_status_proj) != 0) {
        subset(df_prj_selected_0(), str_detect(Stato, input$select_status_proj))
        }
  else {
      TRUE
    }
})

output$proj <- DT::renderDataTable(server = FALSE, {
  DT::datatable(
    df_prj_selected(),
      colnames = c("Inizio_0","Fine_0","Inizio","Fine", "Titolo", "Responsabile Scientifico", "Tipologia", "Budget", "Info", "Stato", "CodIDIzsler"),
      class = 'cell-border compact',
      rownames = FALSE,
      escape = FALSE,
      selection = "none",
      extensions = "Buttons",
      #per applicare una funzione di callback in JavaScript
      callback = JS("$('#DataTables_Table_1_filter input').css('background-color', '#375a7f');
                     $('#DataTables_Table_1_filter input').css('color', '#fff');
                     $('#DataTables_Table_1_filter').css('font-weight', '500');

                     $('#DataTables_Table_1_info').css('font-weight', '500');
                     
                     $('#DataTables_Table_1_paginate').css('font-weight', '500');
 
                     $('button.buttons-excel').css('background','#375a7f');
                     $('button.buttons-excel').css('color','#fff')"),
      options = list(order = list(list(0, 'desc'), list(1, 'desc')),
                     dom = "ilftBp",
                     lengthMenu = list(c(10, 25, 50, 100, -1), c('10', '25','50','100','tutti')), #togli se non vuoi "tutti"
                     pageLength = 10, #10
                     searching = TRUE,
                     autoWidth = FALSE,
                     buttons = list(
                       list(extend = "excel", text = "Scarica Tutto", filename = "progetti_di_ricerca", title = "IZSLER - Progetti di ricerca", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "all"),
                              columns = c(10, 2, 3, 4, 5, 6, 7))),
                       list(extend = "excel", text = "Scarica Selezione", filename = "progetti_di_ricerca", title = "IZSLER - Progetti di ricerca", titleAttr = "Excel",
                            exportOptions = list(
                              modifier = list(page = "current"),
                              columns = c(10, 2, 3, 4, 5, 6, 7)))
                       ),
                     # buttons = list(list(extend = 'collection',
                     #                     buttons = c('csv', 'excel', 'pdf'),
                     #                     text = 'Download')
                     #                ),
                     #https://datatables.net/reference/option/columnDefs
                     #https://datatables.net/manual/styling/classes
                     #prima body e poi head!!!
                     columnDefs = (list(
                                   list(orderData = 0, targets = 2),
                                   list(orderData = 1, targets = 3),
                                   list(visible = FALSE, targets = c(0, 1, 9, 10)),
                                   list(width = '70px', targets =c(2)),
                                   list(width = '70px', targets =c(3)),
                                   list(width = '120px', targets =c(5)),
                                   list(width = '90px', targets =c(6)),
                                   list(width = '55px', targets =c(7)),
                                   list(width = '30px', targets =c(8)),
                                   list(className = 'dt-center', targets = c(2, 3, 8)),
                                   list(className = 'dt-body-right', targets = c(7)),
                                   list(className = 'dt-head-center', targets = c(2, 3, 4, 8)))
                                   ),
                     initComplete = JS(
                       "function(settings, json) {",
                       "$(this.api().table().header()).css({'background-color': '#375a7f', 'color': '#fff'});",
                       "}"),
                     language = list(search = "Cerca: ",
                                     paginate = list(previous = "Precedente", `next` = "Successiva"),
                                     info = "_START_ - _END_ di _TOTAL_ progetti di ricerca",
                                     infoFiltered = "(su un totale di _MAX_ progetti di ricerca)",
                                     infoEmpty = "Nessun progetto di ricerca disponibile",
                                     zeroRecords = "- Nessun progetto di ricerca disponibile -",
                                     lengthMenu = "Mostra _MENU_ progetti")))
})




observeEvent(input$select_button_prj, {
  selectedRow <- as.numeric(strsplit(input$select_button_prj, "_")[[1]][2])
  
  showModal(tags$div(id="MODAL_PROJ", # tags$div per inserire id e modificare css richiamando datatables https://stackoverflow.com/questions/46830173/tagsstyle-specific-modaldialog-element-in-shiny
                     modalDialog(
                       #h5(df_prj$Descrizione[selectedRow], style="text-align:justify"), # HTML("se vuoi scrivere a capo<br>prova questo")
                       size = "m",
                       footer = NULL,
                       easyClose = TRUE,
                       gt::gt_output(
                         paste0("filtered", selectedRow)
                         )
                       )
                     )
            )
                 
output[[paste0("filtered", selectedRow)]] <- gt::render_gt({
  
  filtered <- df_prj %>%
    arrange(desc(DataInizio),desc(DataFine)) %>%
    select(CodIDIzsler, anno_Inizio, Tipologia, STATO_PRJ, DataInizio_slash, DataFine_slash, RS, uo_coinvolte) %>%
    filter(CodIDIzsler %in% df_prj$CodIDIzsler[selectedRow])

  colnames(filtered) <- c("Codice Progetto",
                          "Anno",
                          "Tipologia",
                          "Stato",
                          "Data Inizio",
                          "Data Fine",
                          "Responsabile scientifico",
                          "U.O. Coinvolte")  
  
filtered %>% 
  rownames_to_column() %>%
  #mutate(hp_rpm = scales::number(hp_rpm)) %>% example formatting change
  mutate_all(as.character) %>% 
  pivot_longer(-rowname)  %>%
  pivot_wider(names_from = rowname) %>% 
  gt() %>% 
  tab_options(column_labels.hidden = T,
              table.border.top.color = "#375a7f",
              table.border.bottom.color = "#375a7f",
              table.border.top.width = 8,
              table.border.bottom.width = 8) %>%
  fmt_markdown(columns = everything())

})
})


     
     
# 6. CENTRI DI REFERENZA----
onclick('centri_int', updateTabItems(session, "sidebar", selected = "centri_int"))
onclick('centri_naz', updateTabItems(session, "sidebar", selected = "centri_naz"))
onclick('centri_reg', updateTabItems(session, "sidebar", selected = "centri_reg"))

## 6.1 OUTPUT INTERNAZIONALI ----
output$dttable_int_fao <- DT::renderDataTable(server = FALSE, {
  
  table_dt_reg <- centri_ref %>%
    filter(area == "Internazionali" & str_detect(descr_1, "Centro di Referenza FAO")) %>% 
    select(descr_2)

  table_reg <- DT::datatable(
    table_dt_reg,
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "T",
                   columnDefs = list(
                     list(className = 'dt-center', targets = c(0))
                     ),
                   headerCallback = JS(
              "function(thead, data, start, end, display){",
              "  $(thead).remove();",
              "}")
                   )
    )
})

output$dttable_int_oie <- DT::renderDataTable(server = FALSE, {
  
  table_dt_reg <- centri_ref %>%
    filter(area == "Internazionali" & str_detect(descr_1,"Laboratori di Referenza OIE")) %>% 
    select(descr_2)
  
  table_reg <- DT::datatable(
    table_dt_reg,
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "T",
                   columnDefs = list(
                     list(className = 'dt-center', targets = c(0))
                     ),
                   headerCallback = JS(
              "function(thead, data, start, end, display){",
              "  $(thead).remove();",
              "}")
                   )
    )
})

output$dttable_int_col_oie <- DT::renderDataTable(server = FALSE, {
  
  table_dt_reg <- centri_ref %>%
    filter(area == "Internazionali" & str_detect(descr_1,"Centro di Collaborazione OIE")) %>% 
    select(descr_2)
  
  table_reg <- DT::datatable(
    table_dt_reg,
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "T",
                   columnDefs = list(
                     list(className = 'dt-center', targets = c(0))
                     ),
                   headerCallback = JS(
              "function(thead, data, start, end, display){",
              "  $(thead).remove();",
              "}")
                   )
    )
})

output$dttable_int <- DT::renderDataTable(server = FALSE, {
  
  table_dt_reg <- centri_ref %>%
    filter(area == "Internazionali" & str_detect(descr_1,"Altro")) %>% 
    select(descr_2)
  
  table_reg <- DT::datatable(
    table_dt_reg,
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "T",
                   columnDefs = list(
                     list(className = 'dt-center', targets = c(0))
                     ),
                   headerCallback = JS(
              "function(thead, data, start, end, display){",
              "  $(thead).remove();",
              "}")
                   )
    )
})

## 6.2 OUTPUT NAZIONALI ----
output$dttable_naz <- DT::renderDataTable(server = FALSE, {
  
  table_dt_naz <- centri_ref %>%
    filter(area == "Nazionali") %>% 
    select(descr_2)

  table_reg <- DT::datatable(
    table_dt_naz,
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "T",
                   columnDefs = list(
                     list(className = 'dt-center', targets = c(0))
                     ),
                   headerCallback = JS(
              "function(thead, data, start, end, display){",
              "  $(thead).remove();",
              "}")
                   )
    )
})

## 6.3 OUTPUT REGIONALI ----
output$dttable_reg_lom <- DT::renderDataTable(server = FALSE, {
  
  table_dt_reg <- centri_ref %>%
    filter(area == "Regionali" & str_detect(descr_1,"Lombardia")) %>% 
    select(descr_2)

  table_reg <- DT::datatable(
    table_dt_reg,
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "T",
                   columnDefs = list(
                     list(className = 'dt-center', targets = c(0))
                     ),
                   headerCallback = JS(
              "function(thead, data, start, end, display){",
              "  $(thead).remove();",
              "}")
                   )
    )
})

output$dttable_reg_emi <- DT::renderDataTable(server = FALSE, {
  
  table_dt_reg <- centri_ref %>%
    filter(area == "Regionali" & str_detect(descr_1,"Emilia")) %>% 
    select(descr_2)
  
  table_reg <- DT::datatable(
    table_dt_reg,
    rownames = FALSE,
    escape = FALSE,
    selection = "none",
    options = list(dom = "T",
                   columnDefs = list(
                     list(className = 'dt-center', targets = c(0))
                     ),
                   headerCallback = JS(
              "function(thead, data, start, end, display){",
              "  $(thead).remove();",
              "}")
                   )
    )
})













# #https://github.com/daattali/advanced-shiny#hide-tab
# #app will automatically stop running whenever the browser tab (or any session) is closed.
# session$onSessionEnded(stopApp)





}







# output$info_dip_sic <-  renderUI({ 
# HTML('<div class="container">
#   <div class="row">
# <div class="question-instructions">
#   <div class="row text-center">
#     <div class="col-lg-12 col-lg-offset-2 col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2 ">
#     </div>
#   </div>
#   <div class="row question-line">
# 
#     <div class="col-lg-4 col-md-4 col-sm-4 question-block">
#       <div style="display: inline-block; color: #375a7f;">
#         <i class="fa fa-group fa-fw fa-3x question-icon"></i>
#         </div>
#         <div>
#         <h4 class="pull-center">TOT RICERCATORI</h4>
#       </div>
#     </div>
# 
#     <div class="col-lg-4 col-md-4 col-sm-4 question-block">
#       <div style="display: inline-block; color: #375a7f;">
#         <i class="fa fa-book fa-fw fa-3x question-icon"></i>
#         </div>
#         <div>
#         <h4 class="pull-center">TOT PUBBLICAZIONI</h4>
#       </div>
#     </div>
# 
#     <div class="col-lg-4 col-md-4 col-sm-4 question-block">
#       <div style="display: inline-block; color: #375a7f;">
#         <i class="fa fa-microscope fa-fw fa-3x question-icon"></i>
#         </div>
#         <div>
#         <h4 class="pull-center">TOT PROGETTI DI RICERCA</h4>
#       </div>
#     </div>
# 
# 
#   </div>
# </div>
#   </div>
# </div>')
# })





# #pubblicazioni
#      
#      
# paper <-  pubs %>%
#   select(Anno = OA, Autori = CAU , Titolo = "TI-INGLESE", Journal = datoBibl, IF) %>%
#   unique() %>%
#   mutate(link = str_extract(Journal, urlp),
#          link = paste0("<a href='",link,"'target='_blank'>","Vai all'articolo","</a>"),
#          IF =format(round(IF,3),nsmall=3)) %>%
#     arrange(desc(Anno), desc(IF)) %>% 
# 
#   
#   DT::datatable(class = 'cell-border compact',
#                 rownames=FALSE,
#                 escape = FALSE,
#                 extensions = "Buttons",
#                #per applicare una funzione di callback in JavaScript
#                 callback = JS("$('#DataTables_Table_1_filter input').css('background-color', '#4259a6');
#                              $('#DataTables_Table_1_filter input').css('color', '#fff');
#                              $('#DataTables_Table_1_filter').css('font-weight', '500');
# 
#                              $('#DataTables_Table_1_info').css('font-weight', '500');
# 
#                              $('#DataTables_Table_1_paginate').css('font-weight', '500');
# 
#                              $('button.buttons-excel').css('background','#4259a6');
#                              $('button.buttons-excel').css('color','#fff')"),
# 
# 
#               options = list(dom = "Bftip",
#                              escape = FALSE, #per leggere entità html
#                              pageLength = 10,
#                              paging = TRUE,
#                              autoWidth = FALSE,
# 
#                              buttons = "excel",
# 
#                              # buttons = list(list(extend = 'collection',
#                              #                     buttons = c('csv', 'excel', 'pdf'),
#                              #                     text = 'Download')
#                              #                ),
# 
#                              #https://datatables.net/reference/option/columnDefs
#                              #https://datatables.net/manual/styling/classes
#                              #prima body e poi head!!!
#                              columnDefs = list(list(className = 'dt-body-center', targets = c(0,4,5)),
#                                                list(className = 'dt-head-center', targets = c(0,1,2,3,4,5)) #"_all"
#                                                ),
# 
#                              initComplete = JS(
#                                "function(settings, json) {",
#                                "$(this.api().table().header()).css({'background-color': '#4259a6', 'color': '#fff'});",
#                                "}"),
# 
# 
#                              language = list(search = "Cerca: ",
#                                             paginate = list(previous = "Precedente", `next` = "Successiva"),
# 
#                                             info = "_START_ - _END_ di _TOTAL_ pubblicazioni",
#                                             infoFiltered = "(su un totale di _MAX_ pubblicazioni)",
#                                             infoEmpty = "Nessuna pubblicazione disponibile",
#                                             zeroRecords = "- Nessuna pubblicazione disponibile -")
#                              )
#               )
# 
# 
# output$pubbl <- DT::renderDataTable(server = FALSE, {paper})