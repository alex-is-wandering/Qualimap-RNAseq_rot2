#install.packages("ggplot2")
#install.packages("reshape2")

tabled_QC_results <- read.delim("/local/storage/user/project/hereliesdata/QualimapOutput/tabled_QC_results.txt")

library(ggplot2)
library(reshape2)


graphing <- tabled_QC_results[, c("Exonic", "Intronic")]

graphing$PercentAligned = (tabled_QC_results$Reads.Aligned/tabled_QC_results$Total.Alignments)*100

graphing$Exonic <- as.numeric(sub("%", "", graphing$Exonic))
graphing$Intronic <- as.numeric(sub("%", "", graphing$Intronic))

str(graphing)

melted_data <- melt(graphing)

means <- aggregate(value~variable, data=melted_data, FUN=mean)

my_plot <- ggplot(melted_data, aes(x=variable, y=value)) +
    geom_boxplot(fill="white",color="black",alpha=0.7) +
    geom_text(data=means, aes(label=round(value,2),y=value+10), size=3, vjust=-0.5,color="black") +
    labs(title = "Reads vs Reference", x="Genome Alignments", y="% of Total Reads") +
    theme_classic()

