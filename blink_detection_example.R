# read in example data
rm(list=ls())
source("https://raw.githubusercontent.com/datigrezzi/rGaze/master/blinks.R")
etData <- read.table("pupil_data_sample.tsv", header = T, sep = '\t', dec = '.')
head(etData)

x <- etData$pupilLeft
ts <- etData$timeStamp

# simple velocity filter
bidx <- artifact.idx(x, ts, threshold = 0.001)
# plots
lims <- c(2, 7)
timeLims <- c(min(ts), max(ts))
# timeLims <- c(110000, 120000) # select part of the data to plot

# png("example_artifact_detection.png", width = 720, height = 500) # save plot
par(mfrow=c(2,1), mar=c(3,3,2,1), mgp=c(2,0.4,0), las=1,tck=-.01, xaxs="i",yaxs="i", cex = 1.2, lwd=2, yaxt='l', tck=1)
plot(ts[ts > timeLims[1] & ts < timeLims[2]], x[ts > timeLims[1] & ts < timeLims[2]], type='l', ylim= lims, xlab='', ylab='Original Data (mm)')
title("Velocity-Based Artifact Filter", adj=1, cex.main=0.8, col.main="black")
plot(ts[bidx==0 & ts > timeLims[1] & ts < timeLims[2]], x[bidx==0 & ts > timeLims[1] & ts < timeLims[2]], type='l', ylim= lims, xlab='Timestamp (ms)', ylab='Filtered Data (mm)')
# dev.off() # close png file

# filter based on Mathot's algorithm
rbx <- remove.blinks(x, ts, threshold = 0.002, smooth=T)
# png("example_blink_detection.png", width = 720, height = 500) # save plot
par(mfrow=c(2,1), mar=c(3,3,2,1), mgp=c(2,0.4,0), las=1,tck=-.01, xaxs="i",yaxs="i", cex = 1.2, lwd=2, yaxt='l', tck=1)
plot(ts[ts > timeLims[1] & ts < timeLims[2]], x[ts > timeLims[1] & ts < timeLims[2]], type='l', ylim= lims, xlab='', ylab='Original Data (mm)')
title("Velocity-Based Blink Filter", adj=1, cex.main=0.8, col.main="black")
plot(ts[ts > timeLims[1] & ts < timeLims[2]], rbx[ts > timeLims[1] & ts < timeLims[2]], type='l', ylim= lims, xlab='Timestamp (ms)', ylab='Filtered Data (mm)')
# dev.off() # close png file