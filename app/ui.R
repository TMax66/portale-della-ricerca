# HEADER ----

header <- 
  dashboardHeader(title = HTML("PORTALE DELLA RICERCA"),
                  titleWidth  = 230) #250

# header$children[[2]]$children[[2]] <- header$children[[2]]$children[[1]]
# header$children[[2]]$children[[1]] <- tags$a(href='https://www.izsler.it/', target='_blank',
#                                              tags$img(src='logo.png', height='53', width='43', class='header_img'))

# SIDEBAR ----
#icone: https://fontawesome.com/v4/icons/ - https://fontawesome.com/icons/categories/medical-health - https://getbootstrap.com/docs/3.4/components/#glyphicons

sidebar <-
  dashboardSidebar(
  #https://stackoverflow.com/questions/41939346/hide-main-header-toggle-in-r-shiny-app
    tags$script(JS("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")), #widgets the sidebar toggle element - library(hmlwidgets)
    width = 230,
    sidebarMenu(id = 'sidebar', style = "position: relative; overflow: visible;",
                menuItem("HOME", tabName = 'home',icon = icon("home", "fa-2x", lib = "font-awesome")),
                menuItem("DIPARTIMENTI", tabName = 'dipartimenti', icon = icon("city", "fa-2x", lib = "font-awesome")),
                         hidden(menuItem("DT LOMBARDIA", tabName = "dt_lombardia", icon = icon(NULL))),
                         hidden(menuItem("DT EMILIA", tabName = "dt_emilia", icon = icon(NULL))),
                         hidden(menuItem("TUTELA E SALUTE ANIMALE", tabName = "dt_tutela", icon = icon(NULL))),
                         hidden(menuItem("SICUREZZA ALIMENTARE", tabName = "dt_sicurezza", icon = icon(NULL))),
                menuItem("RICERCATORI", tabName = 'ricercatori', icon = icon("users", "fa-2x", lib = "font-awesome")),
                menuItem("PUBBLICAZIONI", tabName = 'pubblicazioni', icon = icon("book", "fa-2x", lib = "font-awesome")),
                menuItem("PROGETTI DI RICERCA", tabName = 'progetti', icon = icon("microscope", "fa-2x", lib = "font-awesome")),
                menuItem("CENTRI DI REFERENZA", tabName = 'centri', icon = icon("building", "fa-2x", lib = "font-awesome")),
                         hidden(menuItem("CENTRI_INT", tabName = "centri_int", icon = icon(NULL))),
                         hidden(menuItem("CENTRI_NAZ", tabName = "centri_naz", icon = icon(NULL))),
                         hidden(menuItem("CENTRI_REG", tabName = "centri_reg", icon = icon(NULL))),
                menuItem("LINEE DI RICERCA", tabName = 'linee', icon = icon("laptop", "fa-2x", lib = "font-awesome"),
                         menuSubItem("PROVA 1", tabName = "prova1"),
                         menuSubItem("PROVA 2", tabName = "prova2")
                         )
                )
    )
  

        
# BODY ----
body <- dashboardBody(
  useShinyjs(),
  #https://stackoverflow.com/questions/602168/in-css-what-is-the-difference-between-and-when-declaring-a-set-of-styles
  #https://stackoverflow.com/questions/12889362/what-is-the-difference-between-id-and-class-in-css-and-when-should-i-use-them
  #https://stackoverflow.com/questions/3859801/difference-between-margin-left-and-left-or-margin-right-and-right
  #https://stackoverflow.com/questions/11143273/position-div-relative-to-another-div
  #https://stackoverflow.com/questions/56249756/adjust-the-height-of-navbar-menu-in-a-shiny-app #https://stackoverflow.com/questions/57843906/change-height-of-navbarpage
  tags$head(tags$style(HTML('

/* PULSANTE TORNASU - GOTOTOP */  
  #goTopSpan {
    padding-left: 25px;
  }
   
  #goTopSpan::after {
    content: "TORNA SU";
    font-size: 11px;
    font-weight: 500;
    vertical-align: middle;
    font-family: "Montserrat", sans-serif;
    /*border-left: 1em solid transparent;*/
    padding-left: 1em;
   }
    

  
  
/* CENTRATE ICONE SIDEBAR MENU */  
#sidebarCollapsed #sidebarItemExpanded span {
    padding-left: 5px;
    }
 
#sidebarCollapsed #sidebarItemExpanded i {
    width: 35px;
    text-align: center;
    margin-left: -5px;
    }
    
    


/* TOGLIERE SPAZIO TRA HEADER E BOX; TOGLIERE GLI ANGOLI SMUSSATI */
       .box_logo_izsler {
        margin-top: -15px;
        margin-left: -15px;
        border-radius: 0px;
       }
       
       .logo_izsler {
        display: flex;
        position: relative;
        margin-top: -8px;
        font-family: "Montserrat", sans-serif;;
        font-weight: bold;
       }
       
       .logo_izsler p {
        margin: 0;
        text-indent: 10px;
       }
       
       .box_logo_izsler #ubert_img {
        position: absolute;
        top: -10px;
        right: -10px;
        opacity: 0.8;
       }
        
/* TOGLIERE COLORE DA TITOLO QUANDO PASSO IL MOUSE (HOVER) */
       .skin-blue .main-header .logo:hover {
        background-color: #4259a6;
       }
        
       .header_img {
        margin-left: -20px;
       }
       
