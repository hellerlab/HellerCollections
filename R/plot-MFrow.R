require(CellTrails)
data(exSCE)
set.seed(1101)

###############################################################################
# Function to plot multiple ggplots
# mfrow stands for "Multiple Figures (use ROW-wise)"
# A grid is generated to show multiple ggplots at once
# Please note that the size of the grid needs to match the size of the list
# @param ggplots A list with ggplot objects
# @param n Rows in the grid
# @param m Columns in the grid
# @author Daniel C. Ellwanger
###############################################################################
plotMFrow <- function(ggplots, n_rows, n_columns){
  gSize <- prod(n_rows, n_columns)
  if(length(ggplots) > gSize) {
    warning("Grid is too small. Showing only the first ", prod(n_rows, n_columns), 
            " plots of ", length(ggplots), " plots total.")}
  grid::grid.newpage()
  grid::pushViewport(grid::viewport(layout=grid::grid.layout(n_rows, n_columns)))
  for(i in seq_len(gSize)){
    cindx <- (i - 1) %% n_columns + 1
    rindx <- (i - 1) %/% n_columns + 1
    vp <- grid::viewport(layout.pos.row=rindx, layout.pos.col=cindx)
    print(ggplots[[i]], vp=vp)
  }
}

###############################################################################
# Plot manifold for multiple genes
###############################################################################
# Generate single plots for first 6 features
viz <- lapply(seq_len(6), 
              function(i){
                plotManifold(exSCE, 
                             color_by="featureName", 
                             name=featureNames(exSCE)[i])
})

# Visualize multiple plots
plotMFrow(viz, n_columns=3, n_rows=2)
