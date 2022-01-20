?
SERVER <- function(){
library(shiny)
library(ggplot2)
library(dplyr)
library(RMySQL)

inputs <- list('OCR Average' ,
               "OCR %CV" ,
               "Gain Average" ,
               "Gain %CV" ,
               ">2 Oultiers" ,
               '%Outliers')

con <- adminKraken::con_dplyr()


choices <- c('OCR_avg' ,
             "OCR_cv" ,
             "Gain_avg",
             "Gain_cv",
             "n_OL_greater",
             'avg_percent_ol')

ylab <- c("pmol/min",
          "%cv",
          "counts/mpH",
          "%cv",
          "count",
          "%")

threshold <- list(lower = c(70, NA, 13, NA, NA, NA),
                  upper = c(250, 12, NA, 10, NA, 100 * (2 / 96)))

shinyServer(function(input, output) {
    observeEvent(input$n, {
        n <- as.numeric(input$n)

        output$distPlot <- renderPlot({
            #DATA
             tbl(con, "NB_LOT_VIEW") %>%
                select(Lot,var=matches(choices[n])) %>%
                collect() %>%
                ggplot(. , aes(Lot, var)) +
                geom_line(col = 'blue', group = 1) +
                geom_point(col = 'blue', size = 2.3) +
                theme_bw()  +
                geom_hline(
                    aes(yintercept = threshold$lower[n]),
                    group = 1,
                    col = 'red',
                    lty = 2
                ) +
                geom_hline(aes(yintercept = threshold$upper[n]),
                           col = 'red',
                           lty = 2) +
                ggtitle(inputs[n]) +
                ylab(ylab[n])
        })
    })

    ###### data upload
    observeEvent(input$uploadxl, {
        D <- NULL
        D <- new.env()
        D$up <- input$uploadxl
        D$meta <- purrr::map_df(D$up$name, meta)
        D$data <-
            purrr::map_df(setNames(D$up$datapath, D$up$name),
                                        SUPER,
                                        .id = 'file')
        #### Upload ####
        D$con <- adminKraken::con_mysql()
        upload_meta(D$meta,D$con)
        upload_data(D$data,D$con)
        RMySQL::dbDisconnect(D$con)
    })
})
}
