import ddf.minim.*;

//chara,teki...image of chara and teki
PImage chara;
PImage teki;
PImage lifeimg;
int btntf;
int charax;
int charay;
int delayA;
int tekix,tekiy;
int fps;
PFont pFontData;
PFont pFontNormal;
float score;
int muteki;
float frame_from_start;
float second_from_start;
String humenpath;
int songlength;
JSONArray stageList;
JSONObject stageListObject;
int amountList;
JSONObject nameListObject;
JSONArray stageNameArray;
Minim minim;
AudioPlayer player;
AudioPlayer senkyoku;
AudioPlayer starts;
AudioPlayer bgm;



void setup() {
  fps=60;
  frameRate(fps);
  
  //gamen saizu ha 600*600
  size(600, 600);

  //font load
  pFontData = loadFont("Arial-Black-48.vlw");
  pFontNormal = loadFont("ArialMT-48.vlw");
  //gazou wo ro-do
  chara = loadImage("./assets/chara.png");
  teki = loadImage("./assets/teki.png");
  lifeimg = loadImage("./assets/life.png");
  
  //oto wo ro-do
  minim = new Minim(this);  //初期化
  player = minim.loadFile("./assets/button.mp3");
  starts = minim.loadFile("./assets/start.mp3");
  bgm = minim.loadFile( "./assets/typhoon-parade.mp3");//Song link https://dova-s.jp/bgm/play3406.html
  senkyoku = minim.loadFile("./assets/senkyoku.mp3");
  
  //botan ga osaretaka douka wo kanri
  btntf=0;
  
  //kyara no iti no hensu-
  charax=0;
  charay=0;
  
  //teki ha saisho gamengai
  tekix = 800;
  tekiy = 800;
  
  //humen no path
  humenpath = "./assets/stage.json";
  
  songlength = 94;

  //score
  score = 100;

  //damege wo uketatoki no mutekijikan
  muteki = 0;

  //zikan
  delayA=0;
  frame_from_start=0;
  second_from_start=0;
  
  //JSONArray stageList;// 選曲
  stageList = loadJSONArray("./assets/List.json");
  
  //JSONObject stageListObject;
  stageListObject = stageList.getJSONObject(0);
  amountList = stageListObject.getInt("listamount");
  
  //JSONObject nameListObject;
  nameListObject = stageList.getJSONObject(1);
  
  //JSONArray stageNameArray;
  stageNameArray = nameListObject.getJSONArray("humen");
}
//functions
/*
void start() {
  tekix = 245;
  tekiy = 80;
}
*/

void abox(int boxx,int boxy,int boxsize,int r,int g,int b,int opacity){
  fill(r,g,b,opacity);
  rect(300+boxx-boxsize/2,300+(-1*boxy)-boxsize/2,boxsize,boxsize);
}

