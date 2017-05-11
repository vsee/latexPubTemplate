library(ggplot2)
library(reshape2)

options(echo=FALSE) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)
# args[1] = "/home/vseeker/Documents/TACO_2017_lag_marking/data/freqprofiles.csv"
# args[2] = "/home/vseeker/workspace/tmp"
freqDataFile <- args[1]
outDir <- args[2]
rm(args)

freqData <- read.csv(freqDataFile)
freqData$time <- freqData$time / 1000000

freqData.molten <- melt(freqData, id.vars = c("time"),
                              measure.vars = c("ondemand", "optimal"),
                              variable.name = "technique", 
                              value.name = "freq")
freqData.molten$freq <- freqData.molten$freq / 1000000

pdf(file=paste(outDir,"/freqProfileMotivation.pdf",sep=""),
    width = 10, height = 3, pointsize = 12, bg = "white")

ggplot(freqData.molten, aes(x=time, y=freq, color=technique, size=technique)) + 
  geom_line() +
  theme_bw() +
  labs(y="Frequency in GHz", x="Time in S") + 
  scale_y_continuous(breaks = c(0.30,0.42,0.65,0.73,0.88,0.96,1.04,1.19,1.27,1.50,1.57,1.73,1.96,2.15)) + 
  scale_x_continuous(breaks = seq(round(min(freqData$time),0), max(freqData$time), by = 2)) +
  scale_colour_manual(name="Technique",
                      values=c("ondemand"="grey","optimal"="red"),
                    breaks=c("ondemand", "optimal"),
                    labels=c("Ondemand", "Oracle"),
                    guide = guide_legend(override.aes = list(
                      colour = c("grey","red"),
                      size = c(0.5,2)))) +
  scale_size_manual(values=c("ondemand"=0.5,"optimal"=2),
                    breaks=c("ondemand", "optimal"), guide=FALSE) +
  theme(legend.position = c(0.1,0.8),
        axis.text.y=element_text(size=7))

dev.off()
