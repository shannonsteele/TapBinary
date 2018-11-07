import processing.sound.*;
Amplitude amp;
AudioIn in;
FloatList data; // relevant audio input get stored in data (reset between noise chunks)
float AmpMid= 4.7;  // can be adjusted based on enviroment 
float Silence= 0.07;  // noise below this level is background noise
float Quiet= 2.5; // can be adjusted based on enviroment
boolean analyzed= true; 
String binOut= ""; // binary output

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

//runs continuously (default 60 times per second)
void draw() {
  // take in audio input for current frame
  float noise= amp.analyze();
  // check if the noise is background noise
  if (noise > Silence) {
    // if not print noise (float value)
    println(noise);
    // add noise to data
    data.append(noise);
    analyzed = false; //there is new noise input that has not been analyzed yet
  }
  else if (analyzed == false) {
    // if there is currently just background noise
    analyzeNoise();
    analyzed= true; // the previous chunk of data has been analyzed
   }
}

// End sketch and get output by pressing mouse
void mousePressed() {
  // analyze the last chunk of data
  analyzeNoise();
  // print the accumulated binary output
  println(binOut);
  // check if binary string can be translated
   if (canTrans()) {
    // translate binary to English 
    println(getText());
   }
   else {
     println("Cannot be translated");
   }
  // end sketch 
  exit(); 
}

// check if binary can be translated
boolean canTrans() {
  boolean trans = false;
  // check if binary string is evenly divisible by 8  
  if (binOut.length() % 8 == 0){
    trans = true;
  }
  return trans;
}

// translate binary to English 
String getText() {
  String word = "";
  // traverse binary string in bytes and translate
  for (int i =0; i < binOut.length(); i+=8) {
    // get byte
    String str = binOut.substring(i, i+8);
    // translate byte to int
    int num = unbinary(str);
    // translate int to char and add to total translated text
    word += char(num);
  }
  return word; // return total translated text
}

// analyze previous data chunk
void analyzeNoise() {
  float total =0.0;
  
  // output 0 or 1 based on tota value of data from last chunk (silence or noise)
  for(int i=0; i < data.size(); i=0) {
    // add up all audio input in data
    total+= data.get(i);
    // remove values from data so next audio chunk starts fresh
    data.remove(i);
  }
  
  // print total value of last chunk of audio input
  println("total: " + total);
 
  // if total is loud print 0
  // AmpMid can be adjusted for your enviroment
  if(total > AmpMid) {
    binOut+= "0";
    println(0);
    // visual output white
    background(250);
  }
  
  // if total is quiet but not silent print 1 (no noise)
  if(Quiet < total && total < AmpMid){
    binOut+= "1";
    println(1);
    // visual output black
    background(0);
  }
}
