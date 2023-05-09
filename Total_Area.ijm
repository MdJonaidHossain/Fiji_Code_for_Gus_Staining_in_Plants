// Get the input directory containing the images
waitForUser("Action required","Input");
inputDir = getDirectory("Input");

// Get the output directory where the results will be saved
waitForUser("Action required","Output");
outputDir = getDirectory("Output");

// Get the output directory where the Images will be saved
waitForUser("Action required","Image Output");
ImgOutputDir = getDirectory("Image Output");

// Get a list of all the image files in the input directory
images = getFileList(inputDir);

// Loop through each image in the directory
for (i = 0; i < images.length; i++) {

    // Open the current image
    open(inputDir + images[i]);

    // Prompt the user for treatment/genotype info using a dialog box
    Dialog.create("Treatment/Genotype Info");
    Dialog.addString("Glucose:", "Value");
    Dialog.addString("Auxin:", "Value");
    Dialog.addString("Bikinin:", "Value");
    Dialog.show();

    // Get the values entered by the user in the dialog box
    glucose = Dialog.getString();
    auxin = Dialog.getString();
    bikinin = Dialog.getString();

    // Rename the image using the treatment/genotype info
    rename("Glucose" + glucose + "_Auxin" + auxin + "_Bikinin" + bikinin);
    run("Duplicate...", "title=Area");

    // Apply median filter with radius of 30 pixels
    run("Median...", "radius=30");

    // Convert the image to 16-bit
    run("16-bit");

    // Apply auto-thresholding to the image using the Minimum Error thresholding method and make the background white
    run("Auto Threshold", "method=MinError(I) white");

    // Convert the image to a binary mask
    run("Convert to Mask");

    // Invert the binary mask
    run("Invert");

    // Set the scale of the image to 1000 pixels per millimeter with a known size of 25.4 mm
    run("Set Scale...", "distance=1000 known=25.4 unit=mm");

    // Analyze the particles in the binary mask, selecting particles with a size of 1000 pixels or more and displaying the results as an overlay
    run("Analyze Particles...", "size=1000-Infinity pixel show=Overlay clear add");

    // Set the measurements to include area and Feret's diameter and redirect the results to a table
    run("Set Measurements...", "area feret's redirect=None decimal=3");

    // Select the wand tool and prompt the user to select an area on the image
    setTool("wand");
    waitForUser("Action required","Touch the Area");

    // Measure the selected area and save the results to a text file in the output directory
    run("Measure");
    saveAs("Text", outputDir + "Total_Area_Results" + "_Glucose" + glucose + "_Auxin" + auxin + "_Bikinin" + bikinin + ".txt");
	
	// Clear the results table
	run("Clear Results");
	
	// Delete all the ROIs from the ROI Manager
	roiManager("Delete");
    
    // Close the "Area" image and select the original image
    selectWindow("Area");
    close();
    selectWindow("Glucose" + glucose + "_Auxin" + auxin + "_Bikinin" + bikinin);
    
    // Apply median filter with a radius of 30 pixels
    run("Median...", "radius=30");
    
    // Convert to 16-bit image
	run("16-bit");
	
	// Apply automatic thresholding method "MinError(I)" with white foreground
	run("Auto Threshold", "method=MinError(I) white");
	
	// Convert the thresholded image to a binary mask
	run("Convert to Mask");
	
	// Invert the binary mask
	run("Invert");
	
	// Set the selection tool to the wand tool and wait for user input to select an area
	setTool("wand");
	waitForUser("Action required","Touch the Area");
	
	// Revert to the original image
	run("Revert");
	
	// Crop the image to the selected area
	run("Crop");
	
	// Clear pixels outside the selected area
	run("Clear Outside");
	
	// Save the image
	saveAs("tiff", ImgOutputDir + "Total_Area_Results" + "_Glucose" + glucose + "_Auxin" + auxin + "_Bikinin" + bikinin + ".tiff");
	
	// Close all the open images
	close("*");

}
close("*");