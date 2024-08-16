### CreateColorList ###
#Creates a color list for the given experiments. Each experiment gets assigned one color.
#The color can either be assigned automatically or through entering a color in a experiments
#corresponding styling card. When automatically asignign, the method ensures that all assigned 
#colors have good contrast to eachother. Additionaly automatically assigned colors are always the
#same between method calls. 
#
#input:         The systems input variable, allows accessing of input fields in the user interface
#colours:       A reactive list of colours
#experiments:   A list of experiments to create color list for
CreateColorList <- function(input, colours, experiments) {

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

    num_experiments <- length(experiments)
    hues <- seq(0, 360, length.out = num_experiments + 1)[1:num_experiments]

    colours$data <- sapply(seq_along(experiments), function(i) {
        experiment <- experiments[i]
        color <- input[[paste0("color_", experiment)]]
        if (is.null(color) || color == "#FFFFFF") {
            hsl_to_hex(hues[i], 70, 50)  # Using a fixed saturation and lightness for consistency
        } else {
            color
        }
    })
}