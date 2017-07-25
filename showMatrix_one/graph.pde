
void net(HashMap<Integer, HashMap<Integer, Float>> net, int xs, int ys, float maxi, float mini)
{
    //println("toDraw");
    pushMatrix();
        translate(xs, ys);
        for(int I:net.keySet())
        {
              Node snode = nodes.get(I);
              //println(I);
              for(int J:net.get(I).keySet())
              {
                    if(net.get(I).get(J)>mini && net.get(I).get(J)<=maxi)
                    {
                        stroke(255, 255, 255, 50*(net.get(I).get(J)-mini)/(maxi-mini));
                        line(snode.px, snode.py, nodes.get(J).px, nodes.get(J).py);
                    }
              }
        }
    popMatrix();
    //println("drawn");
}


void dir(HashMap<Integer, HashMap<Integer, Float>> net, int xs, int ys, float maxi, float mini)
{
    //max abs
    float ma = max(maxi, abs(mini)); 

    
    noFill();
    pushMatrix();
        //translate(xs, ys);
        for(int I:net.keySet())
        {
              Node snode = nodes.get(I);
              //println(I);
              
              if(!(snode==null))
              {
                  for(int J:net.get(I).keySet())
                  {
//                        if(net.get(I).get(J)>mini && net.get(I).get(J)<=maxi)
//                        {
                            //println(I + " " + J);
                            //println(snode);
                            if(!(nodes.get(J)==null))
                            {
                                float a  = atan2(nodes.get(J).py - snode.py, nodes.get(J).px - snode.px);
                                float d = dist(snode.px, snode.py, nodes.get(J).px, nodes.get(J).py);
                                
                                pushMatrix();
                                  translate(snode.px, snode.py);
                                  rotate(a);
                                  //edge weight
                                  float e = net.get(I).get(J);
                                  
                                  if(e>0)
                                  {
                                        stroke(0, 0, 255, 255*e/ma);
                                        //stroke(0, 0, 255, 25/e);
                                  }
                                  else
                                  {
                                        stroke(255, 0, 0, -255*e/ma);
                                        //stroke(255, 0, 0, 100/e);
                                        //stroke(0,0,0,0);
                                  }
                                  strokeWeight(1+10*abs(e)/ma);
                                  
                                  float f = 10;
                                  bezier(0, 0, d, f, d, f/4, d, 0);
                                  //line(0,0, d, 0);
                                popMatrix();
                            //}
                           
                        }
                  }
              }
        }
    popMatrix();
    println("drawn");
}

//void drawScale()
//{
//    int endX = width - 20;
//    int endY = height - 20;
//    int scaleWidth = int(ppk);
//    int startX = endX - (5*scaleWidth);
//    stroke(0);
//    line(startX, endY, endX, endY);
//    line(startX, endY, startX, endY - 10);
//    line(endX, endY, endX, endY - 10);
//    for(int i = 1; i<5; i++)
//    {
//        line(startX + (scaleWidth*i), endY, startX + (scaleWidth*i), endY + 5);
//    }
//    fill(0);
//    text("0", startX - 4, endY -11);
//    text("5km", endX - 10, endY - 11);
//    
//}


