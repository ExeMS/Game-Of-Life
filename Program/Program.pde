class RWalker
{
  int x, y;
  int r, g, b;

  RWalker(int x, int y, int r, int g, int b)
  {
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
  }

  void Update()
  {
     int rnum = int(random(4));
     if(rnum == 0)
     {
       x += 10;
     } else if(rnum==1)
     {
       x -= 10;
     }else if(rnum==2)
     {
       y -= 10;
     }else
     {
       y += 10;
     }
     stroke(r,g,b);
     fill(r,g,b);
     ellipse(x,y,10,10);
  }
}

RWalker steve;
RWalker alex;

void setup()
{
  size(500,400);
  background(255);
  steve = new RWalker(250,200,255,0,0);
  alex = new RWalker(250,200,0,0,255);
}

void draw()
{
  steve.Update();
  alex.Update();
}