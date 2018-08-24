require(ggplot2)
require(CellTrails)

###############################################################################
# Generate example data w/ 3 conditions
###############################################################################
set.seed(1101)
dafr <- data.frame(X=factor(sample(1:3, 100, replace=TRUE)), 
                   Y=abs(rnorm(100, mean=12)))

###############################################################################
# Create plot
###############################################################################
p <- ggplot(data=dafr, aes(x=X, y=Y, fill=X)) + 
  geom_violin(trim=TRUE, scale="width", adjust=1/2) +
  geom_boxplot(width=0.05, fill="white") + 
  labs(title='Expression per Condition', x="Condition", y="Expression") +
  scale_fill_manual(name="#Samples", 
                    labels=table(dafr$X), 
                    values=CellTrails:::.color_hue(length(levels(dafr$X)))) + 
  theme_minimal() + theme(axis.line=element_line())

# Show plot
show(p)