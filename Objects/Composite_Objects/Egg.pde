class Egg {   
  float x, y;
  float tilt;
  float angle;
  float scalar;
  float range;
  float speed;

  // Constructor
  Egg(float xpos, float ypos, float r, float s, float sp) {     
    x = xpos;     
    y = ypos;     
    tilt = 0;     
    scalar = s / 100.0;     
    range = r;
    speed = sp;
  }    

  void wobble() {     
    tilt = cos(angle) / range;     
    angle += speed;
  }    

  void display() {     
    noStroke();     
    fill(230);     

    pushMatrix();     
    translate(x, y);     
    rotate(tilt);     
    scale(scalar);     

    beginShape();     
    vertex(0, -100);     
    bezierVertex(25, -100, 40, -65, 40, -40);     
    bezierVertex(40, -15, 25, 0, 0, 0);     
    bezierVertex(-25, 0, -40, -15, -40, -40);     
    bezierVertex(-40, -65, -25, -100, 0, -100);     
    endShape();     

    popMatrix();   
  } 
}
