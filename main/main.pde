import ddf.minim.*;

//chara,teki...image of chara and teki
PImage chara;
PImage teki;
int btntf;
int charax;
int charay;
int delayA;
int tekix,tekiy;
int fps;
Minim minim;
AudioPlayer player;
AudioPlayer starts;

void setup() {
  fps=60;
  frameRate(fps);
  
  //gamen saizu ha 600*600
  size(600, 600);
  
  //gazou wo ro-do
  chara = loadImage("./assets/chara.png");
  teki = loadImage("./assets/teki.png");
  
  //oto wo ro-do
  minim = new Minim(this);  //初期化
  player = minim.loadFile("./assets/button.mp3");
  starts = minim.loadFile("./assets/start.mp3");
  
  //botan ga osaretaka douka wo kanri
  btntf=0;
  
  //kyara no iti no hensu-
  charax=0;
  charay=0;
  
  //teki ha saisho gamengai
  tekix = 800;
  tekiy = 800;
  
  //???
  delayA=0;
}
//functions
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

  //start Button
  int buttonx = 240;
  int buttony = 300;
  int buttonwidth = 80;
  int buttonheight = 40;
  String text = "Start!";
  int textsize = 25;
  
  if (btntf==0) {
    //start gamen
    fill(255);
    rect(buttonx, buttony, buttonwidth, buttonheight);
    fill(0);
    textAlign(CENTER);
    textSize(textsize);
    text(text, buttonx, buttony, buttonwidth, buttonheight);
    if (mousePressed==true) {
      if (mouseX>buttonx && mouseX<buttonx+buttonwidth && mouseY>buttony && mouseY<buttony+buttonheight) {
        //when start is pressed
        println("clicked");
        player.play();
        btntf=1;
      } else {
        btntf=0;
      }
    }
  }else if(btntf == 1){
    //game gamen
    
    //teki(taka) displays
    tekix = 245;
    tekiy = 80;
    
    //countdown
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
      //int [] boxes;
      
      String stagename;
      int amount;
      
      JSONArray jArray;
      jArray = loadJSONArray("./assets/stage.json");
      
      JSONObject detailObject;
      detailObject = jArray.getJSONObject(0);
      
      //stagename wo hyouji
      stagename = detailObject.getString("stagename");
      amount = detailObject.getInt("amount");
      textAlign(LEFT);
      textSize(16);
      text(stagename,10,20);
      
      int[] noteX = new int[amount];
      int[] noteY = new int[amount];
      
      JSONObject humenObject;
      humenObject = jArray.getJSONObject(1);
      JSONArray humenArray;
      humenArray = humenObject.getJSONArray("humendata");
      
      for(int i = 0; i < amount; i++){
        JSONObject noteObject;
        noteObject = humenArray.getJSONObject(i);
        
        noteX[i] = noteObject.getInt("x");
        noteY[i] = noteObject.getInt("y");
        
        abox(noteX[i],noteY[i],25,255,5,255);
      }
      
    }
  }


  //Chara sousa
  //charax = mouseX-25;
  //charay = mouseY-25;
  //image(chara, charax, charay, 50, 50);
}
