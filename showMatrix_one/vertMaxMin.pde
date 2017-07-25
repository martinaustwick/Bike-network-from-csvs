class maxMin
{
    int sx, sy, h, w, s1y, s2y;
    int sliderHeight = 20;
    float minv, maxv, maxmax, minmin;
    
    maxMin(int sx, int sy, int wx, int hy)
    {
        this.sx =sx;
        this.sy = sy;
        w = wx;
        h = hy;
    }
    
    void setup(float minm, float maxm)
    {
        maxmax = maxm;
        minmin = minm;
        minv = minmin;
        maxv = maxmax;
        
        s1y = sy+h;
        s2y = sy;
    }
    
    
    boolean isOver(int x, int y)
    {
        if(x>sx && x<sx+w && y>sy && y<sy+h) return true;
        else return false;
    }
    
    void scale()
    {
        
    }
    
    void drag()
    {
        
            
            
            if(abs(mouseY-s1y)<sliderHeight/2 && mouseY>s2y+sliderHeight)
            {      
                s1y = mouseY;
                minv = exp(map(s1y, h, 0, log(minmin), log(maxmax)));     
    
            }
            
            if(abs(mouseY-s2y)<sliderHeight/2 && mouseY<s1y-sliderHeight)
            {      
                s2y = mouseY;
                maxv = exp(map(s2y, h, 0, log(minmin), log(maxmax)));    
                        
            }
        
    }
    
   void display()
   {
       rectMode(CORNER);       
       noStroke();
       fill(255);
       rect(sx, sy, w, h);
       
       //fill(100);
       rect(sx, s2y, w, (s1y-s2y));
       
       rectMode(CENTER);
       //fill(200);
       //stroke(255);
       rect(sx + w/2, s1y, w, sliderHeight);       
       rect(sx + w/2, s2y, w, sliderHeight);
       
       fill(0);
       
       text(nf(minv,0,-1), sx, s1y );
       text(nf(maxv,0,-1), sx, s2y + sliderHeight/2);
   }
    
    
}
