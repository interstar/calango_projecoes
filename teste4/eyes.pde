class PPoly implements Ator {
  Projected espaco;
  float r,n;
  PVector c,d;
  color col;
  
  ArrayList<PVector> pts;
  
  PPoly(float x, float y, float r, float n, color col, float dx, float dy) {
    this.c = new PVector(x,y);
    this.d = new PVector(dx,dy);
    this.r = r;
    this.n = n;
    this.col = col;
    recreate();
  }
  
  public void setProjected(Projected p) { this.espaco = p; }
  
  
  boolean hit(PPoly other) {
    
    if (c.diff(other.c)) {
    }
  }

  void recreate() {
    double a = 0;
    double da = Math.PI * 2 / n;
    pts = new ArrayList<PVector>();
    for (int i=0;i<n;i++) {
      PVector p = new PVector((int)(Math.cos(a)*r+c.x), (int)(Math.sin(a)*r+c.y));
      pts.add(p);
      a = a + da;
      println(p);
    }    
  }
  
  void atualizar() {
    c = c.add(d);
    if (c.x > 500) {
      c.x = 0;
      c.y = (float)Math.random() * height;
    } 
    recreate();
  }
  
  void draw() {
    PVector p2;
    PShape s = createShape();
    s.beginShape();
    s.fill(col);
    s.noStroke();
    for (PVector p : pts) {
      println(p);
      p2 = espaco.trans(p);
      s.vertex(p2.x, p2.y);
    }
    s.endShape(CLOSE);    
    shape(s,0,0);
  }
}

/*

class Eye implements Ator {
 float x, y;
 float dx, dy;
 float a;
 int count = 0;
 
 Eye(float x, float y) {
   this.x = x;
   this.y = y;
   this.dx=random(4)-2;
   this.dy=random(4)-2;
   this.a = random(2*PI);
 }

 boolean outside(float lo, float hi, float x) {
    return ((x < lo) || (x > hi));
 }
 
 void draw() {
    this.x = this.x+this.dx;
    this.y = this.y+this.dy;
    if (outside(0,width,this.x)) {
      this.dx = -this.dx;
    }
    if (outside(0,height,this.y)) {
      this.dy = -this.dy;
    }
 
    
    fill(255);
    ellipse(this.x,this.y,60,60);

    float ox, oy;
    ox = cos(a)*10;
    oy = sin(a)*10;

    fill(0);
    ellipse(this.x+ox,this.y+oy,30,30);

    ox = cos(a)*16.7;
    oy = sin(a)*16.7;

    fill(255);
    ellipse(this.x+ox,this.y+oy,6,6);

    if (timer < 1) {
      this.a = this.a+ PI/20;
    } else {
      PVector pv = PVector.sub(new PVector(mouseX,mouseY), new PVector(this.x,this.y));
      this.a = PVector.angleBetween(pv,new PVector(100,0));
      if (mouseY < this.y) {
          this.a = -this.a;
      }
    }
    
 }

}
*/