import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Program extends PApplet {

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

  public void Update()
  {
     int rnum = PApplet.parseInt(random(4));
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

public void setup()
{
  
  background(255);
  steve = new RWalker(250,200,255,0,0);
  alex = new RWalker(250,200,0,0,255);
}

public void draw()
{
  steve.Update();
  alex.Update();
}
  public void settings() {  size(500,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Program" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
