// Get the input directory containing the images
waitForUser("Action required","Input");
inputDir = getDirectory("Input");

// Get the output directory where the results will be saved
waitForUser("Action required","Output");
outputDir = getDirectory("Output");

// Get a list of all the image files in the input directory
images = getFileList(inputDir);

// Loop through each image in the directory
for (i = 0; i < images.length; i++) {

    // Open the current image
    open(inputDir + images[i]);
    
    // Extract the file name from the input file path
    fileName = getTitle();
	
	// Split channels
	run("Split Channels");
	
	// Close the blue and green channels
	close(fileName + " (blue)");
	close(fileName + " (green)");

	// Select the red channel
	selectWindow(fileName + " (red)");

	// Convert the image to 16-bit
    run("16-bit");

    // Apply auto-thresholding to the image using the MaxEntropy thresholding method and make the background white
    run("Auto Threshold", "method=MaxEntropy ignore_white white");

    // Convert the image to a binary mask
    run("Convert to Mask");

    // Set the scale of the image to 1000 pixels per millimeter with a known size of 25.4 mm
    run("Set Scale...", "distance=1000 known=25.4 unit=mm");

    // Create a selection for the white pixels
    run("Create Selection");
    
    // Analyze the particles in the binary mask, selecting particles with a size of 1000 pixels or more and displaying the results as an overlay
    run("Analyze Particles...", "size=0-Infinity pixel show=Overlay clear add");

    // Set the measurements to include area and Feret's diameter and redirect the results to a table
    run("Set Measurements...", "area feret's redirect=None decimal=3");

    // Measure the selected area and save the results to a text file in the output directory
    run("Measure");
    saveAs("Text", outputDir + "Total_Blue_Area_Results" + fileName + ".txt");
	
	// Clear the results table
	run("Clear Results");
	
	// Delete all the ROIs from the ROI Manager
	roiManager("Delete");
    
	// Close all the open images
	close("*");

}
close("*");