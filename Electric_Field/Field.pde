class ForceNet{
  float mag;
  PVector vector;
  color c = color(255);
  ForceNet(float x, float y, float m){
    vector = new PVector(x, y);
    mag = m;
  }
  void display(float x, float y){
    float d = vector.mag();
    pushMatrix();
    if(mag > 10E-6){
      stroke(c);
      translate(x*space, y*space);
      rotate(vector.heading());
      line(0, 0, d, 0);
      line(d, 0, (d/4)*3, (d/5));
      line(d, 0, (d/4)*3, -(d/5));
    }
    popMatrix();
  }
  void zero(){
    vector.set(0, 0);
    mag = 0;
  }
  void normalize(float x){
    vector.setMag(x);
  }
  void add(PVector force){
    vector.add(force);
    mag = vector.mag();
  }
  void update(){
    c = lerpColor(color(1, 0), color(0, 150), map(mag, 10E-2, 50E-2, 0, 1));
  }
}

class Field{
  ForceNet [][] feild;
  int w, h;
  Field(){
    w = width/space;
    h = height/space;
    feild = new ForceNet[w][h];
    
    for(int x = 0; x < w; x ++){
      for(int y = 0; y < h; y ++){
        feild[x][y] = new ForceNet(0, 0, 0);
      }
    }
  }
  void display(boolean dir){
    if(dir){
      stroke(0, 100);
      strokeWeight(1);
      for(int x = 0; x < w; x ++){
        for(int y = 0; y < h; y ++){
          feild[x][y].display(x, y);
        }
      }
    }
  }
  void zero(){
    for(int x = 0; x < w; x ++){
      for(int y = 0; y < h; y ++){
        feild[x][y].zero();
      }
    }
  }
  void normalize(){
    for(int x = 0; x < w; x ++){
      for(int y = 0; y < h; y ++){
        feild[x][y].normalize(space*1.5);
      }
    }
  }
  void update(){
    for(int x = 0; x < w; x ++){
      for(int y = 0; y < h; y ++){
        feild[x][y].update();
      }
    }
  }
  void effect(Charge c){
    for(int x = 0; x < w; x ++){
      for(int y = 0; y < h; y ++){
        PVector force = PVector.sub(c.pos, new PVector(x*space, y*space));
        force.normalize();
        force.mult(-k*c.charge*pow(dist(c.pos.x, c.pos.y, x*space, y*space), -2));
        feild[x][y].add(force);
      }
    }
  }
}