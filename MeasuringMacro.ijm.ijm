
//put path to files here:
path = "C:/Users/travermk/Desktop/Tatiane/Tifs2/";

setBatchMode(true);
run("Set Measurements...", "mean redirect=None decimal=4");
files = getFileList(path);
Table.create("Final Ratio Results");
Table.create("Final Blue Results");
Table.create("Final Yellow Results");

for (i = 0; i < files.length; i++) {
	if (endsWith(files[i], ".tif")==1) {
		open(path+files[i]);
		roiManager("open", path+files[i]+"_C1_rois.zip");
		
		//measure blue and yellow
		yellow = newArray(0);
		blue = newArray(0);
		
		Stack.setChannel(1);
		roiManager("measure");
		yellow = Table.getColumn("Mean", "Results");
		run("Clear Results");
		
		Stack.setChannel(3);
		roiManager("measure");
		blue = Table.getColumn("Mean", "Results");
		run("Clear Results");
		
		yellowbckgnd = 1700;
		bluebckgnd = 2150;
		
		for (j = 0; j < yellow.length; j++) {
			yellow[j] = yellow[j] - yellowbckgnd;
		}
		
		for (j = 0; j < blue.length; j++) {
			blue[j] = blue[j] - bluebckgnd;
		}
				
		//get the ratio
		ratio = newArray(0);
		for (j = 0; j < yellow.length; j++) {
			ratio[j] = yellow[j] / blue[j];
		}
				
		Table.setColumn(files[i] + " ratio", ratio, "Final Ratio Results");
		Table.setColumn(files[i] + " blue", blue, "Final Blue Results");
		Table.setColumn(files[i] + " yellow", yellow, "Final Yellow Results");
		
		roiManager("reset");
		close("*");
	}
}

Table.save(path+"Results/RatioResults.csv", "Final Ratio Results");
Table.save(path+"Results/BlueResults.csv", "Final Blue Results");
Table.save(path+"Results/YellowResults.csv", "Final Yellow Results");

print("Finished!")
