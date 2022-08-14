import ddf.minim.*;
PImage chara;
PImage teki;
int btntf;
int charax;
int charay;
int delayA;
int tekix,tekiy;
JSONArray  stage;
int fps;
Minim minim;
AudioPlayer player;
AudioPlayer starts;

void setup() {
  fps=60;
  frameRate(fps);
  size(600, 600);
  chara = loadImage("./assets/chara.png");
  teki = loadImage("./assets/teki.png");
  minim = new Minim(this);  //初期化
  player = minim.loadFile("./assets/button.mp3");
  starts = minim.loadFile("./assets/start.mp3");
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

void abox(int boxx,int boxy,int boxsize,int r,int g,int b){
  fill(r,g,b);
  rect(boxx,boxy,boxsize,boxsize);
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
        player.play();
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
      starts.play();
      fill(255);
      textSize(100);
      text("0",280,300);
      delayA++;
    }else{
      //Start Stage Here
      
      //Box Array
      int [] boxes;
      stage = loadJSONArray("./assets/stage.json");
      
      
      abox(300,300,25,255,5,255);
      
      
    }
  }


  //Chara sousa
  charax = mouseX-25;
  charay = mouseY-25;
  image(chara, charax, charay, 50, 50);
}
