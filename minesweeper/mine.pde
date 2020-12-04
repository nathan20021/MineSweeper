class mine{
  
  public PImage sprite;
  static final String sprite_name = "mine.png"; 
  public PVector coor = new PVector();
  
  //Methods
  mine(int _x, int _y){
    coor.x = _x;
    coor.y = _y;
    sprite = loadImage(sprite_name);
  }
  
  public void show(PVector _origin, int _scale){
    image(sprite, _origin.y+(coor.y*_scale), _origin.x+(coor.x*_scale), _scale, _scale);
  }
  
}
