// ctl timer
// leer tbls

import peasy.*;
import oscP5.*;
import netP5.*;

// CSV handler
Table table;
Table limits;
float clock = 0.0;

// Cam
PeasyCam cam;

// Models
PShape[] tanks;
PShape tank;
Table points;

PShape montana;

// Colors

int red;
int gre;
int blu;

// Inner data tables
int[]     idTable;
float[] timeTable;
float[]  ampTable;
float[] posXTable;
float[] posYTable;

// limits
float maxA;
float minA;
float maxX;
float minX;
float maxY;
float minY;
  
// intern counter
int rowIndex = 0;
int hitCount = 0;


int lastReadFile;
float lastReadTime;

float clockSpeed = 1f;

int startFileIndex = 1;


// OSC
OscP5 osc;
NetAddress supercollider;


boolean addedMillis;

float timer;


int debounceTime;
boolean debounced;
int lastTriggerTime;

void setup() {
  
  debounced = false;
  lastTriggerTime = 0;
  debounceTime = 50;
  
  lastReadTime = 0;
  
  addedMillis = false;
  
  size(1280, 720, P3D);
  ellipseMode(CENTER);
  
  red = int(random(128));
  gre = int(random(200));
  blu = int(random(160));
  
  background(red,gre,blu);
  
  // OSC setup:
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("192.168.1.64", 57120);//192.168.0.56. //169.254.121.92

  // Peasy setup:
  cam = new PeasyCam(this, 102.909, 96.4662, 0, 200);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);

  // Models
  points = loadTable("HAWC-IDs.csv");
  tank = loadShape("tanque-O.obj");
  tank.setFill(color(0));
  
  montana = loadShape("topo-2.obj");
  montana.scale(3);
  
    tanks = new   PShape[300];

  

  for (int k=0; k<300; ) {
    tanks[k] = loadShape("tanque-O.obj");
    tanks[k].setFill(color(0,20));
    k++;
  }
  
  
  loadFile( startFileIndex );
  
  
}




