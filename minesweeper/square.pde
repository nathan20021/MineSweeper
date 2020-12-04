class square{
  
 PVector coor;
 int scale;
 boolean flag = false;
 public boolean hover = false;
 PImage sprite;
 
  square(PVector _coor,int _scale){
    coor = _coor;
    scale = _scale;
    sprite = loadImage("flag.png");
  }
  
  public void show(PVector _origin){
     strokeWeight(1.2);
     stroke(0);
     if(hover == false){
       fill(103, 133, 117);
     }else{
       fill(3, 252, 48);      
     }
     rect(_origin.y +(scale*coor.y), _origin.x+(scale*coor.x), scale, scale);
     if(flag){
       image(sprite, _origin.y +(scale*coor.y), _origin.x+(scale*coor.x), scale, scale);
     }
  }
}
