require(CellTrails)
require(ggplot2)
data(exSCE)
set.seed(1101)

###############################################################################
# Generate example data
###############################################################################
dafr <- reshape::melt(data.frame(X=states(exSCE), Y=logcounts(exSCE)[1, ]))

###############################################################################
# Create plot
###############################################################################
p <- ggplot(data=dafr, aes(x=X, y=value, fill=X)) + 
  geom_violin(trim=TRUE, scale="width", adjust=1/2) +
  geom_boxplot(width=0.05, fill="white") + 
  labs(title='Expression per State', x="State", y="Expression") +
  scale_fill_manual(name="#Samples", 
                    labels=table(dafr$X), 
                    values=CellTrails:::.color_hue(length(levels(dafr$X)))) + 
  theme_minimal() + theme(axis.line=element_line())

# Show plot
show(p)