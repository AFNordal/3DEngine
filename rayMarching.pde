int n = 100;
observer o = new observer(new PVector(100, 150), 10*n, n);
wall[] ws = new wall[7];

int PMouseX = 0;
int PMouseY = 0;

void setup(){
  size(1200, 600);
  ws[0] = new wall(new PVector(0, 0), new PVector(width/2, 0));
  ws[1] = new wall(new PVector(width/2, 0), new PVector(width/2, height/3));
  ws[2] = new wall(new PVector(width/2, height), new PVector(0, height));
  ws[3] = new wall(new PVector(0, height), new PVector(0, 0));
  ws[4] = new wall(new PVector(width/6, height/3), new PVector(width/6, 0));
  ws[5] = new wall(new PVector(width/3, 2*height/3), new PVector(width/3, height));
  ws[6] = new wall(new PVector(width/2, height), new PVector(width/2, 2*height/3));
}

void draw(){
  background(255);
  
  
  o.display(ws);
  for(wall w: ws){
    w.display();
  }
}

//void mouseMoved(){
//  float dx = mouseX-PMouseX;
//  float dy = mouseY-PMouseY;
//  PVector dvec = new PVector(dx, dy);
//  if(dvec.mag() > 4){
//    o.setPos(new PVector(mouseX, mouseY));
//    o.setAng(dvec.heading());
//    PMouseX = mouseX;
//    PMouseY = mouseY;
//  }
//}

void keyPressed(){
  switch(keyCode){
    case UP:
      o.step(10);
      break;
    case RIGHT:
      o.turn(PI/45);
      break;
    case DOWN:
      o.step(-10);
      break;
    case LEFT:
      o.turn(-PI/45);
      break;
  }
}