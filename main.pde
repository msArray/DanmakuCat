PImage chara;
int btntf;
int charax;
int charay;
JSONArray  stage;
void setup(){
  frameRate(120);
  size(600,600);
  chara = loadImage("chara.png");
  btntf=0;
  charax=0;
  charay=0;
}
//fanctions
void start(String j){
  stage = loadJSONArray("stage.json");
}


void draw(){
  clear ();
  charax = mouseX-25;
  charay = mouseY-25;
  image(chara, charax, charay,50,50);
  
  //Button
  int buttonx = 240;
  int buttony = 300;
  int buttonwidth = 80;
  int buttonheight = 40;
  String text = "Start!";
  int textsize = 25;
  if(btntf==0){
      fill(255);
  rect(buttonx,buttony,buttonwidth,buttonheight);
  fill(0);
  textAlign(CENTER);
  textSize(textsize); 
  text(text, buttonx, buttony, buttonwidth, buttonheight);
      if(mousePressed==true){
        if(mouseX>buttonx&&mouseX<buttonx+buttonwidth&&mouseY>buttony&&mouseY<buttony+buttonheight){
          println("clicked");
          btntf=1;
//          start("./stage.json");
        }else{
          btntf=0;
        }
      }
    }
  
  
  //Chara sousa
  charax = mouseX-25;
  charay = mouseY-25;
  image(chara, charax, charay,50,50);
}
