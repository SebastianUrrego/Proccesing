/**
 * Color Variables (Homage to Albers). 
 * 
 * This example creates variables for colors that may be referred to 
 * in the program by a name, rather than a number. 
 */

size(640, 360);
noStroke();
background(51, 0, 0);

color inside = color(102, 0, 204);
color middle = color(51, 102, 204);
color outside = color(0, 51, 153);
// These statements are equivalent to the statements above.
// Programmers may use the format they prefer.
//color inside = #CC6600;
//color middle = #CC9900;
//color outside = #993300;

pushMatrix();
translate(80, 80);
fill(outside);
rect(0, 0, 250, 250);
fill(middle);
rect(40, 60, 120, 120);
fill(inside);
rect(60, 90, 80, 80);
popMatrix();

pushMatrix();
translate(360, 80);
fill(inside);
rect(0, 0, 250, 250);
fill(outside);
rect(40, 60, 120, 120);
fill(middle);
rect(60, 90, 80, 80);
popMatrix();