/* TITOLO */

       .skin-blue .main-header .logo {
        background-color: #375a7f;
        font-size: 14.5px;
        font-family: "Montserrat", sans-serif;
        font-weight: 500;
        /*height: 0px; nascondere parte sinistra come Pasteur */
       }
        
       .skin-blue .main-header .logo:hover { 
        background-color: #375a7f; 
       }
        
       .skin-blue .main-header .navbar {
        background-color: #375a7f;
       }
        
       .skin-blue .main-sidebar {
        font-size: 11px;
        font-family: "Montserrat", sans-serif;
        font-weight: 400;
        line-height: 40px;
        background-color: #30343e
       }
       
       .skin-blue .sidebar-menu .treeview-menu>li>a {
        font-size: 10px;
        font-family: "Montserrat", sans-serif;
        font-weight: 400;
        line-height: 40px;
       }
        
       .skin-blue .sidebar-menu > li.active > a {
        border-left-color: #a9c0e5;
       }
        
       .skin-blue .sidebar-menu > li:hover > a {
        border-left-color: #a9c0e5;
       }
       
       
/* NAVPILLSITEM IN TAB RICERCATORI */
       #shiny-tab-ricercatori .nav-pills > li.active > a {
        pointer-events: none;
        border-left-color: transparent;
        font-weight:normal;
       }

/* TESTO USERBOX SUBTITLE TAB RICERCATORI */       
       #shiny-tab-ricercatori h5.widget-user-desc {
        font-size: 13px;
       }
       
       
       
/* !!!!! */
/* FRECCIA SIDEBAR MENU SUB ITEM CHE SI SPOSTAVA QUANDO ESPANDEVI IL MENU DIPARTIMENTI */
/* https://github.com/ColorlibHQ/AdminLTE/issues/1134 */
       .sidebar-menu li > a > .pull-right {
        margin-top: -7px;
        position: absolute;
        right: 10px;
        top: 50%;
       }
       
      
/* CAMBIATA ICONA FRECCIA SIDEBAR MENU SUB ITEM */
       .fa-angle-left:before {
        content: "≡";
       }
       
       .fa-angle-down:before {
        content: "≡";
        margin-left:4px;
       }
       
/* CAMBIARE COLORE BODY DASHBOARD = BIANCO */
       .content-wrapper, .right-side {
        background-color: #fff;
       }
           
           
           
           
           
/* INTESTAZIONE BODY TAB */           
           
/* IMMAGINE INTESTAZIONE TAB HOME */
       .box_img_home { 
        background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url(esternoprato.JPG);
        height: 100%;
        background-position: 50% 20%;
        background-repeat: no-repeat;
        background-size: cover;
        margin-top: -20px;
       }
   

/* IMMAGINE INTESTAZIONE TAB DIPARTIMENTI */
       .box_img_dipartimenti{ 
        background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url(izsler_dic1969.png);
        height: 100%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin-top: -20px;
       }
       

/* IMMAGINE INTESTAZIONE TAB PUBBLICAZIONI */
       .box_img_pubblicazioni { 
        background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url(biblio.jpg);
        height: 100%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin-top: -20px;
       }
       
/* IMMAGINE INTESTAZIONE TAB PROGETTI DI RICERCA */
       .box_img_progetti { 
        background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url(biochimicaclinica7.jpg);
        height: 100%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin-top: -20px;
       }

/* IMMAGINE INTESTAZIONE TAB RICERCATORI */
       .box_img_ricercatori { 
        background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url(ricer.jpg);
        height: 100%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin-top: -20px;
       }
       
/* IMMAGINE INTESTAZIONE TAB CENTRI REFERENZA */
       .box_img_centri { 
        background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url(IZP_5590.JPG);
        height: 100%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin-top: -20px;
       }
       
       

/* TESTO INTESTAZIONE TAB HOME-DIPARTIMENTI-PUBBLICAZIONI-RICERCATORI-CENTRI */
       .box_text_home,
       .box_text_dipartimenti,
       .box_text_pubblicazioni,
       .box_text_progetti,
       .box_text_ricercatori,
       .box_text_centri { 
     /* display: flex; */
        align-items: center;
        justify-content: center;
        align-content: center;
        text-align: center;
        padding: 150px 0 80px 0;
        color: #283067;
        font-family: "Montserrat", sans-serif;
        font-size: 35px;
        font-weight: 700;
        line-height: 25px;
       }
        
/* LINEA TESTO INTESTAZIONE TAB HOME-DIPARTIMENTI-PUBBLICAZIONI-RICERCATORI-CENTRI */
       .box_text_home hr,
       .box_text_dipartimenti hr,
       .box_text_pubblicazioni hr,
       .box_text_progetti hr,
       .box_text_ricercatori hr,
       .box_text_centri hr { 
        border: 2px solid;
        background-color: #283067;
        width: 100px;
       }





/*TOGLIERE IMMAGINE PROFILO USERBOX DIPARTIMENTI*/
    /* .widget-user-2 .widget-user-image>img {*/
    /*  display:none;*/
    /* } */







/*EMPLOYEE*/


