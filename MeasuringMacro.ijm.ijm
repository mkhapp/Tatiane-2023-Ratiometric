
//put path to files here:
path = "C:/Users/travermk/Desktop/Tatiane Nov15/";

setBatchMode(true);
run("Set Measurements...", "mean redirect=None decimal=4");
files = getFileList(path);
Table.create("Final Results");

for (i = 0; i < files.length; i++) {
	if (endsWith(files[i], ".tif")==1) {
		open(path+files[i]);
		roiManager("open", path+files[i]+"_C1+C3_rois.zip");
		
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
		
		//background subtract blue and yellow
		roiManager("deselect");
		roiManager("combine");
		run("Make Inverse");
		Stack.setChannel(1);
		run("Measure");
		Stack.setChannel(3);
		run("Measure");
		yellowbckgnd = Table.get("Mean", 0, "Results");
		bluebckgnd = Table.get("Mean", 1, "Results");
		run("Clear Results");
		
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
				
		Table.setColumn(files[i] + " ratio", ratio, "Final Results");
		
		roiManager("reset");
		close("*");
	}
}

Table.save(path+"Results.csv", "Final Results");
print("Finished!")

