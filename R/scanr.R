##' Returns the functions for each file in
##' @title Scan your scripts folders for the functions you are looking
##'     for
##' @param pattern a regular expression that matches what you are
##'     looking for
##' @param path where to look for your R files
##' @param file_extension the extension for your R files (or other
##'     regular expression) to match some files
##' @param ... additional arguments to be passed to \code{grepl} to
##'     match the regular expression for what you are looking for
##' @return a tibble
##' @export
##' @importFrom purrr map_df
##' @importFrom tibble data_frame
##' @importFrom dplyr %>% filter mutate
scanr <- function(pattern, path = "R", file_extension = "(r|R)$", ...) {
    res <- list.files(path = path, pattern = file_extension, full.names = TRUE) %>%
        purrr::map_df(function(x) {
                   e <- new.env(parent = .GlobalEnv)
                   on.exit(rm(e))
                   sys.source(x, envir = e)
                   r <- ls(envir = e)
                   tibble::data_frame(file = rep(basename(x), length(r)),
                                      functions = r)
               })

    if (!missing(pattern)) {
        res <- res[grepl(pattern = pattern, x = res$functions, ...), ]
        res$with_marks <- mark_matches(res$functions, pattern)
    }
    structure(res, class = c("scanr", class(res)))
}


print.scanr <- function(r) {
    .r <- split(r, r$file)
    lapply(names(.r), function(f) {
        cat(f, ":\n", sep = "")
        if (exists("with_marks", .r[[f]]))
            fns <- .r[[f]]$with_marks
        else fns <- .r[[f]]$functions
        lapply(fns, function(fn) {
            cat("   ", fn, "\n")
        })
    })
    invisible(r)
}


##' @importFrom crayon white bgGreen combine_styles
mark_matches <- function(text, pattern, marker = NULL) {

  if (is.null(marker)) {
    marker <- crayon::combine_styles(crayon::white, crayon::bgGreen)
  }

  vapply(
    tolower(text),
    .mark_matches,
    character(1),
    pattern = pattern,
    marker = marker,
    USE.NAMES = FALSE
  )
}

.mark_matches <- function(text1, pattern, marker) {
  word_pos <- gregexpr(pattern, text1)
  if (length(word_pos[[1]]) == 1 && word_pos == -1) return(text1)
  start <- c(word_pos[[1]])
  end <- start + attr(word_pos[[1]], "match.length") - 1
  words <- substring(text1, start, end)

  regmatches(text1, word_pos) <- marker(words)
  text1
}