void draw() {
    
  background(red,gre,blu);
  //background(0);
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  rotateX(0.4);
  translate(0, 0, 0);
  ambientLight(102, 102, 102);
  directionalLight(244, 244, 244, -dirX, -dirY, -2);
  
//  println( millis() % 1000 );
  
  // HIT

 if( rowIndex+1 < table.getRowCount() ) {
      
      float diff = abs(timeTable[rowIndex+1]-timeTable[rowIndex]);
      println( "clocks: " + timeTable[rowIndex] + " - " + timeTable[rowIndex+1]); 
      if(diff< 0.5){
        clockSpeed = 0.25f;
      }
      if(diff< 0.2){
        clockSpeed = 0.125f;
      }
      if(diff< 0.1){
        clockSpeed = 0.0625f;
      }
      if(diff< 0.05){
        clockSpeed = 0.03125f;
      }
      
      
      if(diff>= 0.5 && diff < 4){
        clockSpeed = 1.0f;
      }
      
      if(diff>=4){
        clockSpeed = 3.0f;
      }
      
       if(diff>=10){
        clockSpeed = 10.0f;
      }
      
     if(diff>=20){
        clockSpeed = 20.0f;
      }


        println( "diff: " + diff );
  println( "clockSpeed: " + clockSpeed );
      /*
  
    
        println( "clock: " + clock );
      
    */
    }



  if( millis() % floor(1000) < 200 && ! addedMillis ) {
  
    // descomeantar para que incremente como valor comun hy corriente
//    timer = timer + (1.0f);
    timer = timer + (1.0f * clockSpeed) ;
    addedMillis = true;
  }
  
  if( millis() % 1000 > 200 ) {
    addedMillis = false;
  }
  
  //timer = floor( timer );
  float decimals =  ( millis() % 1000 );
  
  
  clock = timer + (decimals / (float) 1000);
  
  
  
  if (rowIndex < table.getRowCount()-1) {
    if ( ( clock ) > timeTable[rowIndex] - timeTable[0]) {
        
      
      
        
        /*
        for (int i=0; i<300; ) {
          tanks[i].setFill(color(0,0.5));
          i++;
        }*/
        
        minA = limits.getFloat(0,1); maxA = limits.getFloat(0,0);
        //minX = limits.getFloat(0,3); maxX = limits.getFloat(0,2);
        minX = -100.0 ; maxX = 300.0;
        //minY = limits.getFloat(0,5); maxY = limits.getFloat(0,4);
        minY = -100.0 ; maxY = 600.0;
        
        hitCount++;
        println(nf(hitCount,3)+" HIT on tank# " + idTable[rowIndex]);
        
        // OSC Message
        
        if( millis() > lastTriggerTime + debounceTime ) {
          debounced = false;
        }
        if( ! debounced ) {
      
          //println("send OSC");
          debounced = true;
          lastTriggerTime = millis();
          
          OscMessage msg = new OscMessage("/starhit");
          msg.add(idTable[rowIndex]); // ID
          msg.add(map(ampTable[rowIndex],  minA, maxA,  0.1, 1.0)); // amp 0 - 1
          msg.add(map(posXTable[rowIndex], minX, maxX, -1.0, 1.0)); // x  -1 - 1
          msg.add(map(posYTable[rowIndex], minY, maxY, -1.0, 1.0)); // y  -1 - 1
          osc.send(msg, supercollider);
          
       } else {
         //println("prevent OSC because of debounce");
       }
          



        //println("OSC: "+msg);
  
        tanks[idTable[rowIndex]].setFill(color( int(map(ampTable[rowIndex], 0.0, 100, 10, 255)), int(map(ampTable[rowIndex], 0.0, 100, 10, 255)), int(map(ampTable[rowIndex], 0.0, 100, 10, 255)), 180)) ;
        
        rowIndex++;
                
        background(map(ampTable[rowIndex],limits.getFloat(0,1),limits.getFloat(0,0),200,55), map(posXTable[rowIndex],0,300,0,250), map(posYTable[rowIndex],0,300,0,150));
        
      }
      //montana.scale(map(ampTable[rowIndex],  minA, maxA,  0.8, 2.2));
   
  } else {
    
    println("ended");
    
    resetTimer();
    
//    lastReadTime = (millis()*clockSpeed) / (float)1000;

    loadFile( lastReadFile + 1 );
    
    
    
  }



  // Tanks
  for (int i=0; i<300; ) {
    shape(tanks[points.getRow(i).getInt(0)], points.getRow(i).getInt(1), points.getRow(i).getInt(2));
    i++;
  }
  
  montana.setFill(color(255,50,50,98));
  //montana.noFill();
  montana.scale(8);
  shape(montana, 0, 0);
  //int children = montana.getChildCount();

  /*
  beginShape();
  for (int i = 0; i < children; i++) {
    PShape child = montana.getChild(i);

    for (int j = 0; j < child.getVertexCount(); j++) {
      PVector v = child.getVertex(j);
      vertex(v.x, v.y, v.z);
    }
  }
  endShape();
  */
  

  //println( clock);
}



void resetTimer() {
  timer = 0;
}



void loadFile( int index ) {


  table = loadTable("Cascadas/V_"+nf(index,5)+".csv");
  limits = loadTable("Cascadas/L_"+nf(index,5)+".csv");

  table.setColumnType(2,"float");
  table.sort( 2 );

  idTable = new   int[table.getRowCount()];
  timeTable = new float[table.getRowCount()];
  ampTable  = new float[table.getRowCount()];
  posXTable = new float[table.getRowCount()];
  posYTable = new float[table.getRowCount()];
  
  // Limits
  maxA = 0.0;
  minA = 0.0;
  maxX = 0.0;
  minX = 0.0;
  maxY = 0.0;
  minY = 0.0;

  int i = 0;
  for (TableRow row : table.rows()) {
    int     id = row.getInt(0);
    float  amp = row.getFloat(1);
    float time = row.getFloat(2);
    float xpos = row.getFloat(3);
    float ypos = row.getFloat(4);
    idTable[i]   = id;    
    timeTable[i] = time;
    ampTable[i]  = amp;
    posXTable[i] = xpos;
    posYTable[i] = ypos;
    
    i++;
    //println(id, amp, time, xpos, ypos);
  }
  
//  timeTable = sort(timeTable);

  i = 0;
  for (TableRow row : table.rows()) {
    println(timeTable[i]);
    i++;
  }

  lastReadFile = index;
  rowIndex = 0;
  println("finished reading:"+index);
  
  
  for (int k=0; k<300; ) {
    tanks[k].setFill(color(0,20));
    k++;
  }
  

} 
