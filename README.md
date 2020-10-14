# license-plate-recognition

The input images (number_plate_1 to number_plate_3) are loaded into a loop as the execution procedure for all the images remains the same. It is important to formulate an automated solution that is data driven and is not prone to any changes from user. The solution has been designed considering all these factors.

The following functions are majorly used to implement the solution:
➢ GreyScaler: Converts the given input image to grayscale.
➢ OtsuSeg: Returns a binary image after thresholding.
➢ BiggestBlob: Finds the biggest white blob in the image.
➢ NOT: Returns an image of the pixel by pixel bitwise NOT of the input image.
➢ Subtract: Returns an image of the pixel by pixel subtraction of the second input image from the first input image.
➢ RAFilter: This function performs a rectangular average filter, of size (2*size+1)*(2*size+1). It is equivalent to a convolution of the specified array in which all the coefficients are ones.
➢ MidThresh: Returns an image where the pixel values are white if the input pixel values are larger than or equal to 127, otherwise they are black.
➢ SINFilter: The SINFilter has the effect of spreading dark regions and contracting bright ones.
➢ LINFilter: The LINFilter has the effect of spreading bright regions and contracting dark regions.
➢ SmallestBlob: A function which finds smallest white blob in the image.
➢ XOR: Returns an image of the pixel by pixel bitwise XOR of the input images.
➢ Centroid: Finds the centroid of all the individual blobs in an image.

Pseudocode Approach:
• Load all the input images into the program
• Convert the input image into grayscale.
• Apply global threshold to the grayscale image using OtsuSeg function.
• Find the biggest blob in the threshold image.
• Invert the image and find the biggest blob again.
• Subtract the biggest blob image from the inverted image.
• Pass RAFilter and threshold the image using MidThresh.
• Use SINFilter and LINFilter to eliminate the noise left out in the image.
• Find the smallest blob in the image.
• Use XOR to eliminate the hyphens and repeat the previous step to highlight the remaining blobs.
• Compute the centroid to find the number of alphanumeric characters.
• Use WPCounter to display the number of alphanumeric characters.
• Add the input image with resultant image to get the desired output.