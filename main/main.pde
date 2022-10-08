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
int selected_song;
PFont pFontData;
PFont pFontNormal;
int score;
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
final int SIZE = 600;
final int TOP_BAR = 100;
JSONArray jArray;
JSONObject detailObject;

void settings() {
  size(SIZE, SIZE + TOP_BAR);
}

void setup() {
  fps=60;
  frameRate(fps);

  //font load
  pFontData = loadFont("Arial-Black-48.vlw");
  pFontNormal = loadFont("Meiryo-48.vlw");
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
  score = 5;

  //damege wo uketatoki no mutekijikan
  muteki = 0;

  //sentakuchu no kyoku bangou 0 kara
  selected_song = 0;

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

void abox(int boxx,int boxy,int boxsize,int r,int g,int b,int opacity, int id){
  fill(r,g,b,opacity);
  rect(300+boxx-boxsize/2,300+(-1*boxy)-boxsize/2+TOP_BAR,boxsize,boxsize);
  textAlign(CENTER);
  fill(255);
  textSize(20);
  text(id, 300+boxx, 300+(-1*boxy)+TOP_BAR);
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
  
  charax = mouseX-25;
  charay = mouseY-25;
  
  if (btntf==0) {
    //Logo
    fill(255);
    textSize(30);
    textFont(pFontData);
    text("SQUARE",360,100);
    text("CAT",420,150);
    text("SURVIVAL",460,200);
    textFont(pFontNormal);

    fill(255,0,0);
    triangle(10, 60*selected_song+60, 10, 60*selected_song+100, 40, 60*selected_song+80);

    for(int i=0;i<amountList;i++){
      JSONObject humeninfoObject;
      humeninfoObject = stageNameArray.getJSONObject(i);
      String humenname = humeninfoObject.getString("name");
      

      fill(255);
      rect(50, i*60+60, 160, 40);
      fill(0);
      textAlign(CENTER);
      int fntsize = 20;
      if(humenname.length()<5){
        fntsize = 20;
      }else if(humenname.length()<10){
        fntsize = 16;
      }else{
        fntsize = 13;
      }
      textSize(fntsize);
      text(humenname, 50, i*60+70, 160, 40);

      if(mousePressed==true){
        if (mouseX>100 && mouseX<200 && mouseY>i*60+60 && mouseY<i*60+100) {
          //when start is pressed
          //println("humen clicked");
          if(i!=selected_song){
            senkyoku.rewind();
            senkyoku.play();
          }
          selected_song = i;
          humenpath = humeninfoObject.getString("path");
          //println(humeninfoObject.getString("path"));
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
        jArray = loadJSONArray(humenpath);
        detailObject = jArray.getJSONObject(0);
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
    //kyara not on the topbar
    if(mouseY <= 100){
      charay = 75;
    }
    
    String stagename;
    int amount;
    
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
      println("sec:"+second_from_start);


      //Start Stage Here
      
      //Box Array
      //int [] boxes;
      
      
      
      //JSONArray jArray;
      //jArray = loadJSONArray(humenpath);
      
      //JSONObject detailObject;
      //detailObject = jArray.getJSONObject(0);
      
      //stagename wo hyouji
      //stagename = detailObject.getString("stagename");
      //amount = detailObject.getInt("amount");
      //textAlign(LEFT);
      //textSize(16);
      //fill(255,255,255);
      //text(stagename,10,20);

      //image(lifeimg, 510, 2, 20, 20);

      //textAlign(RIGHT);
      //textSize(16);
      //fill(255,255,255);
      //text("×"+score,550,20);
      
      JSONObject humenObject;
      humenObject = jArray.getJSONObject(1);
      JSONArray humenArray;
      humenArray = humenObject.getJSONArray("humendata");
      
      //amount = detailObject.getInt("amount");
      amount = humenArray.size();
      
      int[] noteX = new int[amount];
      int[] noteY = new int[amount];
      int[] notesize = new int[amount];
      int[] notecheck = new int[amount];
      int[] notepop = new int[amount];
      int[] noterm = new int[amount];
      


      
      for(int i = amount-1; i >= 0; i--){
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
              abox( noteX[i] , noteY[i] , notesize[i] , 0 , 255 , 255 , 255, i+1 );
             }else{
              stroke(255,0,255);
              abox(noteX[i],noteY[i],notesize[i],255,0,255,75, i+1);
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
            if( charay+25 <= 300+(-1*noteY[i])+notesize[i]/2+TOP_BAR && charay+25 >= 300+(-1*noteY[i])-notesize[i]/2+TOP_BAR ){
              //hit log
              //println("hitting");
              if(muteki==0){
                //get damage
                if(score==0){
                  //miss ensyutu
                  btntf = 2;
                }else{
                  score-=1;
                  muteki=5*fps;
                }
              }
            }
          }
        }

      }
      
      
      
    }
    
    if(muteki != 0){
      muteki--;
      if(second_from_start%0.5<0.25){
        image(chara, charax, charay, 50, 50);
      }
    }else{
      image(chara, charax,charay ,50 ,50);
    }
    
    //draw top bar
    fill(99,252,111);
    noStroke();
    rect(-10,-10,SIZE+20,TOP_BAR+10);
    //life title text
    stagename = detailObject.getString("stagename");
    textAlign(LEFT);
    textSize(24);
    fill(0);
    text(stagename,10,20);

    image(lifeimg, 510, 2, 20, 20);
    textAlign(RIGHT);
    textSize(16);
    fill(0);
    text("×"+score,550,20);
    
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
        score = 5;
        songlength = 94;
        btntf = 0;
      }
    }
  }
  
  

    
  //Muteki jikan
  //if(muteki!=0){
  //  muteki--;
  //  if(btntf==1){
  //    if(second_from_start%0.5<0.25){
  //    image(chara, charax, charay, 50, 50);
  //    }
  //  }else{
  //    image(chara, charax, charay, 50, 50);
  //  }
  //}else{
  //  image(chara, charax, charay, 50 ,50);
  //}
  
  
  
  
  
  if(btntf != 1){
    image(chara, charax,charay ,50 ,50);
  }
  
  
  
  
  
  
  

  ////Chara hyouji
  //if(btntf != 1){
  //  charax = mouseX-25;
  //  charay = mouseY-25;
  //  image(teki, tekix-35, tekiy-35, 70, 70);
  //}else{
  //  if(mouseY <= 100){
  //    image(teki, tekix-35, 100, 70, 70);
  //  }
  //  image(teki, tekix-35, tekiy-35, 70, 70);
  //}
}
