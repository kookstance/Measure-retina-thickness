//calculates thickness of a selection (height) -- transform XY selection into YZ stack
//where Y = layer thickness and Z = slice from left to right in X direction
setBatchMode(true);

run("Clear Results");
run("Set Measurements...", "  bounding stack limit display redirect=None decimal=3");
run("To Bounding Box");
run("Reslice [/]...", "output=1.000 start=Left avoid");
run("Analyze Particles...", "display clear stack");


// Check slice number
getDimensions(x,y,c,z,t);
totalSlices = newArray(z);
name=getTitle();
for (i=0; i<nResults; i++) {
        sliceWidth = getResult("Width", i);
        slice =  getResult("Slice", i);
        totalSlices[slice-1]+=sliceWidth;
}
run("Clear Results");
for (i=0; i<z ;i++) {
        setResult("Label", i, name);
        setResult("Position", i, i+1);
        setResult("Thickness", i, totalSlices[i]);
}
