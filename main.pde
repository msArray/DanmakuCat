PImage chara;
PImage teki;
int btntf;
int charax;
int charay;
int delayA;
int tekix,tekiy;
JSONArray  stage;
int fps;

void setup() {
  fps=60;
  frameRate(fps);
  size(600, 600);
  chara = loadImage("chara.png");
  teki = loadImage("teki.png");
  btntf=0;
  charax=0;
  charay=0;
  tekix = 800;
  tekiy = 800;
  delayA=0;
}
//fanctions
void start() {
  tekix = 245;
  tekiy = 80;
}


void draw() {
  clear ();
  charax = mouseX-25;
  charay = mouseY-25;
  image(chara, charax, charay, 50, 50);
  image(teki, tekix, tekiy, 70, 70);

  //Button
  int buttonx = 240;
  int buttony = 300;
  int buttonwidth = 80;
  int buttonheight = 40;
  String text = "Start!";
  int textsize = 25;
  if (btntf==0) {
    fill(255);
    rect(buttonx, buttony, buttonwidth, buttonheight);
    fill(0);
    textAlign(CENTER);
    textSize(textsize);
    text(text, buttonx, buttony, buttonwidth, buttonheight);
    if (mousePressed==true) {
      if (mouseX>buttonx&&mouseX<buttonx+buttonwidth&&mouseY>buttony&&mouseY<buttony+buttonheight) {
        println("clicked");
        btntf=1;
      } else {
        btntf=0;
      }
    }
  }else if(btntf == 1){
    tekix = 245;
    tekiy = 80;
    if(delayA<fps){
      fill(255);
      textSize(100);
      text("3", 280, 300);
      delayA++;
    }else if(delayA<fps*2){
      fill(255);
      textSize(100);
      text("2", 280, 300);
      delayA++;
    }else if(delayA<fps*3){
      fill(255);
      textSize(100);
      text("1",280,300);
      delayA++;
    }else if(delayA<fps*4){
      fill(255);
      textSize(100);
      text("0",280,300);
      delayA++;
    }else{
      //Start Stage Here
      
    }
  }


  //Chara sousa
  charax = mouseX-25;
  charay = mouseY-25;
  image(chara, charax, charay, 50, 50);
}
