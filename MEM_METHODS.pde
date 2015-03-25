void handleMemFile(String filename){
  String[] lines = loadStrings(filename);
  
  for(int i = 0; i < lines.length; i++){
    TableRow row = memTable.addRow();
      
    // This is a S_int val
    if( lines[i].startsWith("S_int") ){
      float s_int = getLineFloatVal(lines[i]);
      row.setFloat("s_int", s_int);
    }
    
    // This is a S_max val
    else if( lines[i].startsWith("S_max") ){
      float s_max = getLineFloatVal(lines[i]);
      row.setFloat("s_max", s_max);
    }
    
    // This is a U(S_int) val
    else if( lines[i].startsWith("U(S_int)") ){
      float us_int = getLineFloatVal(lines[i]);
      row.setFloat("us_int", us_int);
    }
    
    String name = parseMemFilename(filename);
    row.setString("filename", name);
  }
}

String parseMemFilename(String filename){
  filename = filename.replace("Mem_", "");
  filename = filename.replace("_", "");
  filename = filename.replace(".txt", "");
  
  return filename;
}
