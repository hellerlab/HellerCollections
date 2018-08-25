require(CellTrails)
set.seed(1101)

###############################################################################
# Example data
###############################################################################
expr <- simulate_exprs(10, 10, "")
rnames <- rep(NA, 10)
for(i in seq_along(rnames)) {
  ri <- sample(1000:10000, 1)
  rn <- paste0(sample(c(letters, "_"), 10), collapse="")
  rnames[i] <- paste0(c(ri, rn), collapse="_")
}
rownames(expr) <- rnames
sce <- SingleCellExperiment(assays=list(logcounts=expr))

###############################################################################
# Extract Ids and Symbol names
###############################################################################
# Split row names
rnsplit <- strsplit(rownames(sce), "_")

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
rowData(sce)$GeneId <- ids
rownames(sce) <- nms
# OR
rowData(sce)$Symbol <- nms
rownames(sce) <- ids