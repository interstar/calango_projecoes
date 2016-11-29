interface Ator {
  void atualizar();
  void draw();
  void setProjected(Projected p);
}

class Coisa implements Ator {
  PVector p1,p2,p3,p4;
  Projected espaco;
  
  Coisa() {
    p1 = new PVector(160,30);
    p2 = new PVector(220,290);
    p3 = new PVector(160,120);
    p4 = new PVector(160,120);
  }
  
  public void setProjected(Projected p) { this.espaco = p; }
  
  void atualizar() {
    p1 = new PVector(min(mouseX,width-60),max(mouseY,100));
    p2 = new PVector(p1.x+500,p1.y);
    p3 = new PVector(p1.x,p1.y+400);
    p4 = new PVector(p1.x+500,p1.y+400);
    
  }


  void draw() {
    
    stroke(100);
    strokeWeight(2);
    //fill(255,0,255);

    for (int x=0;x<width;x=x+40) {
      PVector l1 = espaco.trans(new PVector(x,0));
      PVector l2 = espaco.trans(new PVector(x,height));
      
      PVector l3 = espaco.trans(new PVector(0,x));
      PVector l4 = espaco.trans(new PVector(width,x));
      //line(l1.x,l1.y, l2.x,l2.y);
      //line(l3.x,l3.y, l4.x,l4.y);
    }
  
  
    stroke(255);
    PVector p1 = espaco.trans(this.p1);
    PVector p2 = espaco.trans(this.p2);
    PVector p3 = espaco.trans(this.p3); 
    PVector p4 = espaco.trans(this.p4); 

    /*
    ellipse(p1.x,p1.y,3,3);
    ellipse(p2.x,p2.y,3,3);
    ellipse(p3.x,p3.y,3,3);
    line(p1.x,p1.y, p2.x,p2.y);
    line(p2.x,p2.y, p3.x,p3.y);
    line(p3.x,p3.y, p1.x,p1.y);
    */
    fill(200,255,200);
    triangle(p1.x,p1.y, p2.x,p2.y, p3.x,p3.y); 
    triangle(p2.x,p2.y, p3.x,p3.y,p4.x,p4.y); 
    
  }
}


Ator a;
Projected e1,e2;

Camouse camouse;

void setup() {
  // inicializar todo
  //size(700,700,P2D);
  fullScreen();
  
  e1 = new AProjected();
  e2 = new AProjected();

  a = new Coisa();
  a.setProjected(e1);

  //espaco.showBoundary();
  e1.set_transform(0, 0, width, height,  new PVector(252,354), new PVector(362,358), new PVector(364,532), new PVector(259,531));
  e2.set_transform(0, 0, width, height,  new PVector(284,634), new PVector(475,647), new PVector(478,744), new PVector(289,767));

  camouse = new Camouse(this);
}

void draw() {
  // atualizar estado
  a.atualizar();
  
  // renderizar mundo 
  background(0);
  a.draw(); 
  e1.draw();
  e2.draw();

  //fill(255);
  //rect(width/2,0,width/2,height);
  
  camouse.draw();
  //image(camouse.getVideo(),width/2, 0);
  
  //ellipse(camouse.x(),camouse.y(),10,10);
  pushStyle();
  stroke(100,0,0);
  line(0,camouse.y(),width,camouse.y());
  popStyle();
  
  if (camouse.y() < 150) {
    a.setProjected(e1);
  } else {
    a.setProjected(e2);
  }
}

void keyPressed() {
  switch (key) {
    case '1' :
      a.setProjected(e1);
      break;
    case '2' :
      a.setProjected(e2);
      break;
  }
  
}