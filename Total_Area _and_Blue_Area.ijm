// Get the input directory containing the images
waitForUser("Action required","Input RAW Images");
inputDir = getDirectory("Input RAW Images");

// Get the output directory where the results will be saved
waitForUser("Action required","Output txt file");
outputDir = getDirectory("Output txt file");

// Get the output directory where the Images will be saved
waitForUser("Action required","Output Extracted Images");
ImgOutputDir = getDirectory("Extracted Images");

// Get a list of all the image files in the input directory
images = getFileList(inputDir);

// Loop through each image in the directory
for (i = 0; i < images.length; i++) {

    // Open the current image
    open(inputDir + images[i]);

    // Prompt the user for treatment/genotype info using a dialog box
    Dialog.create("Treatment/Genotype Info");
    Dialog.addString("Replication:", "Value");
    Dialog.addString("Glucose:", "Value");
    Dialog.addString("Auxin:", "Value");
    Dialog.addString("Bikinin:", "Value");
    Dialog.show();

    // Get the values entered by the user in the dialog box
    replication = Dialog.getString();
    glucose = Dialog.getString();
    auxin = Dialog.getString();
    bikinin = Dialog.getString();

    // Rename/Duplicate the image using the treatment/genotype info
    rename(replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin);
	run("Duplicate...", "title=" + replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin + "_Area");
	
	// Apply a median filter with a radius of 20 pixels
	run("Median...", "radius=25");
	
	// Convert the image to 8-bit to save memory
	run("8-bit");
	
	// Automatically determine the threshold using the MinError method and ignore white regions
	run("Auto Threshold", "method=MinError(I) ignore_white");
	
	// Set the measurements to calculate for particles
	run("Set Measurements...", "area center feret's display scientific add redirect=" + replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin + " decimal=3");
	
	// Set the scale to convert pixel measurements to physical distances
	run("Set Scale...", "distance=1000 known=25.4 unit=mm");
	
	// Analyze particles with a size range of 100-Inf pixels and summarize the results
	run("Analyze Particles...", "size=100-Infinity show=Overlay display clear summarize add");
	
	// Save the particle analysis results as a text file
	saveAs("Text", outputDir + "Total_Area_Results" + replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin + ".txt");
	
	
	/////Now for the Bluee/////
	
	
	// Select the original input image and subtract the background using a rolling ball algorithm
	selectWindow(replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin);
	run("Subtract Background...", "rolling=220 light separate disable");
	
	// Select the first ROI in the ROI Manager and clear everything outside of it
	roiManager("select", 0);
	run("Clear Outside");
	
	// Close the duplicate image
	close(replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin + "_Area");
	
	// Delete all ROIs in the ROI Manager
	roiManager("Delete");
	
	// Clear the measurement results table
	run("Clear Results");
	
	// Set ROI defaults to black with no border
	run("Roi Defaults...", "color=black stroke=0 group=0");
	
	// Enhance local contrast using the CLAHE algorithm with a blocksize of 100 pixels and a histogram of 256 bins
	run("Enhance Local Contrast (CLAHE)", "blocksize=100 histogram=256 maximum=2 mask=*None*");
	
	// Apply an unsharp mask to sharpen the image with a radius of 6 pixels and a mask weight of 0.6
	run("Unsharp Mask...", "radius=6 mask=.60");
	
	// Make a duplicat to save
	run("Duplicate...", " ");
	
	// Save the processed image as a TIFF file
	saveAs("Tiff", ImgOutputDir + "Total_Area_Results" + replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin + ".tiff");
	
	// Close the Imgae
	close("Total_Area_Results" + replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin + ".tiff");
	
	// Select the working Image window with full frame
	selectWindow(replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin);
	
	// Automatically determine the threshold using the MaxEntropy method and ignore white regions
	run("8-bit");
	run("Auto Threshold", "method=MaxEntropy ignore_white");
	
	// Set the measurements to calculate for particles
	run("Set Measurements...", "area center feret's display scientific add redirect=" + replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin + " decimal=3");
	
	// Set the scale to convert pixel measurements to physical distances
	run("Set Scale...", "distance=1000 known=25.4 unit=mm");
	
	// Analyze particles with a size range of 0-Inf pixels and summarize the results
	run("Analyze Particles...", "size=0-Infinity show=Overlay display clear summarize add");
	
	// Save the Blue particle analysis results as a text file
	saveAs("Text", outputDir + "Total_BlueArea_Results" + replication + "_Glucose_" + glucose + "_Auxin_" + auxin + "_Bikinin_" + bikinin + ".txt");
	
	// Delete all ROIs in the ROI Manager
	roiManager("Delete");
	
	// Clear the measurement results table
	run("Clear Results");
	
	// Close all windows
	close("*");

}
close("*");
