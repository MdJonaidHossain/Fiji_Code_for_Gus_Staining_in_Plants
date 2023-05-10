Fiji Macro Script - Image Analysis and Processing
This Fiji Macro Script automates the image processing and analysis of a directory containing multiple RAW images in the Fiji platform. The script applies a set of filters, thresholds, and measurements to extract and quantify specific particle features, while also allowing the user to input treatment and genotype information for each image.


Requirements
Fiji (version > 1.53c)
Usage
Open Fiji and load the macro script.
Run the macro.
When prompted, select the directory containing the input images, the directory where the output text file will be saved, and the directory where the output images will be saved.
For each image, the user will be prompted to enter treatment/genotype information.
The script will process and analyze each image and save the results as a text file and a TIFF file in the specified output directories.



How to Use
Download and install Fiji (https://fiji.sc/#download)
Place your RAW images into a single directory on your computer
Open Fiji and run the script by dragging and dropping the script into the Fiji toolbar
A dialog box will appear asking you to select the input directory containing the images. Select the directory and click "OK"
Another dialog box will appear asking you to select the output directory where the results will be saved. Select the directory and click "OK"
A final dialog box will appear asking you to select the output directory where the processed images will be saved. Select the directory and click "OK"
The script will then loop through each image in the directory and prompt the user for treatment and genotype information using a dialog box.
The script will then apply a set of filters, thresholds, and measurements to extract and quantify specific particle features, while also saving the processed images in the specified output directory.
The script will save a text file summarizing the particle analysis results in the specified output directory.



Script Details
The script applies a median filter with a radius of 25 pixels to each image to remove any noise.
The script converts the image to 8-bit to save memory.
The script automatically determines the threshold using the MinError method and ignores white regions.
The script sets the measurements to calculate for particles (area, center, and Feret's diameter) and sets the scale to convert pixel measurements to physical distances.
The script analyzes particles with a size range of 100-Inf pixels and summarizes the results.
The script saves the particle analysis results as a text file in the specified output directory.
The script then selects the original input image and subtracts the background using a rolling ball algorithm.
The script enhances local contrast using the CLAHE algorithm with a block size of 100 pixels and a histogram of 256 bins.
The script applies an unsharp mask to sharpen the image with a radius of 6 pixels and a mask weight of 0.6.
The script saves the processed image as a TIFF file in the specified output directory.



Outputs
A text file summarizing the particle analysis results for each image.
Processed TIFF images containing the specific particle features.
Note: If you want to edit the script, please copy the code into a new file instead of modifying the original file to avoid any potential issues.