void draw() {
  clear ();

  //start Button
  int buttonx = 440;
  int buttony = 500;
  int buttonwidth = 80;
  int buttonheight = 40;
  String text = "Start!";
  int textsize = 25;
  
  if (btntf==0) {
    //Logo
    fill(255);
    textSize(30);
    textFont(pFontData);
    text("Dammaku",400,100);
    text("Cat",500,150);
    textFont(pFontNormal);

    for(int i=0;i<amountList;i++){
      JSONObject humeninfoObject;
      humeninfoObject = stageNameArray.getJSONObject(i);
      String humenname = humeninfoObject.getString("name");
      

      fill(255);
      rect(100, i*60+60, 100, 40);
      fill(0);
      textAlign(CENTER);
      textSize(20);
      text(humenname, 100, i*60+70, 100, 40);

      if(mousePressed==true){
        if (mouseX>100 && mouseX<200 && mouseY>i*60+60 && mouseY<i*60+100) {
          //when start is pressed
          println("humen clicked");
          senkyoku.rewind();
          senkyoku.play();
          humenpath = humeninfoObject.getString("path");
          println(humeninfoObject.getString("path"));
          songlength = humeninfoObject.getInt("length");
          bgm = minim.loadFile( humeninfoObject.getString("sound"));
        }
      }
    }


    fill(255);
    rect(buttonx, buttony, buttonwidth, buttonheight);
    fill(0);
    textAlign(CENTER);
    textSize(textsize);
    text(text, buttonx, buttony+10, buttonwidth, buttonheight);
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
    //tekix = 300;
    //tekiy = 50;
    
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
      bgm.play();
      frame_from_start++;
      second_from_start = frame_from_start/fps;
      
      
      if(second_from_start > songlength){
        btntf = 3;
      }
      
      //log hajimattekarano zikan
      //println("sec:"+second_from_start);


      //Start Stage Here
      
      //Box Array
      //int [] boxes;
      
      String stagename;
      int amount;
      
      JSONArray jArray;
      jArray = loadJSONArray(humenpath);
      
      JSONObject detailObject;
      detailObject = jArray.getJSONObject(0);
      
      //stagename wo hyouji
      stagename = detailObject.getString("stagename");
      amount = detailObject.getInt("amount");
      textAlign(LEFT);
      textSize(16);
      fill(255,255,255);
      text(stagename,10,20);

      image(lifeimg, 510, 2, 20, 20);

      textAlign(RIGHT);
      textSize(16);
      fill(255,255,255);
      text("×"+score,550,20);
      
      int[] noteX = new int[amount];
      int[] noteY = new int[amount];
      int[] notesize = new int[amount];
      int[] notecheck = new int[amount];
      int[] notepop = new int[amount];
      int[] noterm = new int[amount];
      
      JSONObject humenObject;
      humenObject = jArray.getJSONObject(1);
      JSONArray humenArray;
      humenArray = humenObject.getJSONArray("humendata");

      
      for(int i = 0; i < amount; i++){
        JSONObject noteObject;
        noteObject = humenArray.getJSONObject(i);
        
        noteX[i] = noteObject.getInt("x");
        noteY[i] = noteObject.getInt("y");
        notesize[i] = noteObject.getInt("size");
        notecheck[i] = noteObject.getInt("checktime");
        notepop[i] = noteObject.getInt("poptime");
        noterm[i] = noteObject.getInt("rmtime");
        
        
        if(noterm[i] > second_from_start * 1000){
          if(notecheck[i] < second_from_start * 1000){
             if(notepop[i] < second_from_start * 1000){
              noStroke();
              abox( noteX[i] , noteY[i] , notesize[i] , 5 , 255 , 255 , 255 );
             }else{
              stroke(255,5,255);
              abox(noteX[i],noteY[i],notesize[i],0,0,0,0);
            }
          }
        }

        //log
        /*
        println(300+noteX[i]-(notesize[i]/2) );
        println(300+(-1*noteY[i])-(notesize[i]/2) );
        println(300+noteX[i]+(notesize[i]/2));
        println(300+(-1*noteY[i])+(notesize[i]/2) );
        */

        if( noterm[i] > second_from_start * 1000 && notepop[i] < second_from_start * 1000){
          //hit hantei
          if( mouseX >= 300+noteX[i]-notesize[i]/2 && mouseX <=300+noteX[i]+notesize[i]/2 ){
            if( mouseY <= 300+(-1*noteY[i])+notesize[i]/2 && mouseY >= 300+(-1*noteY[i])-notesize[i]/2 ){
              //hit log
              //println("hitting");
              if(muteki==0){
                //get damage
                if(score==0){
                  //miss ensyutu
                  btntf = 2;
                }else{
                  score-=10.0;
                  muteki=5*fps;
                }
              }
            }
          }
        }

      }
      
    }
  }else if(btntf == 2){
    //gameover gamen
    bgm.close();
    textAlign(LEFT);
    textSize(120);
    fill(255,0,0);
    textFont(pFontData);
    text("FAILED...",20,220);
    fill(255);
    rect(100,400,200,110);
    fill(0);
    textSize(50);
    text("GO",110,450);
    text("BACK",110,500);
    if(mousePressed == true){
      if(mouseX >= 100 && mouseX <= 300 && mouseY >= 400 && mouseY <= 510){
        //back to start
        player = minim.loadFile("./assets/button.mp3");
        starts = minim.loadFile("./assets/start.mp3");
        bgm = minim.loadFile( "./assets/typhoon-parade.mp3");
        delayA = 0;
        frame_from_start = 0;
        score = 100;
        songlength = 94;
        btntf = 0;
      }
    }
  }else if(btntf == 3){
    //gamecler gamen
    bgm.close();
    textAlign(LEFT);
    textSize(120);
    fill(0,255,220);
    textFont(pFontData);
    text("CLEARED!!!",20,220);
    fill(255);
    rect(100,400,200,110);
    fill(0);
    textSize(50);
    text("GO",110,450);
    text("BACK",110,500);
    if(mousePressed == true){
      if(mouseX >= 100 && mouseX <= 300 && mouseY >= 400 && mouseY <= 510){
        //back to start
        player = minim.loadFile("./assets/button.mp3");
        starts = minim.loadFile("./assets/start.mp3");
        bgm = minim.loadFile( "./assets/typhoon-parade.mp3");
        delayA = 0;
        frame_from_start = 0;
        score = 100;
        songlength = 94;
        btntf = 0;
      }
    }
  }
    

  //Muteki jikan
  if(muteki!=0){
    muteki--;
    if(btntf==1){
      if(second_from_start%0.5<0.25){
      image(chara, charax, charay, 50, 50);
      }
    }else{
      image(chara, charax, charay, 50, 50);
    }
  }else{
    image(chara, charax, charay, 50, 50);
  }

  //Chara sousa
  //charax = mouseX-25;
  //charay = mouseY-25;
  //image(chara, charax, charay, 50, 50);
  charax = mouseX-25;
  charay = mouseY-25;
  image(teki, tekix-35, tekiy-35, 70, 70);
}
