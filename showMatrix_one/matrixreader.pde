HashMap<Integer,HashMap<Integer, Float>> matrixReader(String fn)
{
    /*
      Reads in a matrix in a standard csv format, like:
      0        node_a        node_b        ...
      node_a   coupling_ab   coupling_ba    ...
      node_b   coupling_ba   coupling_bb   ...
      ...
    */
    
    HashMap<Integer,HashMap<Integer, Float>>  netty =  new HashMap<Integer,HashMap<Integer, Float>>();
    String [] stringy = loadStrings(fn);
    String [] header = split(stringy[0], ",");
    maxNet = 0;
    
    for(int i = 1; i< stringy.length; i++)
    {
        String [] line = split(stringy[i], ",");
        Integer startIndex = int(header[i]);
        
        
        
        for(int j = 1; j<line.length; j++)
        {
            float f = float(line[j]);
            if(f>maxNet) maxNet = f;
            if(f<minNet) minNet = f;
            
            if(netty.get(startIndex)==null) netty.put(startIndex, new HashMap<Integer, Float>());
            int endIndex = int(header[j]);
            netty.get(startIndex).put(endIndex, f);
        }
    }
    
    println("min " + minNet + " max " + maxNet);
    return netty;
    
}

HashMap<Integer, Node> loadNodes(String positionFile)
{
    HashMap<Integer, Node> nodey = new HashMap<Integer, Node>();
    String [] stringy = loadStrings(positionFile);
    
    /*
    This adheres the structure: id, name, lat, lon
                                 0    1    2    3
    */
    latStart = 90;
    latEnd = -90;
    lonStart = 180;
    lonEnd = -180;
    
    for(int i = 1; i<stringy.length; i++)
    {
        String[] line = split(stringy[i], ",");
        int index = int(line[0]);
        String name = line[1];
        float lat = float(line[2]);
        float lon = float(line[3]);
        
        if(lat<latStart) latStart = lat;
        if(lat>latEnd) latEnd = lat;
        if(lon<lonStart) lonStart = lon;
        if(lon>lonEnd) lonEnd = lon;
        

        nodey.put(index, new Node(name, index, lon, lat));
    }
    
    float mlon = 0.5*(lonStart+lonEnd);
    float dlon = 0.5*(lonEnd - lonStart);
    float mlat = 0.5*(latStart+latEnd);
    float dlat = 0.5*(latEnd - latStart);
    
    dlon*=1.25;
    dlat*=1.25;
    
    if(fixedWidth>0)
    {
        dlon = (90*fixedWidth)/(PI*6378*cos(PI*mlat/180));
    }
    
    
    latStart = mlat - dlat;
    latEnd = mlat + dlat;
    lonStart = mlon - dlon;
    lonEnd = mlon + dlon;  
    
    
    println("angular limits, latlon: " + latStart + " " + latEnd + " " + lonStart + " " + lonEnd);
    return nodey;
}


class Node
{
    String name;
    int index;
    float px, py;
    float lat, lon;

    
    Node()
    {}
    
    Node(String s, int i)
    {
        name  = s;
        index = i;
    }
    
    Node(String s, int i, float px, float py)
    {
        name  = s;
        index = i;
        this.lon = px;
        this.lat = py;
        toScreen();
        
    }
    
    void toScreen()
    {
       this.px = map(lon, lonStart, lonEnd, 0, width);
       this.py = map(lat, latStart, latEnd, height, 0);  
    }
    
    void display()
    {
        noFill();
        stroke(255);
        ellipse(px, py, 5, 5);
    }
    
    
}
