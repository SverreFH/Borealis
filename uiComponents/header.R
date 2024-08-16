headerUI <- function() {

    # PAGE HEADER
    # The header of the page including the logo and the title of the page
    div( class = "Header",
        div(class = "header-container",
            tags$img(src = "BorealisLogo.png", height = 75, width = 75, style = "filter: invert(100%);"),
            div(class = "header-title", "Borealis")
        )
    )
}
