ArrayList<ArrayList<String[]>> water; 

ArrayList<String[]> loadLake(String filename)
{
        ArrayList<String[]> shapeString = new ArrayList<String[]>();
        
        int l=0;
        try{  
             BufferedReader reader = createReader(filename);
             String line = reader.readLine();  
             
             while(line!=null) {
                  String[] oneLine = split(line, ",");
                  shapeString.add(oneLine); 
                  line = reader.readLine();   
             }
        }
        catch (IOException e) {
        e.printStackTrace();
        //line = null;
          }
         return shapeString;
      
}

void drawThing(ArrayList<String[]> thingToDraw)
{
    //noStroke();
    //fill(fillColor);
    beginShape();
    for(String[] line:thingToDraw)
    {
        float x = map(Float.parseFloat(line[0]), lonStart, lonEnd, 0, width);
        float y = map(Float.parseFloat(line[1]), latStart, latEnd, height, 0);
        vertex(x,y);
    }
    float x = map(Float.parseFloat(thingToDraw.get(0)[0]), lonStart, lonEnd, 0, width);
    float y = map(Float.parseFloat(thingToDraw.get(0)[1]), latStart, latEnd, height, 0);
    vertex(x,y);
    endShape();
}

void loadShapes()
{
    String dir = "geography/";
    water = new ArrayList<ArrayList<String[]>>();    
    water.add(loadLake(dir+"thames1.csv"));
    water.add(loadLake(dir+"thames2.csv"));
    water.add(loadLake(dir+"thames3.csv"));
    water.add(loadLake(dir+"minnea_river.csv"));
    water.add(loadLake(dir+"dc_allwater4.csv"));
    water.add(loadLake(dir+"denver1.csv"));
    water.add(loadLake(dir+"bostonwater.csv"));

    //water.add(loadLake("bostonwater.csv"));
    //println("water.size() " + water.size());
    
    //parks = new ArrayList<ArrayList<String[]>> ();
//    parks.add(loadLake("regentspark.csv"));
//    parks.add(loadLake("hydepark.csv"));
//    //parks.add(loadLake("greenpark.csv"));
//    //parks.add(loadLake("stjamespark.csv"));
//    parks.add(loadLake("kensingtongardens.csv"));
}

void drawShapes()
{
    //loadShapes();
    //int bluecolor = color(98,116,154,alphaValue);

    int bluecolor = color(red(waterColor), green(waterColor), blue(waterColor), alphaValue);
    //int greencolor = color(red(grey), green(grey), blue(grey), alphaValue);
    //bluecolor = grasscolor;
    
    //println("water.size() " + water.size());
    noStroke();
    fill(bluecolor);
    
    for(ArrayList<String[]> geoThing:water)
    {
        drawThing(geoThing);
    }
    
   //int grasscolor = color(39, 119, 76,alphaValue);
   
//   stroke(greencolor);
//   noFill();
//   for(ArrayList<String[]> geoThing:parks)
//    {
//        drawThing(geoThing);
//    }
    
}

void drawScale()
{
    int endX = width - 60;
    int endY = height - 20;
    int scaleWidth = int(ppk);
    int startX = endX - (5*scaleWidth);
    stroke(0);
    line(startX, endY, endX, endY);
    line(startX, endY, startX, endY - 10);
    line(endX, endY, endX, endY - 10);
    for(int i = 1; i<5; i++)
    {
        line(startX + (scaleWidth*i), endY, startX + (scaleWidth*i), endY + 5);
    }
    fill(0);
    textSize(40);
    text("0", startX - 10, endY -30);
    text("5km", endX - 25, endY - 15);
    
}
