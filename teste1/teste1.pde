interface Ator {
  void atualizar();
  void draw();
}

class Coisa implements Ator {
  PVector p1,p2,p3;
  
  Coisa() {
    p1 = new PVector(30,30);
    p2 = new PVector(60,60);
    p3 = new PVector(30,90);
  }
  
  void atualizar() {
    p1 = new PVector(min(mouseX,width-60),max(mouseY,100));
    p2 = new PVector(p1.x+30,p1.y-70);
    p3 = new PVector(p1.x+60,p1.y);
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
      line(l1.x,l1.y, l2.x,l2.y);
      line(l3.x,l3.y, l4.x,l4.y);
    }
  
  
    stroke(255);
    PVector p1 = espaco.trans(this.p1);
    PVector p2 = espaco.trans(this.p2);
    PVector p3 = espaco.trans(this.p3); 
    /*
    ellipse(p1.x,p1.y,3,3);
    ellipse(p2.x,p2.y,3,3);
    ellipse(p3.x,p3.y,3,3);
    line(p1.x,p1.y, p2.x,p2.y);
    line(p2.x,p2.y, p3.x,p3.y);
    line(p3.x,p3.y, p1.x,p1.y);
    */
    triangle(p1.x,p1.y, p2.x,p2.y, p3.x,p3.y); 
  }
}


Ator a;
Projected espaco;

void setup() {
  // inicializar todo
  //size(700,700,P2D);
  fullScreen();
  a = new Coisa();
  
  espaco = new AProjected();
  espaco.showBoundary();
  //espaco.set_transform(0, 0, width, height,  new PVector(252,354), new PVector(362,358), new PVector(364,532), new PVector(259,531));
  espaco.set_transform(0, 0, width, height,  new PVector(284,634), new PVector(475,647), new PVector(478,744), new PVector(289,767));

}

void draw() {
  // atualizar estado
  a.atualizar();
  
  // renderizar mundo 
  background(0);
  a.draw(); 
  espaco.draw();
}