/*       .footer-container{*/
/*        display : flex;*/
/*        align-items : center;*/
/*        justify-content: center;*/
/*        color: #fff;*/
/*        background-color: #375a7f;*/
/*        position: relative;*/ /*absolute*/
/*        left: 0;*/
/*        bottom: 0;*/
/*        height: 40px;*/ /*50px*/
/*        padding-left: 50px;*/
/*        padding-right: 50px;*/
/*        width: 100%;*/
/*        overflow: hidden;*/
/*       }*/
/**/
/*       .footer-title{*/
/*        flex: 1;*/
/*        font-size: 12px;*/
/*        color: #fff;*/
/*        vertical-align: middle;*/
/*        text-align: center;*/
/*       }*/




       .search-container{
        padding-left: 30px;    /* 118px */
       }

       .search-input{
        float: left;
       }
       
       
       
/* TAB PROGETTI DI RICERCA*/       
       
       #shiny-tab-progetti .select-input{
        display: flex;
       }
       
       #shiny-tab-progetti div.selectize-input.items.not-full.has-options,
       #shiny-tab-progetti div.selectize-input.has-options.full.has-items {
        margin-left: 50px;
       }
       
       #shiny-tab-progetti div.search-container {
        margin-bottom: -100px;    /* 118px */
       }
       
       #shiny-tab-progetti .selectize-input,
       #shiny-tab-progetti .selectize-input.dropdown-active,
       #shiny-tab-progetti .selectize-dropdown {
       border-radius:0px;
       border: 1px solid #ccc;
       }
       
       #shiny-tab-progetti .selectize-dropdown,
       #shiny-tab-progetti .selectize-input,
       #shiny-tab-progetti .selectize-input input {
       color: #555555 !important;
       opacity: 0.9 !important;
       }
       
       #search_field_proj-label,
       #select_status_proj-label {
       display: none;
       }
       
       
       
#MODAL_PROJ #shiny-modal div.modal-dialog {
       width: fit-content !important;
}  
       
       
#MODAL_PROJ #shiny-modal table.gt_table {
font-family: "Montserrat", sans-serif;
font-size: 14px;
}

       
       
       
       

/* TOGLIERE TASTO DEFAULT SEARCH DA DATATABLE */
       #research_table_lom .dataTables_filter,
       #research_table_emi .dataTables_filter,
       #research_table_tut .dataTables_filter,
       #research_table_sic .dataTables_filter,
       #research_table_all .dataTables_filter,
       #pubbl .dataTables_filter,
       #proj .dataTables_filter {
        display: none;
       }
       
       
       
       
       #pubbl .dataTables_length label,
       #proj .dataTables_length label {
        font-weight: 400;
       }
       
       #pubbl .dataTables_length,
       #proj .dataTables_length {
        float: right;
       }
       
    
       #pubbl .dataTables_paginate .paginate_button:hover,
       #proj .dataTables_paginate .paginate_button:hover {
        background: #375a7f;
       }
       
       #pubbl .dataTables_paginate .paginate_button.disabled,
       #proj .dataTables_paginate .paginate_button.disabled {
        background: transparent !important;
       }
       
       #pubbl .dataTables_paginate .paginate_button.current,
       #proj .dataTables_paginate .paginate_button.current {
        background: #375a7f !important;
        color: #fff !important;
        border: 1px solid black;
        border-radius: 2px;
       }


   
       
       


       .profile-table-img{
        border-radius: 50%;
        height: 60px;
        width: 60px;
        object-fit: cover;
       }
       
       .table-sub-title{
        color: #a2a8ab;
       }


/*PER FISSARE LA LARGHEZZA DELLE COLONNE DATATABLE*/
        table.dataTable {
        margin: 0 auto;
        width: 100%;
        clear: both;
        border-collapse: collapse;
        table-layout: fixed;
        word-wrap: break-word;
       }


/* PER TOGLIERE ICONA FRECCIA ORDINAMENTO COLONNE DATATABLE (aggiungi ID (#DataTables_Table_0_wrapper ?) per togliere solo in alcune) */
/* PER ALLINEARE INTESTAZIONE DATATABLE (PADDING) */
       #research_table_lom table.dataTable thead .sorting,
       #research_table_emi table.dataTable thead .sorting,
       #research_table_tut table.dataTable thead .sorting,
       #research_table_sic table.dataTable thead .sorting,
       #research_table_all table.dataTable thead .sorting,
       #pubbl .dataTable thead .sorting {
        background-image: none !important;
        font-weight: 400;
        padding-left: 10px;
        padding-right: 10px;
}
   
       #proj .dataTable thead .sorting {
        background-image: none !important;
        font-weight: 400;
        padding-left: 4px;
        padding-right: 4px;
}
     
       #MODAL_PUB_LOM table.dataTable thead .sorting,
       #MODAL_PUB_EMI table.dataTable thead .sorting,
       #MODAL_PUB_TUT table.dataTable thead .sorting,
       #MODAL_PUB_SIC table.dataTable thead .sorting,
       #MODAL_PUB_ALL table.dataTable thead .sorting {
        background-image: none !important;
        font-weight: 400;
}     
     
     
     

/*       #research_table_lom table.dataTable thead .sorting_asc {*/
/*        background-image: none !important;*/
/*       }*/
/**/
/*       #research_table_lom table.dataTable thead .sorting_desc {*/
/*        background-image: none !important;*/
/*       }*/


       #shiny-tab-dipartimenti img,
       #shiny-tab-centri_int img,
       #shiny-tab-centri_naz img,
       #shiny-tab-centri_reg img {
        display: none;
       }



