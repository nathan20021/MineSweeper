class board{
  
  //Atributes
  public PVector origin = new PVector();
  public int scale;
  public int size;
  public ArrayList<mine> mines = new ArrayList<mine>();
  public int[][] num_array;
  
  
  public board(int _x, int _y, int _scale, int _size){
    origin.x = _x;
    origin.y = _y;
    scale = _scale;
    size = _size;
    num_array = new int[_size][_size];
  }
  
  //Methods
  public void showbg(){
    for(int i=0; i<size; i++){
       for(int j =0; j<size; j++){
        stroke(0);
        strokeWeight(1.2);
        fill(204,204,204);
        rect(origin.x +(scale*i), origin.y+(scale*j), scale, scale);
         
       }
    }
  }
  
  public void add_mine(int num){
    for(int i = 0; i<num; i++){
      int _x = (int) random(0, size);
      int _y = (int) random(0, size);
      boolean looping = true;
      while(looping){
        looping = false;
        for(int j=0; j<i; j++){
          mine _mine = mines.get(j);
          if(_mine.coor.x == _x && _mine.coor.y == _y){
           looping = true;
            _x = (int) random(0, size);
            _y = (int) random(0, size);
            break;
          }
        }
      }
      mines.add(new mine(_x,_y));
    }
  }
  
  public void add_numbers(){
    for(int i=0; i<size; i++){
     for(int j=0; j<size; j++){
        int mine_num = 0;
        for(int a = i-1; a<=i+1;a++){
          for(int b = j-1; b<=j+1;b++){
            for(mine mine1:mines){
             if(a == mine1.coor.x && b==mine1.coor.y){
              mine_num++; 
             }
            }
          }
        }
        num_array[i][j] = mine_num;
     }
   }
    
    for(mine mine1:mines){
      num_array[(int)mine1.coor.x][(int)mine1.coor.y] = -1;
    }
    this.printBoard();
  }
  
  public void printBoard(){
    for(int[] i:num_array){
     for(int element: i){
       if(element != -1){
         print(element+" ");
       }else{
          print(". "); 
       }
     }
     println();
    }
  }
  
  public void show_num(){
    textSize(20);
    strokeWeight(1.5);
    fill(0);
    textAlign(CENTER);
    for(int i=0; i<size; i++){
      for(int j=0; j<size; j++){
        if(num_array[j][i] != 0){
          text(num_array[j][i], origin.x+(scale*i)+(scale/2), origin.y+(scale*j)+(scale/2)+10);
        }
      }
    }
  }
}
