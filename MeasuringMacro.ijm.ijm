
//put path to files here:
path = "C:/Users/travermk/Desktop/New folder/";

setBatchMode(true);
run("Set Measurements...", "mean redirect=None decimal=4");
files = getFileList(path);
Table.create("Final Results");

for (i = 0; i < files.length; i++) {
	if (endsWith(files[i], ".tif")==1) {
		open(path+files[i]);
		roiManager("open", path+files[i]+"_C1+C3_rois.zip");
		
		yellow = newArray(0);
		blue = newArray(0);
		ratio = newArray(0);
		
		Stack.setChannel(1);
		roiManager("measure");
		yellow = Table.getColumn("Mean", "Results");
		run("Clear Results");
		
		Stack.setChannel(3);
		roiManager("measure");
		blue = Table.getColumn("Mean", "Results");
		run("Clear Results");
		
		for (j = 0; j < yellow.length; j++) {
			ratio[j] = yellow[j] / blue[j];
		}
				
		//Table.setColumn(files[i] + " yellow", yellow, "Final Results");
		Table.setColumn(files[i] + " blue", blue, "Final Results");
		//Table.setColumn(files[i] + " ratio", ratio, "Final Results");
		
		roiManager("reset");
		close("*");
	}
}

Table.save(path+"CyanResults.csv", "Final Results");
print("Finished!")

