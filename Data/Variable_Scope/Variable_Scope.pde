
/**
 * Variable Scope. 
 * 
 * Variables have a global or local "scope". 
 * For example, variables declared within either the
 * setup() or draw() functions may be only used in these
 * functions. Global variables, variables declared outside
 * of setup() and draw(), may be used anywhere within the program.
 * If a local variable is declared with the same name as a
 * global variable, the program will use the local variable to make 
 * its calculations within the current scope. Variables are localized
 * within each block, the space between a { and }. 
 */
 
int a = 55;  // Create a global variable "a"

void setup() {
  size(900, 500);
  background(25);
  stroke(255);
  noLoop();
}

void draw() {
  // Draw a horizontal line using the global variable "a"
  line(0, a, width, a);
  
  // Create a new variable "a" local to the for() statement 
  for (int a = 100; a < 280; a += 15) {
    line(0, a, width, a);
  }
  
  // Create a new variable "a" local to the draw() function
  int a = 340;
  // Draw a horizontal line using the new local variable "a"
  line(0, a, width, a);  
  
  // Make a call to the custom function drawAnotherLine()
  drawAnotherLine();
  
  // Make a call to the custom function setYetAnotherLine()
  drawYetAnotherLine();
}

void drawAnotherLine() {
  // Create a new variable "a" local to this method
  int a = 430;
  // Draw a horizontal line using the local variable "a"
  line(0, a, width, a);
}

void drawYetAnotherLine() {
  // Because no new local variable "a" is set, 
  // this line draws using the original global
  // variable "a", which is set to the value 55.
  line(0, a+25, width, a+25);
}
```
