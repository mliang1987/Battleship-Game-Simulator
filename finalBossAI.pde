class finalBossAI implements playerAI {

  int x;
  int y;
  boolean destroyMode;
  String name;
  
  public finalBossAI() {
    x = -1;
    y = 0;
    destroyMode = false;
    name = "Reference AI";
  }

  public ship placeCarrier(){
    return new carrier(2,8, false);
  }
  public ship placeBattleship(){
    return new battleship(3, 2, false);
  }
  public ship placeCruiser(){
    return new cruiser(6,4,false);
  }
  public ship placeSubmarine(){
    return new submarine(2,4,true);
  }
  public ship placeDestroyer(){
    return new destroyer(1,1,true);
  }

  public String getName(){
    return name; 
  }

  public int[] getNextShot() { 
    if(destroyMode == true){
      return destroyMode(); 
    }
    else{
      return huntMode(); 
    }
  }
  
  public int[] huntMode(){
    x = x + 1;
    if( x>9){
      x = 0;
      y++;
    }
    if( y>9){
      y = 0; 
    }
    int[] coordinate = {x, y};
    return coordinate;    
  }
  
  public int[] destroyMode(){
    int[] coordinate = {0, 0};
    return coordinate;
  }
  
}
