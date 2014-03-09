import guru.ttslib.*;
TTS tts;
// load cat.text and have it scroll and put video brightness(c) on it. 
PFont f;  
String[] headlines;
String delimiters = " ,.?!;:[]";
import processing.video.*;
Capture video;
int col = 20;
float row = 20;
long lastTime = 0;
int i = 0;
void setup() {
  size(640, 480);
  tts = new TTS();
  lastTime = millis();
  video= new Capture(this, width, height);
  video.start();
  f = createFont("Arial", 16, true);  
  String url = "http://www-958.ibm.com/software/analytics/manyeyes/datasets/the-cat-in-the-hat-text/versions/1.txt";
  String[] rawtext = loadStrings(url);
  String everything = join(rawtext, "" );
  headlines = splitTokens(everything, delimiters);
  frameRate(6);
}

void draw() {
row= textWidth(headlines[i]);
  background(0);
  video.read();
  fill(0);
  if (millis()>10000) {
    if ( millis() - lastTime > 500 ) {
      tts.speak(headlines[i]);
      i++;
      lastTime = millis();
    }
    for (int x = 0 ; x<video.width; x+=row) {
      for (int y = 0; y<video.height; y+=col) {
        int thisPixel = (x+y*video.width);
        color c = video.pixels[thisPixel];
        fill(255);
        textFont(f, brightness(c)/6);
        text(headlines[i], x, y);
      }
    }
  }
}

