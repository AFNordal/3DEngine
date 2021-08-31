class ray{
  PVector pos, dir;
  float ang;
  
  ray(PVector pos_, float ang_){
    pos = pos_;
    ang = ang_;
    dir = PVector.fromAngle(ang);
  }
  
  void display(float len){
    stroke(0);
    strokeWeight(1);
    line(pos.x, pos.y, pos.x + dir.x*len, pos.y + dir.y*len);
  }
  
  void updateAng(){
    ang = dir.heading();
  }
  
  void setPos(PVector pos_){
    pos = pos_;
  }
  
  void setAng(float ang){
    dir = PVector.fromAngle(ang);
    updateAng();
  }
  
  void focus(PVector target){
    dir = target.sub(pos).normalize();
    updateAng();
  }
  
  float distance(wall w){
    float den = dir.x*w.ab.y - dir.y*w.ab.x;
    if(den == 0){
      return -1;
    }
    float t = (w.a.x*w.ab.y + pos.y*w.ab.x - (w.a.y*w.ab.x + pos.x*w.ab.y))/den; 
    float s = (pos.y*dir.x + w.a.x*dir.y - (pos.x*dir.y + w.a.y*dir.x))/den;
    if(t < 0 || s < 0 || s > 1){
      return -1;
    }
    return t;
  }
  
  float distance(wall[] ws){
    float rec = Float.POSITIVE_INFINITY;
    for(wall w: ws){
      float t = distance(w);
      if(t < rec && t != -1){
        rec = t;
      }
    }
    return rec;
  }
  
  PVector cast(wall w){
    float t = distance(w);
    if(t == -1){
      return null;
    }
    PVector tdir = PVector.mult(dir, t);
    return PVector.add(pos, tdir);
  }
  
  PVector cast(wall[] ws){
    float rec = distance(ws);
    PVector tdir = PVector.mult(dir, rec);
    return PVector.add(pos, tdir);
  }
}