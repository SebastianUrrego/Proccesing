class Ring {      
  float x, y;
  float diameter;
  boolean on = false;

  void start(float xpos, float ypos) {     
    x = xpos;     
    y = ypos;     
    on = true;     
    diameter = 5;   
  }      

  void grow() {     
    if (on == true) {       
      diameter += 0.8;       

      if (diameter > width*1.5) {         
        diameter = 0.0;       
      }     
    }   
  }      

  void display() {     
    if (on == true) {       
      noFill();       
      strokeWeight(5);       
      stroke(100, 180);       
      ellipse(x, y, diameter, diameter);     
    }   
  } 
}
