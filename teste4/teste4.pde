interface Ator {
  void atualizar();
  void draw();
  void setProjected(Projected p);
}



Ator a;
Ator o1,o2;

Projected e1,e2;

Camouse camouse;

void setup() {
  // inicializar todo
  //size(700,700,P2D);
  fullScreen();
  
  e1 = new AProjected();
  e1.set_transform(0, 0, width, height,  new PVector(220,325), new PVector(763,298),   new PVector(767,720), new PVector(237,729)); 

  a = new PPoly(30,30,20,20,color(100,255,100),0,0);
  o1 = new PPoly(130,230,20,20,color(255,100,100),3,0);
  o2 = new PPoly(330,330,20,20,color(255,100,100),3,0);


  a.setProjected(e1);
  o1.setProjected(e1);
  o2.setProjected(e1);
  
  camouse = new Camouse(this);
}

void draw() {
  // atualizar estado
  a.atualizar();
  o1.atualizar();
  o2.atualizar();
  
  // renderizar mundo 
  background(0);
  a.draw(); 
  o1.draw();
  o2.draw();
  e1.draw();


  //fill(255);
  //rect(width/2,0,width/2,height);
  
  camouse.draw();
  image(camouse.getVideo(),width/2, 0);
  
  //ellipse(camouse.x(),camouse.y(),10,10);
  pushStyle();
  stroke(100,0,0);
  line(0,camouse.y(),width,camouse.y());
  popStyle();
  
  PPoly pp = (PPoly)a;
  pp.c = new PVector(camouse.x(), camouse.y()*2);
  
  if (camouse.y() < 150) {
    a.setProjected(e1);
  } else {
    //a.setProjected(e2);
  }
}

void keyPressed() {
  switch (key) {
    case '1' :
      a.setProjected(e1);
      break;
    case '2' :
      //a.setProjected(e2);
      break;
  }
  
}