/* FOOTER */

        footer.main-footer {
        color: #fff;
        background-color: #375a7f;
        padding-top: 5px;
        padding-bottom: 5px;
       }
       
        footer.main-footer p {
        vertical-align: middle;
        text-align: center;
        margin-bottom: 0px;
        font-size: 12px;
        font-family: "Montserrat", sans-serif;
       }

        footer.main-footer a {
        float:right;
        font-size: 14px;
       }




/* LINK IZSLER IN HEADER */

       .link_izsler_header {
        font-size: 13px;
        font-weight: 400;
        float: right;
        line-height: 50px;
        text-align: left;
        font-family: "Montserrat", sans-serif;
        padding: 0 15px;
        overflow: hidden;
       }
       
       .link_izsler_header a {
        color: #fff;
       }
       
       .link_izsler_header a:hover {
        color: #72afd2;
       }
       
       
  
  
       
/* TAB HOME  */
/* COLONNA SINISTRA */
       #shiny-tab-home #col_sx_home #home_logo {
        display: flex;
        float: left;
        font-family: "Montserrat", sans-serif;;
        font-weight: 500;
        font-size: 13px;
        text-align: justify;
        align-items: center;
       }

       #shiny-tab-home #col_sx_home #home_logo p {
        margin: 0 0 0 0;
        padding-left: 10px;
       }


       #shiny-tab-home #col_sx_home #home_list {
        font-family: "Montserrat", sans-serif;;
        font-weight: 500;
        font-size: 13px;
        text-align: justify;
        margin: 110px 0px 0px 10px;
       }


       #shiny-tab-home #col_sx_home li{
        margin: 1px 0 0 -20px;
       }


/* TAB HOME  */
/* COLONNA DESTRA */     

#dttable_news table.dataTable thead th,
#dttable_news table.dataTable thead td {
    visibility: hidden;
}

#dttable_news .profile-table-img {
    border-radius: 50%;
    height: 40px;
    width: 40px;
    object-fit: cover;
}


#col_dx_home .box-title,
#col_dx_home .box-header {
        font-family: "Montserrat", sans-serif;;
        font-weight: 500;
        font-size: 20px;
        text-align: center;
        color: #fff;
        background-color: #375a7f;
}

#col_dx_home .box-footer {
    margin-top: 20px;
    float: right;
    font-family: "Montserrat", sans-serif;;
    font-weight: 500;
    font-size: 11px;

}

        
#dttable_news table.dataTable.no-footer {
   font-size: 12px;
   margin-top: -40px;
}
    
    /* width */
#col_dx_home div::-webkit-scrollbar {
  width: 20px;
}


/* Track */
#col_dx_home div::-webkit-scrollbar-track {
  background-color: transparent;
}
 
/* Handle */
#col_dx_home div::-webkit-scrollbar-thumb {
  background-color: #375a7f; /*#d6dee1*/
  border-radius: 20px;
  border: 6px solid transparent;
  background-clip: content-box;
}

/* Handle on hover */
#col_dx_home div::-webkit-scrollbar-thumb:hover {
  background-color: #a8bbbf;
}





    
    
    
    
/* PROBLEMA RISOLTO: LARGHEZZA PAGINA APP CHE SI RIDUCE QUANDO APRI E CHIUDI MODALE */    
        
        body {
        padding-right:0 !important;
       }

       .modal-open {
        overflow: scroll;
       }
       
/* ----------------------- */



/* TAB DIPARTIMENTI */

#shiny-tab-dipartimenti .container-fluid {
 padding-top: 40px;
}
 
 
#shiny-tab-dipartimenti .widget-user .widget-user-username {
    font-size: 24px;
}


#btn_dip_lombardia .widget-user-header.bg-black.bg-light-blue,
#btn_dip_emilia .widget-user-header.bg-black.bg-light-blue,
#btn_dip_tutela .widget-user-header.bg-black.bg-light-blue,
#btn_dip_sicurezza .widget-user-header.bg-black.bg-light-blue {
cursor: pointer;
}


#btn_dip_lombardia,
#btn_dip_emilia,
#btn_dip_tutela,
#btn_dip_sicurezza {
    margin-bottom: 40px;
}
    
#btn_dip_lombardia div.box-body,
#btn_dip_emilia div.box-body,
#btn_dip_tutela div.box-body,
#btn_dip_sicurezza div.box-body {
    padding: 0 0 0 0;
}

/* ----------------------- */



/* TAB DIPARTIMENTI - ICONE CON INFO_DIP*/
.question-instructions {
  margin: 0px 0px 0px;
  width: 100%;
}

.question-line {
  margin: 0px auto;
  white-space: nowrap;
  text-align: center;
}

.question-block {
  margin: 10px 0 10px;
  vertical-align: middle;
  white-space: nowrap; 

}

#info_dip_ric_lom,
#info_dip_pub_lom,
#info_dip_prj_lom,
#info_dip_ric_emi,
#info_dip_pub_emi,
#info_dip_prj_emi,
#info_dip_ric_tut,
#info_dip_pub_tut,
#info_dip_prj_tut,
#info_dip_ric_sic,
#info_dip_pub_sic,
#info_dip_prj_sic {
font-family: "Montserrat", sans-serif;;
font-weight: 800;
font-size: 18px;
}


