### CreateMemberColorList ###
#Creates a color list for the given members Each member gets assigned one color.
#By default each member is assigned a gray color. If the user has selected to highlight
#members then the color of said members are changed to a color. The assigned member colors are 
#automatically assinged in such a way that ensures contrasts.
#
#input:         The systems input variable, allows accessing of input fields in the user interface
#colours:       A reactive list of colours
#members:       A list of members to create color list for
#paramater:     The paramater of the plot that the colors get assigned
#rePlot:        A boolean value telling the method if it has been triggered by
#               The plot button, or the interactive apply button. False if triggered from plot
#               TRUE if triggered from apply
createMemberColorList <- function(input, colours, members, param, rePlot){
    # Helper function to convert HSL to Hex
    hsl_to_hex <- function(h, s, l) {
        h <- h / 360
        s <- s / 100
        l <- l / 100
    
        c <- (1 - abs(2 * l - 1)) * s
        x <- c * (1 - abs((h * 6) %% 2 - 1))
        m <- l - c / 2
        r <- g <- b <- 0
    
        if (h >= 0 && h < 1/6) {
            r <- c; g <- x; b <- 0
        } else if (h >= 1/6 && h < 1/3) {
            r <- x; g <- c; b <- 0
        } else if (h >= 1/3 && h < 1/2) {
            r <- 0; g <- c; b <- x
        } else if (h >= 1/2 && h < 2/3) {
            r <- 0; g <- x; b <- c
        } else if (h >= 2/3 && h < 5/6) {
            r <- x; g <- 0; b <- c
        } else if (h >= 5/6 && h <= 1) {
            r <- c; g <- 0; b <- x
        }
    
        r <- floor((r + m) * 255)
        g <- floor((g + m) * 255)
        b <- floor((b + m) * 255)
    
        rgb_to_hex <- function(val) {
            hex <- as.hexmode(val)
            if (nchar(hex) == 1) hex <- paste0("0", hex)
            return(hex)
            }
    
            paste0("#", rgb_to_hex(r), rgb_to_hex(g), rgb_to_hex(b))
    }

    numbMembers <- length(members)
    hues <- seq(0, 360, length.out = numbMembers + 1)[1:numbMembers]


    colours$data <- sapply(seq_along(members), function(i) {
        member <- members[i]
        if (member %in% input[[paste0("HighlightedMembers", param)]] && rePlot) {
            hsl_to_hex(hues[i], 70, 50)  # Using a fixed saturation and lightness for consistency
        } else {
            "#D3D3D3"
        }
    })
}