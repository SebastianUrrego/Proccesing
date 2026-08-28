/**
 * Characters Strings - Modified
 * 
 * The program allows the user to type characters backwards.
 * BACKSPACE deletes the last character written.
 * ENTER restarts the text.
 */

char letter;
String words = "";

void setup() {
  size(640, 360);
  
  // Create the font
  textFont(createFont("SourceCodePro-Regular.ttf", 36));
}

void draw() {
  background(0);

  // Display information
  textSize(14);
  text("Type letters to create text backwards", 50, 50);
  text("Current key: " + letter, 50, 70);
  text("The String is " + words.length() + " characters long", 50, 90);
  text("BACKSPACE: delete | ENTER: restart", 50, 110);
  
  // Display the String
  textSize(36);
  text(words, 50, 140, 540, 280);
}

void keyTyped() {
  // Add letters and spaces to the beginning of the String
  if ((key >= 'A' && key <= 'z') || key == ' ') {
    letter = key;
    words = key + words;
    
    // Write the key to the console
    println(key);
  }
}

void keyPressed() {
  // Delete the first character because the text is written backwards
  if (key == BACKSPACE && words.length() > 0) {
    words = words.substring(1);
  }
  
  // Restart the String
  if (key == ENTER || key == RETURN) {
    words = "";
    letter = ' ';
    println("Text restarted");
  }
}
