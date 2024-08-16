### GetUserID ###
# Gets and returns the users id from the current working directory
GetUserId <- function(){
    workingDirectory <- getwd()
    path_parts <- strsplit(workingDirectory, "/")[[1]]
    user_id <- path_parts[6]
    return(user_id)
}