#shiny-tab-dt_lombardia h4.pull-center,
#shiny-tab-dt_emilia h4.pull-center,
#shiny-tab-dt_tutela h4.pull-center,
#shiny-tab-dt_sicurezza h4.pull-center,
#shiny-tab-dt_lombardia .pull-center p,
#shiny-tab-dt_emilia .pull-center p,
#shiny-tab-dt_tutela .pull-center p,
#shiny-tab-dt_sicurezza .pull-center p {
font-family: "Montserrat", sans-serif;
font-weight: 500;
font-size: 14px;
margin-top: 0px;
}

/* ----------------------- */





/* CENTRI DI REFERENZA */

#centri_int,
#centri_naz,
#centri_reg {
cursor: pointer;
}





.styled-table {
    border-collapse: collapse;
    margin: 25px 0;
    font-size: 0.9em;
    font-family: sans-serif;
    min-width: 400px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}


.dttable_centri {
        font-family: "Montserrat", sans-serif;;
        font-weight: 500;
        font-size: 15px;
        text-align: justify;
        }



table.dataTable.no-footer {
    border-bottom: 1px solid #ddd !important;
}
    
    



/* https://astronautweb.co/snippet/font-awesome/ */
/* .element:before { */
/*     content: "\f000"; */
/*     font-family: FontAwesome; */
/*     font-style: normal; */
/*     font-weight: normal; */
/*     text-decoration: inherit; */
/* */
/*     color: #000; */
/*     font-size: 18px; */
/*     padding-right: 0.5em; */
/*     position: absolute; */
/*     top: 10px; */
/*     left: 0; */
/* } */
 

 
 ')
 )
),
tags$script(HTML('
      $(document).ready(function() {
        $("header").find("nav").append(\'<span class="link_izsler_header" > <a href = "https://www.izsler.it/" target="_blank"> IZSLER.IT </a> </span>\');
      })')),


use_gotop(src = "fas fa-arrow-circle-up", color = "#fff", place = "left",width = "35px", zIndex = 1000, opacity = 1),

#cambiare fluidRow con fluidPage(fluidRow(   ???

#intestazione ubertini----
fluidRow(shinydashboard::box(class = "box_logo_izsler",
                      solidHeader = TRUE,
                      width = NULL,
                      height = 64,
                      column(11,
                             tags$div(class = "logo_izsler",
                                      tags$a(href = 'https://www.izsler.it/', target='_blank',
                                             tags$img(src = 'logo_esteso.png',
                                                      height = '60',
                                                      width = '49')
                                             ),
                                      tags$div(
                                        tags$p("ISTITUTO ZOOPROFILATTICO SPERIMENTALE"),
                                        tags$p("DELLA LOMBARDIA E DELL'EMILIA ROMAGNA"),
                                        tags$p('"BRUNO UBERTINI"')
                                        )
                                      )
                             ),
                      column(1,
                             tags$img(src = 'ubertini.png',
                                      height = "64",
                                      width = "58",
                                      id = 'ubert_img')
                             )
                      )
  ),

tabItems(
# 1. home----
         tabItem(tabName = "home",
                 fluidRow(
                   shinydashboard::box(
                     class = "box_img_home",
                     solidHeader = TRUE,
                     width = NULL,
                     height = 350,
                     tags$div(class = "box_text_home",
                              tags$p("IZSLER"),
                              tags$hr(),
                              tags$p("PORTALE DELLA RICERCA"))
                     )),
                   fluidRow(
                     column(id = "col_sx_home", 6,
                            tagList(tags$div(id = "home_logo",
                                    tags$a(href = 'https://www.izsler.it/ricerca-2/',
                                    tags$img(src = 'logo_ricerca.png',
                                             height = '100',
                                             width = '100')),
                                    tags$p(HTML("L’izsler svolge attività di RICERCA, di base e finalizzata, per lo sviluppo delle conoscenze nell’igiene e sanità veterinaria, secondo programmi e mediante convenzioni con Università e Istituti di ricerca italiani e stranieri, nonché su richiesta dello Stato, di Regioni ed Enti pubblici e privati."))
                                    ),
                                    tags$div(id = "home_list",
                                    tags$span("Gli indirizzi generali sono:"),
                                    tags$ul(
                                    tags$li(tags$span("eziologia, patogenesi e profilassi delle malattie infettive e diffusive degli animali;")),
                                    tags$li(tags$span("igiene degli allevamenti e delle produzioni zootecniche;")),
                                    tags$li(tags$span("tecnologie e metodiche necessarie al controllo sulla salubrità degli alimenti di origine animale e dell’alimentazione animale;")),
                                    tags$li(tags$span("metodi alternativi all’impiego di modelli animali nella sperimentazione scientifica ed in campo tossicologico;")),
                                    tags$li(tags$span("miglioramento delle tecniche diagnostiche;")),
                                    tags$li(tags$span("benessere animale;")),
                                    tags$li(tags$span("sicurezza alimentare e risk assessment.")))
                                    )
                                    )
                            ),
## 1.1 NEWS----
                   box(id = "col_dx_home",
                       width = 6,
                       title = "ULTIME NOTIZIE - CONCORSI - NUOVE PUBBLICAZIONI",
                       footer = "ultimo aggiornamento: 26/05/2022",
                       div(style = "height: 250px;
                          overflow-y: scroll;
                         margin-bottom: -40px;
                          margin-top: 0px;
                          font-family: 'Montserrat';
                          font-weight: 400;",
          dataTableOutput("dttable_news"))
          )
)),

#https://stackoverflow.com/questions/44279773/r-shiny-add-picture-to-box-in-fluid-row-with-text

# 2. dipartimenti - start----    
tabItem(tabName = "dipartimenti",
            fluidRow(
              shinydashboard::box(
                class = "box_img_dipartimenti",
                solidHeader = TRUE,
                width = NULL,
                height = 350,
                tags$div(class = "box_text_dipartimenti",
                  tags$p("IZSLER"),
                  tags$hr(),
                  tags$p("DIPARTIMENTI")
                  )
                )
              ),
              
## 2.1 userbox lombardia----    
fluidPage(
  fluidRow(
  column(6, align ="center",
         userBox(id = "btn_dip_lombardia", width = 12,
        title = userDescription(
          title = "Dipartimento Area Territoriale Lombardia",
          subtitle = HTML(paste("","Direttore di Dipartimento:","Dr. Giorgio Varisco",sep="<br>")),
          type = 1,
          image = NULL,
          backgroundImage = "image_box.jpg"),
          status = "primary",
          collapsible = FALSE
        )),
         

## 2.2 userbox emilia----    
column(6, align ="center",
       userBox(id = "btn_dip_emilia", width = 12,
        title = userDescription(
          title = "Dipartimento Area Territoriale Emilia Romagna",
          subtitle = HTML(paste("","Direttore di Dipartimento:","Dr.ssa Norma Arrigoni",sep="<br>")),
          type = 1,
          image = NULL,
          backgroundImage = "image_box.jpg"),
          status = "primary",
          collapsible = FALSE))),

## 2.3 userbox tutela----    
fluidRow(
  column(6, align ="center",
         userBox(id = "btn_dip_tutela", width = 12,
        title = userDescription(
          title = "Dipartimento Tutela e Salute Animale",
          subtitle = HTML(paste("","Direttore di Dipartimento:","Dr. Antonio Lavazza",sep="<br>")),
          type = 1,
          image = NULL,
          backgroundImage = "image_box.jpg"),
          status = "primary",
          collapsible = FALSE)),

## 2.4 userbox sicurezza----    
column(6, align ="center",
       userBox(id = "btn_dip_sicurezza", width = 12,
        title = userDescription(
          title = "Dipartimento Sicurezza Alimentare",
          subtitle = HTML(paste("","Direttore di Dipartimento:","Dr. Giorgio Fedrizzi",sep="<br>")),
          type = 1,
          image = NULL,
          backgroundImage = "image_box.jpg"),
          status = "primary",
          collapsible = FALSE
))))),


### dipartimenti - start - body----
#### 2.1 dip LOMBARDIA----    
tabItem(tabName = "dt_lombardia",
        fluidRow(
          shinydashboard::box(
            class="box_img_dipartimenti",
            solidHeader = TRUE,
            width = NULL,
            height = 350,
            tags$div(class="box_text_dipartimenti",
                     tags$p("IZSLER"),
                     tags$hr(),
                     tags$p("DIPARTIMENTO AREA TERRITORIALE LOMBARDIA")
                     )
            )
          ),
        fluidRow(div(class = "container",
 div(class = "row",
   div(class = "question-instructions",
     div(class = "row text-center"),
     div(class = "row question-line",
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-group fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_ric_lom"),
           h4(class = "pull-center",
             "RICERCATORI"))),
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-book fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_pub_lom"),
           HTML(
             paste0("<p>",
                    "PUBBLICAZIONI",
                    "<br>",
                    "(2021)",
                    "</p>")))
         ),
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-microscope fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_prj_lom"),
           HTML(
             paste0("<p>",
                    "PROGETTI DI RICERCA",
                    "<br>",
                    "(IN CORSO)",
                    "</p>")))
         )
       ))))),
        fluidRow(
            div(class="search-container",
                div(class="search-input",
                    textInput("search_field_lom", label = NULL, value = "", width = NULL, placeholder = "Cerca")))),
          dataTableOutput("research_table_lom")
          ),


