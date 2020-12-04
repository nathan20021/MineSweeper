board board1;
PVector current = new PVector(-1,-1);
PVector hover = new PVector(0,0);
boolean playing = true;
boolean winning = false;
int[] hardness = {8,10,15,20,25};
int num_of_mine = 60;
int board_size = 18;
int num_of_flag = 0;
PImage flag_icon;
ArrayList<square> squareCoors = new ArrayList<square>();
String coor;
square hover_square;

void show_end(){
  fill(227, 82, 82);
  rect(100,260,500,200);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("GAME OVER!",350,350);
}

void show_win(){
  fill(123, 227, 136);
  rect(100,260,500,200);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("YOU WIN!",350,350);
}

void setup(){
  size(700,700);
  flag_icon = loadImage("flag.png");
  board1 = new board(40,40, 35, board_size);
  board1.add_mine(num_of_mine);
  board1.add_numbers();
  for(int i=0; i<board_size; i++){
   for(int j=0; j<board_size; j++){
     squareCoors.add(new square(new PVector(i,j), board1.scale));
   }
  }
  for(int i =0; i<board1.size;i++){
   for(int j=0; j<board1.size; j++){
     if(board1.num_array[i][j] == 0){
       for(int a=0; a<squareCoors.size(); a++){
         if(squareCoors.get(a).coor.x == i && squareCoors.get(a).coor.y == j){
           squareCoors.get(a).scale = 0;
         }
       }
     }
   }
  }
}

void draw(){
  background(199,199,199);
  board1.showbg();
  fill(0);
  if((int)current.x!=-1){
    coor= Integer.toString((int)current.x)+" " +Integer.toString((int)current.y);
    textAlign(LEFT);
    textSize(20);
    text(coor,10,20);
  }
  
  board1.show_num();
  fill(32, 36, 33);
  rect(580, 5, 50, 30);
  fill(211, 232, 216);
  text(num_of_mine-num_of_flag, 600, 30);
  image(flag_icon, 610, 5, board1.scale-10, board1.scale-10);
  
  for(mine mine1 :board1.mines){
   mine1.show(board1.origin, board1.scale);
   if((int)current.x==mine1.coor.x&&(int)current.y==mine1.coor.y){
     winning = false;
     playing = false;
   }
  }
  if(playing){
    if(mouseX>board1.origin.x&&mouseX<board1.origin.x+(board1.scale *board1.size)){
      if(mouseY>board1.origin.y&&mouseY<board1.origin.y+(board1.scale *board1.size)){
        hover.x = (int)floor((mouseY-board1.origin.x)/board1.scale);
        hover.y = (int)floor((mouseX-board1.origin.y)/board1.scale);
      }else{
        hover = new PVector(-1,-1);
      }
    }else{
      hover = new PVector(-1,-1);
    }
  }
  
  for(int i=0; i<squareCoors.size(); i++){
    square square1 = squareCoors.get(i);
    if(square1.coor.x == hover.x && square1.coor.y == hover.y){
      square1.hover = true;
    }else{
      square1.hover = false;
    }
     square1.show(board1.origin);
  }
  
  if(num_of_mine-num_of_flag==0){
    int counter = 0;
    for(square square1 : squareCoors){
      for(mine mine1 : board1.mines){
        if(square1.coor.x==mine1.coor.x && square1.coor.y==mine1.coor.y && square1.flag==true){
          counter++;
        }
      }
    }
    
    if(counter == num_of_mine){
      playing = false;
      winning = true;  
    }
  }
  
  if(playing==false){
    hover.x = -1;
    hover.y = -1;
    for(int i =0; i<squareCoors.size();i++){
       squareCoors.get(i).scale = 0;
    }
    if(winning){
      show_win();
    }else{
      show_end();
    }
  }
  
}

void mouseReleased(){
  if(mouseButton == LEFT){
    current.x = hover.x;
    current.y = hover.y;
     for(int i =0; i<squareCoors.size();i++){
       if(squareCoors.get(i).coor.x==hover.x &&squareCoors.get(i).coor.y==hover.y){
         squareCoors.get(i).scale = 0;
         if(squareCoors.get(i).flag == true){
           num_of_flag--;
         }
       }
     }
  }else if(mouseButton == RIGHT){
     for(int i =0; i<squareCoors.size();i++){
       if(squareCoors.get(i).coor.x==hover.x &&squareCoors.get(i).coor.y==hover.y){
         if(squareCoors.get(i).flag == false){
           squareCoors.get(i).flag = true;
           if(squareCoors.get(i).scale !=0){
             num_of_flag++;
           }
         }else{
           squareCoors.get(i).flag = false;
           if(squareCoors.get(i).scale !=0){
             num_of_flag--;
           }
         }
       }
     }        
  }  
}
