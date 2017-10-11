String filename = "network_denver";

void setup()
{
    Table t = loadTable(filename+".csv", "header");
    
    Table out = new Table();
    out.addColumn("Source");
    out.addColumn("Target");
    out.addColumn("Weight");
    
    String [] header = t.getColumnTitles();
    println(header[0]);
    
    for (TableRow row : t.rows()) {
      //print("hi");
      for(int i = 1; i<header.length; i++)
      {
          int Source = row.getInt(0);
          int Target = int(header[i]);
          float Weight = row.getFloat(header[i]);
          //println(Source + " " + Target + " " + Weight);
          
          //ignore negative weights here
          if(Weight>0)
          {
              TableRow newRow = out.addRow();
              newRow.setInt("Source",Source);
              newRow.setInt("Target", Target);
              newRow.setFloat("Weight", Weight);
          }
          
      }
  }
  
  saveTable(out, "data/"+filename+"_list.csv");

}