#### 2.2 dip EMILIA----    
tabItem(tabName = "dt_emilia",
        fluidRow(
          shinydashboard::box(
            class="box_img_dipartimenti",
            solidHeader = TRUE,
            width = NULL,
            height = 350,
            tags$div(class="box_text_dipartimenti",
                     tags$p("IZSLER"),
                     tags$hr(),
                     tags$p("DIPARTIMENTO AREA TERRITORIALE EMILIA ROMAGNA")
                     )
            )
          ),
        fluidRow(div(class = "container",
 div(class = "row",
   div(class = "question-instructions",
     div(class = "row text-center"),
     div(class = "row question-line",
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-group fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_ric_emi"),
           h4(class = "pull-center",
             "RICERCATORI"))),
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-book fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_pub_emi"),
           HTML(
             paste0("<p>",
                    "PUBBLICAZIONI",
                    "<br>",
                    "(2021)",
                    "</p>")))
         ),
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-microscope fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_prj_emi"),
           HTML(
             paste0("<p>",
                    "PROGETTI DI RICERCA",
                    "<br>",
                    "(IN CORSO)",
                    "</p>")))
         )
       ))))),
        fluidRow(
            div(class="search-container",
                div(class="search-input",
                    textInput("search_field_emi", label = NULL, value = "", width = NULL, placeholder = "Cerca")))),
          dataTableOutput("research_table_emi")
          ),


