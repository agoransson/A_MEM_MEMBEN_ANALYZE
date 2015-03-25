void handleAFile(String filename){
  
  String[] lines = loadStrings(filename);
  for(int i = 0; i < lines.length; i++){
    
    // This is a P_VAL
    if( lines[i].startsWith("P_") ){
      TableRow row = pTable.addRow();
      
      String p = getId(lines[i]);
      int value = getAIntVal(lines[i]);
      String name = parseAFilename(filename);
      
      row.setString("p", p);
      row.setInt("value", value);
      row.setString("filename", name);
    }
    
    // This is a V_VAL
    else if( lines[i].startsWith("V_") ){
      TableRow row = vTable.addRow();
      
      String v = getId(lines[i]);
      int value = getAIntVal(lines[i]);
      String name = parseAFilename(filename);
      
      row.setString("v", v);
      row.setInt("value", value);
      row.setString("filename", name);
    }
  }
}

String getId(String line){
  line.trim();
  
  int end = line.indexOf(" ");
  
  String id = line.substring(0, end);
  
  return id;
}

int getAIntVal(String line){
  line = line.trim();
   
  // Get the index of the point (should be removed later)
  int end = line.lastIndexOf(".", line.length() - 1);
  
  // Start from the end of the string and find the first space
  int start = line.lastIndexOf(" ", end);
  
  int realVal = Integer.parseInt(line.substring(start, end).trim());
  
  return realVal;
}

String parseAFilename(String filename){
  filename = filename.replace("A_", "");
  filename = filename.replace("_", "");
  filename = filename.replace(".txt", "");
  
  return filename;
}
