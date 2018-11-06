 import processing.sound.*;
Amplitude amp;
AudioIn in;
FloatList data;
float AmpMid= 4.7; 
float Silence= 0.07; 
float Quiet= 2.5; 
boolean analyzed= true;
String binOut= "";

void setup() {
  // initalize a background
  size(800, 300);
  data = new FloatList();
  
  // get audio input and record amplitude
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

void draw() {
  //noise is the s
  float noise= amp.analyze();
  if (noise > Silence) {
    println(noise);
    data.append(noise);
    analyzed = false; // there is new noise input that has not been analyzed yet
 
  }
  else if (analyzed == false) {
    // if it is currently quiet measure the prior imput
    analyzeNoise();
    analyzed= true; // the previous chunk ofnoise input has been analyzed
   }
}

void mousePressed() {
  analyzeNoise();
  println(binOut);
  println(getText());
  exit(); 
}

String getText() {
  String word = "";
  
  for (int i =0; i < binOut.length(); i+=8) {
    String str = binOut.substring(i, i+8);
    int num = unbinary(str);
    word += char(num);
  }
  return word;
}

void analyzeNoise() {
  // will need to deal with many moments of read in silence
  float total =0.0;
  
  // output 0 or 1 based on tota value of data from last chunk (silence or noise)
  for(int i=0; i < data.size(); i=0) {
    total+= data.get(i);
    data.remove(i);
  }
  
  println("total: " + total);
 
  // if total is loud print 0
  if(total > AmpMid) {
    binOut+= "0";
    println(0);
    background(250);
  }
  
  // if total is quiet but not silent print 1 (no noise)
  if(Quiet < total && total < AmpMid){
    binOut+= "1";
    background(0);
    println(1);
  }
}
