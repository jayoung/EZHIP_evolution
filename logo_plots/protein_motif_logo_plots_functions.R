

##### get_most_common_eachPos: a function that takes a PCM and returns the most common residue at each position.
## if there's a tie we arbitrarily choose
get_most_common_eachPos <- function(my_pcm) {
    row_ids <- rownames(my_pcm)
    result_each_pos <- apply(my_pcm, 2, function(x) {
        most_common <- which.max(x)[1]
        output <- list(residue=row_ids[most_common], freq=x[most_common]/sum(x))
        return(output)
    })
    results <- tibble(pos = 1:length(result_each_pos),
                      most_common = sapply(result_each_pos, "[[", "residue"),
                      most_common_freq = sapply(result_each_pos, "[[", "freq"))
    return(results)
}





###### logo plot color schemes



#### Our preferred color scheme, based on color scheme used here: https://weblogo.threeplusone.com/ 
##  code for weblogo color scheme is found here: https://github.com/gecrooks/weblogo/blob/master/weblogo/colorscheme.py
## and looks like this:
# chemistry = ColorScheme(
#     [
#         SymbolColor("GSTYC", "green", "polar"),
#         SymbolColor("NQ", "purple", "neutral"),
#         SymbolColor("KRH", "blue", "basic"),
#         SymbolColor("DE", "red", "acidic"),
#         SymbolColor("PAWFLIMV", "black", "hydrophobic"),
#     ],
#     alphabet=seq.unambiguous_protein_alphabet,
# )

##### reproduce that color scheme in R. First put the color scheme into a named character vector
weblogo_chemistry_color_scheme <- character()
## polar
for (x in strsplit("GSTYC", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "green3"
}
## neutral
for (x in strsplit("NQ", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "purple"
}
## basic
for (x in strsplit("KRH", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "blue"
}
## acidic
for (x in strsplit("DE", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "red"
}
## hydrophobic
for (x in strsplit("PAWFLIMV", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "black"
}

### use ggseqlogo::make_col_scheme
weblogo_chemistry_color_scheme_ggseqlogo <- make_col_scheme(
    chars=names(weblogo_chemistry_color_scheme),
    cols=weblogo_chemistry_color_scheme)

