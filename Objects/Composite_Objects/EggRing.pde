class EggRing {   
  Egg ovoid;   
  Ring circle = new Ring();   

  EggRing(float x, float y, float t, float sp, float speed) {     
    ovoid = new Egg(x, y, t, sp, speed);     
    circle.start(x, y - sp/2);   
  }    

  void transmit() {     
    ovoid.wobble();     
    ovoid.display();     
    circle.grow();     
    circle.display();     

    if (circle.on == false) {       
      circle.on = true;     
    }   
  } 
}
