/**
 * Datatype Conversion - Modified
 *
 * This version keeps the original idea of converting
 * between different datatypes.
 */

size(640, 360);
background(20);
noStroke();

textFont(createFont("Arial", 24));

char c;
float f;
int i;
byte b;

c = 'H';

f = float(c);
i = int(f * 1.5);
b = byte(c / 3);

fill(255);

text("Character: " + c, 50, 90);
text("Float value: " + f, 50, 140);
text("Integer value: " + i, 50, 190);
text("Byte value: " + b, 50, 240);

text("Datatype Conversion", 50, 300);
