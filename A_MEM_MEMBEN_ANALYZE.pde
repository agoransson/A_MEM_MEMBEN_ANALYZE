
Table pTable;
Table vTable;
Table memTable;
Table memBenTable;

Table out;

PFont font;

String loadedDir = "asd";

StringBuilder sb = new StringBuilder();

int scannedFiles = 0;

void setup(){
  size(600, 400);
  font = loadFont("Dialog-13.vlw");
  textFont(font);
  
  selectFolder("choose a folder containing data files", "folderSelected"); 
}

void folderSelected(File selection) {
  if (selection == null) {
    sb.append("Window was closed or the user hit cancel.").append("\n");
  } else {
    loadedDir = selection.getAbsolutePath();
    
    sb.append("Loaded dir: ").append(loadedDir).append("\n");
    
    analyzeFiles(selection); 
  }
}

void analyzeFiles(File dir){
  sb.append("Starting analysis...").append("\n");
  sb.append("(in dir: ").append(dir.getPath()).append(")\n").append("\n");
  
  File[] files = dir.listFiles();
  
  setupOutTable();
  
  setupPTable();
  setupVTable();
  setupMemTable();
  setupMemBenTable();
  
  createTables(files);

  saveDataTables();
  
  findLargestPValue();
  findLargestVValue();
  findLargestMemValue();
  findLargestMemBenValue();
  
  saveOutTable();
}


void setupOutTable(){
  sb.append("Setting up table 'out'").append("\n");
  
  out = new Table();
  
  out.addColumn("Utv.pkt.");
  out.addColumn("Värde");
  out.addColumn("Lastfall");
}

void setupPTable(){
  sb.append("Setting up table 'p'").append("\n");
  
  pTable = new Table();
  
  pTable.addColumn("p");
  pTable.addColumn("value");
  pTable.addColumn("filename");
}

void setupVTable(){
  sb.append("Setting up table 'v'").append("\n");
  
  vTable = new Table();
  
  vTable.addColumn("v");
  vTable.addColumn("value");
  vTable.addColumn("filename");
}

void setupMemTable(){
  sb.append("Setting up table 'mem'").append("\n");
  
  memTable = new Table();
  
  memTable.addColumn("s_int");
  memTable.addColumn("s_max");
  memTable.addColumn("us_int");
  memTable.addColumn("filename");
}

void setupMemBenTable(){
  sb.append("Setting up table 'memBen'").append("\n");
  
  memBenTable = new Table();
  
  memBenTable.addColumn("s_int");
  memBenTable.addColumn("s_max");
  memBenTable.addColumn("us_int");
  memBenTable.addColumn("filename");
}

void draw(){
  background(0);
  text(sb.toString(), 12, 12);
  
  text("Scanned files: " + scannedFiles, width - 152, 12);
}

void createTables(File[] files){
  sb.append("Populating tables...").append("\n");
  
  for(int i = 0; i < files.length; i++){
    String name = files[i].getName();
    
    if( name.startsWith("A_") ){
      //sb.append("...found 'A_' file ").append(name).append("\n");
      handleAFile(files[i]);
    }
    
    else if( name.startsWith("Mem_") ){
      //sb.append("...found 'Mem_' file").append(name).append("\n");
      handleMemFile(files[i]);
    }
    
    else if( name.startsWith("MemBen_") ){
      //sb.append("...found 'MemBen_' file").append(name).append("\n");
      handleMemBenFile(files[i]);
    }
    
    scannedFiles++;
  }
}

void findLargestPValue(){
  sb.append("Finding largest 'P' value").append("\n");
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
  sb.append("Finding largest 'V' value").append("\n");
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
  sb.append("Finding largest 'Mem' value").append("\n");
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
  sb.append("Finding largest 'MemBen' value").append("\n");
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
  
  v.setString("Utv.pkt.", "MemBen");
  v.setString("Värde", Float.toString(largest));
  v.setString("Lastfall", name);
}

void saveOutTable(){
  sb.append("Saving 'out' table to 'csv/result.csv'").append("\n");
  saveTable(out, "csv/result.csv");
}

void saveDataTables(){
  sb.append("Saving data tables").append("\n");
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


