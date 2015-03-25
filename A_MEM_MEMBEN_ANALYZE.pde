File dir; 
File [] files;

Table pTable;
Table vTable;
Table memTable;
Table memBenTable;

Table out;

void setup(){
  selectFolder("choose a folder containing data files", "folderSelected"); 
  
  noLoop();
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    dir = new File(selection.getAbsolutePath());
    files = dir.listFiles();
    
    setupOutTable();
    
    setupPTable();
    setupVTable();
    setupMemTable();
    setupMemBenTable();
    
    createTables();
  
    saveDataTables();
    
    findLargestPValue();
    findLargestVValue();
    findLargestMemValue();
    findLargestMemBenValue();
    
    saveOutTable(); 
  }
}


void setupOutTable(){
  out = new Table();
  
  out.addColumn("Utv.pkt.");
  out.addColumn("Värde");
  out.addColumn("Lastfall");
}

void setupPTable(){
  pTable = new Table();
  
  pTable.addColumn("p");
  pTable.addColumn("value");
  pTable.addColumn("filename");
}

void setupVTable(){
  vTable = new Table();
  
  vTable.addColumn("v");
  vTable.addColumn("value");
  vTable.addColumn("filename");
}

void setupMemTable(){
  memTable = new Table();
  
  memTable.addColumn("s_int");
  memTable.addColumn("s_max");
  memTable.addColumn("us_int");
  memTable.addColumn("filename");
}

void setupMemBenTable(){
  memBenTable = new Table();
  
  memBenTable.addColumn("s_int");
  memBenTable.addColumn("s_max");
  memBenTable.addColumn("us_int");
  memBenTable.addColumn("filename");
}

void draw(){
  
}

void createTables(){
  for(int i = 0; i < files.length; i++){
    String name = getFileName(files[i]);
    
    if( name.startsWith("A_") ){
      handleAFile(name);
    }
    
    else if( name.startsWith("Mem_") ){
      handleMemFile(name);
    }
    
    else if( name.startsWith("MemBen_") ){
      handleMemBenFile(name);
    }
  }
}

void findLargestPValue(){
  int largest = 0;
  String name = "";
  
  for (TableRow row : pTable.rows()) {
    int value = row.getInt("value");
    if( value > largest ){
      largest = value;
      name = row.getString("filename");
    }
  }
  
  TableRow p = out.addRow();
  
  p.setString("Utv.pkt.", "P");
  p.setInt("Värde", largest);
  p.setString("Lastfall", name);
}

void findLargestVValue(){
  int largest = 0;
  String name = "";
  
  for (TableRow row : vTable.rows()) {
    int value = row.getInt("value");
    if( value > largest ){
      largest = value;
      name = row.getString("filename");
    }
  }
  
  TableRow v = out.addRow();
  
  v.setString("Utv.pkt.", "V");
  v.setString("Värde", Integer.toString(largest));
  v.setString("Lastfall", name);
}

void findLargestMemValue(){
  float largest = 0;
  String name = "";
  
  for (TableRow row : memTable.rows()) {
    float value = row.getFloat("s_int");
    if( value > largest ){
      largest = value;
      name = row.getString("filename");
    }
  }
  
  TableRow v = out.addRow();
  
  v.setString("Utv.pkt.", "Mem");
  v.setString("Värde", Float.toString(largest));
  v.setString("Lastfall", name);
}

void findLargestMemBenValue(){
  float largest = 0;
  String name = "";
  
  for (TableRow row : memBenTable.rows()) {
    float value = row.getFloat("s_int");
    if( value > largest ){
      largest = value;
      name = row.getString("filename");
    }
  }
  
  TableRow v = out.addRow();
  
  v.setString("Utv.pkt.", "Mem");
  v.setString("Värde", Float.toString(largest));
  v.setString("Lastfall", name);
}

void saveOutTable(){
  saveTable(out, "csv/result.csv");
}

void saveDataTables(){
  saveTable(pTable, "csv/pTable.csv");
  saveTable(vTable, "csv/vTable.csv");
  saveTable(memTable, "csv/memTable.csv");
  saveTable(memBenTable, "csv/memBenTable.csv");
}

String getFileName(File f){
  return f.getAbsolutePath().split("/")[f.getAbsolutePath().split("/").length - 1];
}

float getLineFloatVal(String line){
  line = line.trim();
  
  // Start from the end of the string and find the first space
  int start = line.lastIndexOf(" ");

  float realVal = Float.parseFloat(line.substring(start).trim());
  
  return realVal;
}


