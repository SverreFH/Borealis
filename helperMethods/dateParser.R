### DateParser ###
#Gets the daterange from a orginal file name
#
#exp:   the filname to parse the daterange from
dateParser <- function(exp){
    pattern <- "\\.harp\\.(\\d{10}-\\d{10})\\.harp\\."

    matches <- regmatches(exp, gregexpr(pattern, exp))

    if (length(matches[[1]]) > 0) {
        return(sub(pattern, "\\1", matches[[1]]))
    } else {
        return(NA)
    }
}