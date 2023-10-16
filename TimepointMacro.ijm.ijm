setBatchMode(true);
path = "C:/Users/travermk/Desktop/2023_0911 Tatiane/New folder/";
files = getFileList(path);

for (j = 0; j < files.length; j++) {
	if (endsWith(files[j], ".czi") == 1) {

		image = files[j];
		address = path + image;
		
		run("Bio-Formats Importer", "open=[" + address + "] view=Hyperstack stack_order=XYCZT");
		num = nSlices/3;
				
		for (i = 1; i <= num; i++) {
			run("Make Subset...", "channels=1-3 frames="+i);
			saveAs("tif", address + " t=" + i + ".tif");
			close();
		}

		close("*");		
	}
}
