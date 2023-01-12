/*
Use the scroll wheel to control size of charges
Use the 'N' key to place a negetive charge
Use the 'P' key to place a positive charge
Press the mouse to drop a positive test charge
Use the 'R' key to reset everything
*/

Field ff;
ArrayList<Charge> charges;
ArrayList<Test> tests;
int space = 20;
int size = 2;
float k=300;
void setup(){
  size(700, 400);
  //fullScreen();
  ff = new Field();
  charges = new ArrayList<Charge>();
  tests = new ArrayList<Test>();
}

void draw(){
  background(255);
  ff.display(true);
  for(Charge c: charges){
    c.display();
    if(tests.size() > 0){
      for(Test t: tests){
        t.effect(c);
      }
    }
  }
  for(Test t: tests){
    t.display();
    t.update();
  }
  noCursor();
  strokeWeight(2);
  stroke(0, 150);
  fill(0, 50);
  ellipse(mouseX, mouseY, 7*size, 7*size);
}

void keyPressed(){
  if(key == 'p'){
    println(size);
    charges.add(new Charge(mouseX, mouseY, abs(size)));
  }
  if(key == 'n'){
    charges.add(new Charge(mouseX, mouseY, abs(size)*-1));
  }
  if(key == 'r'){
    charges.clear();
  }
  if(key == 'k'){
    tests.clear();
  }
  ff.zero();
  for(Charge c: charges){
    ff.effect(c);
  }
  ff.normalize();
  ff.update();
}

void mousePressed(){
  tests.add(new Test(mouseX, mouseY));
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  size+=e;
}