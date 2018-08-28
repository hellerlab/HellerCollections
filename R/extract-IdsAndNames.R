require(CellTrails)
data(exSCE)
set.seed(1101)

###############################################################################
# Example data
###############################################################################
rnames <- vapply(seq_len(25), 
                 function(x){
                   paste(paste("ENSG", x, sep=""), 
                         paste(sample(c(letters, "_"), 10), collapse=""), 
                         sep="_")}, "")
rownames(exSCE) <- rnames

###############################################################################
# Extract Ids and Symbol names
###############################################################################
# Split row names
rnsplit <- strsplit(rownames(exSCE), "_")

# Extract Ids
ids <- lapply(rnsplit, 
              function(x) x[1])
ids <- unlist(ids)

# Extract symbol names
nms <- lapply(rnsplit, 
              function(x){
                ifelse(length(x) > 1, 
                       paste(x[2:length(x)], collapse="_"), 
                       x[1])})
nms <- unlist(nms)

# Set Ids and symbol names to SingleCellExperiment object
rowData(exSCE)$GeneId <- ids
rownames(exSCE) <- nms
# OR
rowData(exSCE)$Symbol <- nms
rownames(exSCE) <- ids