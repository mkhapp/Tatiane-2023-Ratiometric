setBatchMode(true);
path = "C:/Users/travermk/Desktop/Tatiane Nov15 Take2/";
files = getFileList(path);

for (i = 0; i < files.length; i++) {
	if (endsWith(files[i], ".tif")==1) {
		open(path+files[i]);
		run("Split Channels");
		selectWindow("C1-"+files[i]);
		run("Grays");
		run("Despeckle");
		saveAs("tif", path+files[i]+"_C1.tif");
		close("*");
	}
}
