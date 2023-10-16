setBatchMode(true);
path = "C:/Users/travermk/Desktop/New folder/";
files = getFileList(path);

for (j = 0; j < files.length; j++) {
	if (endsWith(files[j], ".czi") == 1) {

		image = files[j];
		address = path + image;
		Xvalues = newArray(0,1,2,0,1,2,0,1,2);
		Yvalues = newArray(0,0,0,1,1,1,2,2,2);

		for (i = 1; i <= 9; i++) {
			run("Bio-Formats Importer", "open=[" + address + "] view=Hyperstack stack_order=XYCZT");
			X = Xvalues[i-1]*512;
			Y = Yvalues[i-1]*512;
			makeRectangle(X, Y, 512, 512);
			run("Crop");
			saveAs("tif", address + " tile" + i + ".tif");
			close("*");
		}
	}
}
