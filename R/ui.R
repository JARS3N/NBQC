UI<-function(){
inputs<- list(
    'OCR Average' ,
    "OCR %CV" ,
    "Gain Average" ,
    "Gain %CV" ,
    ">2 Outliers" ,
    '%Outliers' 
)
input_list<-setNames(1:6,inputs)

library(shiny)

shinyUI(fluidPage(
    titlePanel("NON-BIO PLATE QC"),
    sidebarLayout(sidebarPanel(
        width = 2,
        selectInput(
            "n",
            label = h3("Select box"),
            choices = input_list
            ,
            selected = 1
        )
    ),
    mainPanel(
        tabsetPanel(
            type = "tabs",
            tabPanel("Control Charts",
                     plotOutput("distPlot"),
                     h1("Variable Definitions:"),
                     p("OCR Average: The Lot average of the OCR average by assay"),
                     p("OCR %CV: The Lot average of the OCR %CV by assay"),
                     p("Gain Average: The Lot average of the Gain average by assay"),
                     p("Gain %CV: The Lot average of the Gain %CV by assay"),
                     p(">2 Outliers: The number of assays in the Lot with > 2 outliers"),
                     p("%Outliers: The %average of Wells flagged as a level outlier in the Lot")
                     
                     ),
            tabPanel("Data Upload", 
                     fileInput(
                         "uploadxl",
                         "XL upload",
                         multiple = TRUE,
                         accept = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                         width = NULL,
                         buttonLabel = "Browse...",
                         placeholder = "No file selected"
                     ),
                     h3("Instructions"),
                     p("select all relevant Excel files, multiselect by holding down shift and using the arrow keys OR holding down the Control and selecting each file"),
                     h3("Warnings:"),
                     p("Lot is pulled from the file name looking for Lot-[any sequence of digits]."),
                     p("strata & order are pulled from the file name by searching for (start,mid,end) followed by any sequence of digits."),
                     h4("!!if the filenames are missing either one,it will likely throw an error and crash the app.!!")
                     )
        )
    ))
))
}