class Mover implements Ator {
  PVector c;
  Projected espaco;
  
  Mover() {
    c = new PVector(0,0);
  }
  
  void atualizar() { }
  
  public void setProjected(Projected p) { this.espaco = p; }

  void draw() {
    fill(255);
    rect(c.x-10, c.y-30, 20, 60);      
  }
  
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