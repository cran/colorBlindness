## ---- echo=FALSE, results="hide", warning=FALSE-------------------------------
suppressPackageStartupMessages({
  library(colorBlindness)
  library(ggplot2)
  library(reshape2)
})
knitr::opts_chunk$set(warning=FALSE, message=FALSE, eval=TRUE)

## ----fig.width=9,fig.height=9-------------------------------------------------
library(colorBlindness)
mat <- matrix(1:81, nrow = 9, ncol = 9)

library(ggplot2)
library(reshape2)
mat1 <- melt(t(mat[9:1, ]))
len <- length(Blue2DarkRed12Steps)-1
mat1$v2 <- cut(mat1$value,
              breaks = seq(0,ceiling(81/len)*len, 
                           length.out = len+1))
ht <- ggplot(mat1) + 
  geom_tile(aes(x=Var1, y=Var2, fill=v2)) + 
  scale_fill_manual(values=Blue2DarkRed12Steps) + 
  theme_bw()
# check the plot by CVD simulator
cvdPlot(ht)

## -----------------------------------------------------------------------------
cvdPlot(replacePlotColor(displayColors(c("Red", "Green", "blue"))))

## -----------------------------------------------------------------------------
library(grid)
library(png)
path <- system.file("extdata", package = "colorBlindness")
img <- readPNG(file.path(path, "fluorescence.microscopy.images.png"))
g <- rasterGrob(img, interpolate=TRUE)
grid.draw(cvdPlot(g, 
                  layout = c("origin", "deuteranope", "protanope",
                             "enhanced", "enhanced.deuteranope", 
                             "enhanced.protanope")))
newImg <- replacePlotColor(g)
outfile <- tempfile(fileext = ".png")
png(outfile)
grid.draw(newImg)
dev.off()

## -----------------------------------------------------------------------------
pdf.options()[c("width", "height", "pointsize")]
setPDFopt()
pdf.options()[c("width", "height", "pointsize")]

## -----------------------------------------------------------------------------
displayAvailablePalette(color="white")

## -----------------------------------------------------------------------------
displayAllColors(safeColors, color="white")

## -----------------------------------------------------------------------------
## replace the color of a file

ishihara29 <- system.file("extdata", "Plate3.png", package = "colorBlindness")
library(png)
img <- readPNG(ishihara29)
g <- rasterGrob(img, interpolate=TRUE)
grid.draw(cvdPlot(g, 
                  layout = c("origin", "deuteranope", "protanope",
                             "enhanced", "enhanced.deuteranope", 
                             "enhanced.protanope")))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

