class observer{
  float ang;
  PVector pos;
  ray[] rays;
  int res;
  
  observer(PVector pos_, int res_, int n_rays){
    pos = pos_;
    ang = 0;
    res = res_;
    rays = new ray[n_rays];
    float theta = radians(n_rays*180.0/res);
    for(int i=0; i<n_rays; i++){
      rays[i] = new ray(pos, ang + map(i+0.5, 0, n_rays, theta, -theta));
    }
  }
  
  void updateRayPos(){
    for(ray r: rays){
      r.setPos(pos);
    }
  }
  
  void step(float vel){
    PVector pos_ = PVector.fromAngle(ang).mult(vel).add(pos);
    setPos(pos_);
  }
  
  void setPos(PVector pos_){
    pos = pos_;
    updateRayPos();
  }
  
  void turn(float d_ang){
    setAng(ang+d_ang);
  }
  
  void setAng(float ang_){
    float d_ang = ang_ - ang;
    ang = ang_;
    for(ray r: rays){
      r.setAng(r.ang + d_ang);
    }
  }
  
  void observe(wall[] ws){
    strokeWeight(1);
    stroke(255, 0, 0, 100);
    for(ray r: rays){
      PVector p = r.cast(ws);
      line(pos.x, pos.y, p.x, p.y);
    }
  }
  
  void display(wall[] ws){
    observe(ws);
    display();
    float a = height/0.03;
    pushMatrix();
    translate(3*width/4, height/2);
    float px = 0;
    float ph = 0;
    float pdh = 0;
    strokeWeight(1);
    for(int i=0; i<rays.length; i++){
      float x = map(i+0.5, 0, rays.length, width/4, -width/4);
      float d = rays[i].distance(ws);
      float h = a*sin(1/d);
      float dh = h - ph;
      
      
      if(i>1){
        noStroke();
        fill(200);
        rect(px, -ph, x-px, ph*2);
        stroke(0);
        if(abs(pdh/dh)>1000){             //WIP
          //line(x, ph, x, -ph);            //WIP
        } else if(abs(dh/pdh)>1000){      //WIP
          //line(x, -h, x, h);              //WIP
        }                                 //WIP
        line(px, -ph, x, -ph);
        line(px, ph, x, ph);
      }
      pdh = dh;
      ph = h;
      px = x;
    }
    popMatrix();
  }
  
  void character(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    ellipse(pos.x, pos.y, 20, 20);
    PVector dir = PVector.fromAngle(ang).mult(10);
    line(pos.x - dir.x, pos.y - dir.y, pos.x + dir.x, pos.y + dir.y);
  }
  
  void display(){
    if(rays.length > 0){
      rays[0].display(20);
      rays[rays.length-1].display(20);
    }
    character();
  }
}