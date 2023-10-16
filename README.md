# Tatiane-2023-Ratiometric

## Purpose
Tatiane is measuring intracellular pH microenvironments using a ratiometric fluorescent marker. This repository stores code that aids in analyzing the ratiometric fluorescence output of large numbers of cells.

## Workflow
1) Use CroppingMacro to divide 3x3 tiled images to separate images, or use TimepointMacro to split up timepoints into separate images.
2) Use AddC1toC3Macro to make combined 458-488 images for segmentation.
3) Use CellposeBatchSegmentation ipynb in cellpose environment to make segmentation ROIs.
4) Use MeasuringMacro to measure 458, 488, and ratio intensities.
5) If necessary, use TatianeColumnCombiner to combine data columns from individual tiles.
