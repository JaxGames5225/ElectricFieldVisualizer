class Charge{
  int charge;
  PVector pos;
  Charge(float x, float y, int c){
    charge = c;
    pos = new PVector(x, y);
  }
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(2);
    stroke(0);
    if(charge > 0){
      fill(255, 50, 50);
      ellipse(0, 0, abs(charge)*7, abs(charge)*7);
    }else{
      fill(75, 75, 245);
      ellipse(0, 0, abs(charge)*7, abs(charge)*7);
    }
    popMatrix();
  }
}

class Test{
  PVector pos, vel, acc;
  PVector forceNet;
  Test(float x, float y){
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    forceNet = new PVector();
  }
  void effect(Charge c){
    PVector force = PVector.sub(pos, c.pos);
    force.normalize();
    force.mult(k*c.charge*pow(dist(c.pos.x, c.pos.y, pos.x, pos.y), -2));
    forceNet.add(force);
  }
  void update(){
    acc.mult(0);
    acc.add(forceNet);
    vel.add(acc);
    pos.add(vel);
    forceNet.mult(0);

  }
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    popMatrix();
    strokeWeight(2);
    stroke(0);
    fill(255, 50, 50);
    ellipse(pos.x, pos.y, 10, 10);
  }
}