#### 2.3 dip TUTELA----    
tabItem(tabName = "dt_tutela",
        fluidRow(
          shinydashboard::box(
            class="box_img_dipartimenti",
            solidHeader = TRUE,
            width = NULL,
            height = 350,
            tags$div(class="box_text_dipartimenti",
                     tags$p("IZSLER"),
                     tags$hr(),
                     tags$p("DIPARTIMENTO TUTELA E SALUTE ANIMALE")
                     )
            )
          ),
        fluidRow(div(class = "container",
 div(class = "row",
   div(class = "question-instructions",
     div(class = "row text-center"),
     div(class = "row question-line",
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-group fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_ric_tut"),
           h4(class = "pull-center",
             "RICERCATORI"))),
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-book fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_pub_tut"),
           HTML(
             paste0("<p>",
                    "PUBBLICAZIONI",
                    "<br>",
                    "(2021)",
                    "</p>")))
         ),
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-microscope fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_prj_tut"),
           HTML(
             paste0("<p>",
                    "PROGETTI DI RICERCA",
                    "<br>",
                    "(IN CORSO)",
                    "</p>")))
         )
       ))))),
        fluidRow(
            div(class="search-container",
                div(class="search-input",
                    textInput("search_field_tut", label = NULL, value = "", width = NULL, placeholder = "Cerca")))),
          dataTableOutput("research_table_tut")
          ),


#### 2.4 dip SICUREZZA----    
tabItem(tabName = "dt_sicurezza",
        fluidRow(
          shinydashboard::box(
            class="box_img_dipartimenti",
            solidHeader = TRUE,
            width = NULL,
            height = 350,
            tags$div(class="box_text_dipartimenti",
                     tags$p("IZSLER"),
                     tags$hr(),
                     tags$p("DIPARTIMENTO SICUREZZA ALIMENTARE")
                     )
            )
          ),
        fluidRow(div(class = "container",
 div(class = "row",
   div(class = "question-instructions",
     div(class = "row text-center"),
     div(class = "row question-line",
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-group fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_ric_sic"),
           h4(class = "pull-center",
             "RICERCATORI"))),
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-book fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_pub_sic"),
           HTML(
             paste0("<p>",
                    "PUBBLICAZIONI",
                    "<br>",
                    "(2021)",
                    "</p>")))
         ),
       div(class = "col-lg-4 col-md-4 col-sm-4 question-block",
         div(style = "display: inline-block; color: #375a7f;",
           tags$i(class = "fa fa-microscope fa-fw fa-3x question-icon")),
         div(class = "pull-center", 
          uiOutput("info_dip_prj_sic"),
           HTML(
             paste0("<p>",
                    "PROGETTI DI RICERCA",
                    "<br>",
                    "(IN CORSO)",
                    "</p>")))
         )
       ))))),
        fluidRow(
            div(class="search-container",
                div(class="search-input",
                    textInput("search_field_sic", label = NULL, value = "", width = NULL, placeholder = "Cerca")))),
          dataTableOutput("research_table_sic")
          ),








# 3.ricercatori ----    
    tabItem(tabName = "ricercatori",
            fluidRow(
              shinydashboard::box(
                class = "box_img_ricercatori",
                solidHeader = TRUE,
                width = NULL,
                height = 350,
                tags$div(class = "box_text_ricercatori",
                  tags$p("IZSLER"),
                  tags$hr(),
                  tags$p("RICERCATORI")
                  )
                )
              ),
           fluidRow(
            div(class="search-container",
                div(class="search-input",
                    textInput("search_field_all", label = NULL, value = "", width = NULL, placeholder = "Cerca")))),
          dataTableOutput("research_table_all")
          ),



# 4.pubblicazioni ----    
    tabItem(tabName = "pubblicazioni",
            fluidRow(
              shinydashboard::box(
                class = "box_img_pubblicazioni",
                solidHeader = TRUE,
                width = NULL,
                height = 350,
                tags$div(class = "box_text_pubblicazioni",
                  tags$p("IZSLER"),
                  tags$hr(),
                  tags$p("PUBBLICAZIONI")
                  )
                )
              ),
            fluidRow(
            div(class="search-container",
                div(class="search-input",
                    # shinyWidgets::searchInput(inputId = "search_field_pubbl",
                    #                           label = NULL, placeholder = "Cerca",
                    #                           btnSearch = icon("search"),
                    #                           btnReset = icon("remove"),
                    #                           width = NULL)))),
                     textInput("search_field_pubbl", label = NULL, value = "", width = NULL, placeholder = "Cerca")))),
            dataTableOutput("pubbl")
            ),

# 5. progetti di ricerca----    
    tabItem(tabName = "progetti",
            fluidRow(
              shinydashboard::box(
                class = "box_img_progetti",
                solidHeader = TRUE,
                width = NULL,
                height = 350,
                tags$div(class = "box_text_progetti",
                  tags$p("IZSLER"),
                  tags$hr(),
                  tags$p("PROGETTI DI RICERCA")
                  )
                )
              ),
            fluidRow(
            div(class="search-container",
                div(class="search-input",
                    textInput("search_field_proj", 
                              label = "",
                              value = "",
                              width = NULL,
                              placeholder = "Cerca")),
                    #https://shiny.rstudio.com/gallery/selectize-vs-select.html
                     div(class="select-input",
                           selectInput("select_status_proj", "",
                                width = NULL, 
                                c("Stato progetto:" = "tutti", "in corso", "concluso"),
                                selectize = TRUE
                                )))),
            dataTableOutput("proj")
            ),

