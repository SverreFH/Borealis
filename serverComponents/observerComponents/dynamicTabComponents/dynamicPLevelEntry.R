#Dynamically creates a p level selection field if a applicable tab with a applicable paramaters has
#been selected, sets the default selected value of the input to equal the curren p value. 
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#pValues:           a list of paramaters and their associated p values
#system_update      A boolean that tells the method if it being triggerec by a user or the system
DynamicPlevelEntry <- function(input, output, session, pValues, system_update) {
    if(!system_update()){
        param <- input$dynamicTabs
            currentPValues <- pValues()
            lev <- currentPValues[[param]]
            print(lev)

            if (input$dynamicTabs %in% c("Q", "RH", "S", "T", "Td", "Z")) {
                output$PLevelSelector <- renderUI({
                    selectInput("Plevel", "P-level:",
                        choices = c("50" = 50, "100" = 100, "150" = 150, "200" = 200, "300" = 300, "400" = 400, "500" = 500, "700" = 700, "850" = 850, "925" = 925, "1000" = 1000),
                        width = "90%", selected = lev)
                })
            } else {
                output$PLevelSelector <- renderUI({
                    # Placeholder text when condition is not met
                    tagList(
                        p("")
                    )
            })
        }
    }
}