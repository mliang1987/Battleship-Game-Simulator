class ocean {
  private int[][] ocean_values;
  playerAI playerOwner;
  int playerNumber;

  public ocean(playerAI p, int pN) {
    ocean_values = new int[10][10];
    this.playerOwner = p;
    this.playerNumber = pN;
  }
  
  public boolean isValid(int x, int y){
    return !(x<0||x>10||y<0||y>10||ocean_values[x][y]!=0);
  }
  
  public int getCell(int x, int y){
    return (ocean_values[x][y]>=0)? 0 : ocean_values[x][y];
  }
  
  public void shootAt(int x, int y){
    if(ocean_values[x][y] > 0){
       ocean_values[x][y] = ocean_values[x][y]*-1;
    }
    else if(ocean_values[x][y]==0 ){
        ocean_values[x][y] = -7;
    }
  }
  
  public boolean placeShip(ship s){
    if(checkPlacement(s)==false){
      return false; 
    }
    else{
      if(s.isVertical){
        for(int cy = s.y; cy<s.y+s.size; cy++){
          if(s.name.equals("Submarine")){
            ocean_values[s.x][cy] = 6;          
          }
          ocean_values[s.x][cy] = s.size;          
        }
      }
      else{
        for(int cx = s.x; cx<s.x+s.size; cx++){
          if(s.name.equals("Submarine")){
            ocean_values[cx][s.y] = 6;          
          }
          ocean_values[cx][s.y] = s.size;          
        }        
      }
      return true;
    }
  }
  
  private boolean checkPlacement(ship s){
    if (s.isVertical) {
      for(int cx = s.x-1; cx <= s.x+1; cx++){
        for(int cy = s.y-1; cy < s.y+s.size+1; cy++){
          if(this.isValid(cx,cy)==false){
             return false; 
          }
        }
      }
      return true;
    } 
    else {
      for(int cx = s.x-1; cx < s.x+s.size+1; cx++){
        for(int cy = s.y-1; cy <= s.y+1; cy++){
          if(this.isValid(cx,cy)==false){
             return false; 
          }
        }
      }
      return true;
    }
  }
  
  public boolean verifyWin(){
    int hitCount = 0;
    for(int x=0; x<ocean_values.length; x++){
      for(int y=0; y<ocean_values.length; y++){
        if(ocean_values[x][y]<0&&ocean_values[x][y]>-6){
          hitCount++; 
        }
      }
    }
    return hitCount == 17;
  }
  
  public void show(){
    rectMode(CORNER);
    stroke(255,255,255);
    float x_offset;
    float y_offset;
    if(this.playerNumber == 1)
      x_offset = -kCELL_WIDTH*13;
    else
      x_offset = kCELL_WIDTH*3;
    y_offset = -kCELL_HEIGHT*5;
    for(int x = 0; x<ocean_values.length; x++){
      for(int y = 0; y<ocean_values.length; y++){
        if(ocean_values[x][y]==0){
          fill(0,0,255);
        }
        else if(ocean_values[x][y]>0){
          fill(150,150,255); 
        }
        else if(ocean_values[x][y]==-7){
          fill(230,230,230);
        }
        else {
          fill(255,0,0); 
        }
        rect( width/2 + x*kCELL_WIDTH+x_offset, height/2 + y*kCELL_HEIGHT+y_offset ,kCELL_WIDTH ,kCELL_HEIGHT);
      }
    }
  }
}
