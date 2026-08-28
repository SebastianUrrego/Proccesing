/**
 * Variables. 
 * 
 * Variables are used for storing values. In this example, change 
 * the values of variables to affect the composition. 
 */
 
size(800, 450);
background(15);
stroke(220);
strokeWeight(5);
strokeCap(ROUND);

int a = 40;
int b = 70;
int c = 200;

line(a, b, a+c, b);
line(a, b+15, a+c+20, b+15);
line(a, b+30, a+c+40, b+30);
line(a, b+45, a+c+60, b+45);

a = a + c;
b = height-b;

line(a, b, a+c, b-40);
line(a, b+15, a+c+20, b-20);
line(a, b+30, a+c+40, b);
line(a, b+45, a+c+60, b+20);

a = a + c;
b = height-b;

line(a, b, a+c, b+60);
line(a, b+15, a+c+20, b+40);
line(a, b+30, a+c+40, b+20);
line(a, b+45, a+c+60, b);