# 6. centri di referenza----    
    tabItem(tabName = "centri",
            fluidRow(
              shinydashboard::box(
                class = "box_img_centri",
                solidHeader = TRUE,
                width = NULL,
                height = 350,
                tags$div(class = "box_text_centri",
                  tags$p("IZSLER"),
                  tags$hr(),
                  tags$p("CENTRI DI REFERENZA")
                  )
                )
              ),
            fluidRow(
                   div(style="display: flex; justify-content: space-between; margin-top: 40px; margin-right: 100px; margin-left: 100px;",
                     img(id = "centri_int", src = 'euro_def_mini-300x300.jpg'),
                     img(id = "centri_naz", src = 'italia_def_mini-300x300.jpg'),
                     img(id = "centri_reg", src = 'regio_def_mini-300x300.jpg')))),

## 6.1 internazionali----    

tabItem(tabName = "centri_int",
            fluidRow(
              shinydashboard::box(
                class = "box_img_centri",
                solidHeader = TRUE,
                width = NULL,
                height = 350,
                tags$div(class = "box_text_centri",
                  tags$p("IZSLER"),
                  tags$hr(),
                  tags$p("CENTRI DI REFERENZA INTERNAZIONALI")
                  )
                )
              ),
        fluidRow(tags$div(class = "dttable_centri",
                          tags$h1("CENTRO DI REFERENZA FAO", style="text-align: center;background-color: #375a7f;font-size: 32px;font-family: 'Montserrat'; font-weight: 400;color:#fff;"),
          dataTableOutput("dttable_int_fao"),
                          tags$h1("LABORATORI DI REFERENZA OIE", style="text-align: center;background-color: #375a7f;font-size: 32px;font-family: 'Montserrat'; font-weight: 400;color:#fff;"),
          dataTableOutput("dttable_int_oie"),
                          tags$h1("CENTRO DI COLLABORAZIONE OIE", style="text-align: center;background-color: #375a7f;font-size: 32px;font-family: 'Montserrat'; font-weight: 400;color:#fff;"),
          dataTableOutput("dttable_int_col_oie"),
                          tags$h1(".", style="text-indent:-9999px; text-align: center;background-color: #375a7f;font-size: 32px;font-family: 'Montserrat'; font-weight: 400;color:#fff;"),
          dataTableOutput("dttable_int")
        )
        )),

## 6.2 nazionali----    

tabItem(tabName = "centri_naz",
            fluidRow(
              shinydashboard::box(
                class = "box_img_centri",
                solidHeader = TRUE,
                width = NULL,
                height = 350,
                tags$div(class = "box_text_centri",
                  tags$p("IZSLER"),
                  tags$hr(),
                  tags$p("CENTRI DI REFERENZA NAZIONALI")
                  )
                )
              ),
        fluidRow(tags$div(class = "dttable_centri",
          dataTableOutput("dttable_naz")
        )
        )),

## 6.3 regionali----    

tabItem(tabName = "centri_reg",
            fluidRow(
              shinydashboard::box(
                class = "box_img_centri",
                solidHeader = TRUE,
                width = NULL,
                height = 350,
                tags$div(class = "box_text_centri",
                  tags$p("IZSLER"),
                  tags$hr(),
                  tags$p("CENTRI DI REFERENZA REGIONALI")
                  )
                )
              ),
        fluidRow(tags$div(class = "dttable_centri",
                          tags$h1("REGIONE LOMBARDIA", style="text-align: center;background-color: #375a7f;font-size: 32px;font-family: 'Montserrat'; font-weight: 400;color:#fff;"),
          dataTableOutput("dttable_reg_lom"),
                          tags$h1("REGIONE EMILIA-ROMAGNA", style="text-align: center;background-color: #375a7f;font-size: 32px;font-family: 'Montserrat'; font-weight: 400;color:#fff;"),
          dataTableOutput("dttable_reg_emi")
        )
        )),




# 7. linee di ricerca----    
    tabItem(tabName = "linee")
)
)


# UI----
ui <- dashboardPage(title="Portale della Ricerca",header, sidebar, body,
## FOOTER ----
                    footer = dashboardFooter(
                      HTML(
                        paste0("<p>",
                        "Istituto Zooprofilattico Sperimentale della Lombardia e dell'Emilia Romagna &quot;BRUNO UBERTINI&quot;",
                        "<a href='https://it.linkedin.com/company/izsler' target='_blank'>",
                        "&nbsp&nbsp&nbsp&nbsp",
                        "<i class='fa fa-linkedin' aria-hidden='true'></i>",
                        "</a>",
                        "<a href='https://twitter.com/izsler' target='_blank'>",
                        "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp",
                        "<i class='fa fa-twitter' aria-hidden='true'></i>",
                        "</a>",
                        "</p>")
                        )
                      )
)















#LOGO A SINISTRA
# ## 1. header
# header <- 
#   dashboardHeader(title = HTML("Portale della Ricerca"),
#                   titleWidth  = 280,
#                   tags$li(a(href = 'https://www.izsler.it/',
#                              img(src = 'logo.png',
#                               title = "IZSLER", height = "30px"),
#                                style = "padding-top:10px; padding-bottom:10px;"),
#                                class = "dropdown"))