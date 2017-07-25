
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
                        stroke(255, 255, 255, maxAlphaEdge*(net.get(I).get(J)-mini)/(maxi-mini));
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
                                  
                                  strokeWeight(1+10*abs(e)/ma);
                                  if(e>0)
                                  {
                                        stroke(0, 0, 255, maxAlphaEdge*e/ma);
                                        //stroke(0, 0, 255, 25/e);
                                  }
                                  else
                                  {
                                        stroke(255, 0, 0, -maxAlphaEdge*e/ma);
                                        //stroke(255, 0, 0, 100/e);
                                        //stroke(0,0,0,0);
                                  }
                                  
                                  
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