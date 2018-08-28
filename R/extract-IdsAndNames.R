require(CellTrails)
data(exSCE)
set.seed(1101)

###############################################################################
# Function to extract Ids and Symbol names from id_symbol tags
# @param tags character vector containing the id_symbol tags
# @return Names and Ids
###############################################################################
extractIdsAndNames <- function(tags) {
  rnsplit <- strsplit(rownames(exSCE), "_")
  ids <- lapply(rnsplit, 
                function(x) x[1])
  ids <- unlist(ids)
  
  nms <- lapply(rnsplit, 
                function(x){
                  ifelse(length(x) > 1, 
                         paste(x[2:length(x)], collapse="_"), 
                         x[1])})
  nms <- unlist(nms)
  data.frame(Ids=ids, Names=nms, stringsAsFactors=FALSE)
}

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
idsNms <- extractIdsAndNames(rownames(exSCE))
head(idsNms)

# Set Ids and symbol names to SingleCellExperiment object
rowData(exSCE)$GeneId <- idsNms$Ids
rownames(exSCE) <- idsNms$Names
# OR
rowData(exSCE)$Symbol <- idsNms$Names
rownames(exSCE) <- idsNms$Ids