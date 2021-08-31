class wall{
  PVector a, b, ab;
  wall(PVector a_, PVector b_){
    a = a_;
    b = b_;
    ab = PVector.sub(b, a);
  }
  
  void display(){
    stroke(0);
    strokeWeight(1);
    line(a.x, a.y, b.x, b.y);
  }
}