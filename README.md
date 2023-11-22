# Tatiane-2023-Ratiometric

## Purpose
Tatiane is measuring intracellular pH microenvironments using a ratiometric fluorescent marker. This repository stores code that aids in analyzing the ratiometric fluorescence output of large numbers of cells.

## Workflow
1) Use CroppingMacro to divide 3x3 tiled images to separate images, or use TimepointMacro to split up timepoints into separate images.
2) Use AddC1toC3Macro to make combined "blue" (405 or 440 or 458)-488 images for segmentation OR use KeepC1OnlyMacro to split out the "yellow" (488) channel for segmentation.  The latter provides slightly tighter ratio results because of it removes the smeary background of the blue channel, but it can't be used for untransfected cells because there isn't enough autofluorescence in the yellow channel for segmentation.
3) Use CellposeBatchSegmentation ipynb in cellpose environment to make segmentation ROIs.
4) Use MeasuringMacro to measure ratio of intensities following background subtraction; be sure to comment out the parts that you don't need (choose cell-outline based background subtraction or choose a single manually calculated value, choose ratio or blue intensity or yellow intensity).
5) If necessary, use TatianeColumnCombiner to combine data columns from individual tiles; use the CombinerwithNames to get column titles automatically.
