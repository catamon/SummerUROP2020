import processing.pdf.*;

beginRecord(PDF, "lines.pdf");
// Making a line
line(150,250,700,900);

// Static sketch
 size(400, 400);
 background(192, 64, 0);
 stroke(255, 255, 128); // the last parameter sets transparency
 fill(100,100, 100, 128);
 rect(0, 0, 100, 100);
 fill(255,255,200, 128);
 rect(10, 10, 100, 100);
 line(150, 25, 270, 350);
