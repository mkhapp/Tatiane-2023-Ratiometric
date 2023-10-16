setBatchMode(true);
path = "C:/Users/travermk/Desktop/New folder/";
files = getFileList(path);

for (i = 0; i < files.length; i++) {
	if (endsWith(files[i], ".tif")==1) {
		open(path+files[i]);
		run("Split Channels");
		imageCalculator("Add create 32-bit", "C1-"+files[i],"C3-"+files[i]);
		run("Grays");
		run("Despeckle");
		saveAs("tif", path+files[i]+"_C1+C3.tif");
		close("*");
	}
}
