import processing.opengl.*;

HashMap<Integer,HashMap<Integer, Float>> network, comm;
HashMap<Integer, Node> nodes;

//String fileName = "DGall.csv";
float latStart = 51.475;
float latEnd = 51.55;
float lonStart = -0.22;
float lonEnd = -0.05;

float maxNet = 3000;
float maxComm = 1.14;
float minComm = 0.001;
float minNet = 0.5;

maxMin p1, p2;

String city = "london";

//fixed width? km
//set to 0 for no
float fixedWidth = 0;

//pixels per km
float ppk;

color waterColor = color(100);
int alphaValue = 100;
float fixedPPK = 80;

void setup()
{
  network = matrixReader("network_" + city + ".csv");
  //comm = matrixReader("Gall.csv");
  nodes = loadNodes("nodes_" + city + ".csv");
  
  float pdx = 6378*cos(0.5*(latEnd+latStart)*PI/180)*(lonEnd-lonStart)*PI/180;
  float pdy = 6378*(latEnd-latStart)*PI/180;
  println(pdx + " " +  pdy);
  
  float xw = 800;
  float yw = xw*pdy/pdx;
  
   
  ppk = yw/pdy;
  println("ppk " + ppk);
  
  if(fixedPPK>0)
  {
      ppk = fixedPPK;
      xw = pdx*ppk;
      yw = pdy*ppk;
  }


  //size(int(xw), int(yw));  
  size(1000,600);
  for(Node n:nodes.values())
  {
      n.toScreen();
  }
  smooth();

  noLoop();
    loadShapes();
}

void draw()
{
  background(255);
  dir(network, 0, 0, maxNet, minNet);
  drawShapes();
  drawScale();
  
  if(frameCount==1) {
    saveFrame("images/" + city + "_Zij.png");
    println(frameCount);
  }
}

void mouseDragged()
{

  if(p1.isOver(mouseX, mouseY)) {
    p1.drag();
    minNet = p1.minv;
    maxNet = p1.maxv;
  }

}

void keyPressed()
{
  if(key=='f') saveFrame("images/" + frameCount + ".png");
}