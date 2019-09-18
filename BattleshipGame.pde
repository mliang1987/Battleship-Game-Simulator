public final int kCELL_WIDTH = 30;
public final int kCELL_HEIGHT = 30;

int step = 0;
int nextStep = 0;
ocean oceanPlayer1;
ocean oceanPlayer2;
playerAI[] thePlayers;
playerAI player1;
playerAI player2;
int mode;
int[] p1shot;
int[] p2shot;

void setup() {
  mode = 0;
  thePlayers = new playerAI[2];
  thePlayers[0] = new referenceAI();
  thePlayers[1] = new finalBossAI();
  fullScreen();
  background(0);
}

void draw() {
  switch (mode) {
  case 0:   
    menuMode();
    break;
  case 1:   
    setupMode();
    break;
  case 2:
    playMode();
    break;
  case 3:
    endGameMode();
    break;
  case 4:
    endGameMode();
    break;
  case 5:
    endGameMode();
    break;
  case 6:
    endGameMode();
    break;
  case 7:
    endGameMode();
    break;
  case 8:
    endGameMode();
    break;
  default:  
    menuMode();
    break;
  }
}

void menuMode() {
  background(0);
  textAlign(CENTER, CENTER);
  textSize(140);
  fill(255);
  stroke(0);
  text("BATTLESHIP!", width/2, height/2-70);
  textSize(50);
  text("Press Enter to Begin!", width/2, height/2+50);
}

void setupMode() {
  thePlayers = new playerAI[2];
  thePlayers[0] = new referenceAI();
  thePlayers[1] = new finalBossAI();
  fullScreen();
  background(0);
  int p1Index = 0;
  player1 = thePlayers[p1Index];
  for (int p2Index = 0; p2Index < thePlayers.length-1; p2Index++) {
    if (p2Index == p1Index)
      p2Index++;
    player2 = thePlayers[p2Index];
    setupGame();
  }
  mode++;
}

void setupGame() {
  background(0);
  oceanPlayer1 = new ocean(player1, 1);
  oceanPlayer2 = new ocean(player2, 2);
  ship[] p1ships = new ship[5];
  ship[] p2ships = new ship[5];
  p1ships[0] = player1.placeCarrier();
  p1ships[1] = player1.placeBattleship();
  p1ships[2] = player1.placeCruiser();
  p1ships[3] = player1.placeSubmarine();
  p1ships[4] = player1.placeDestroyer();
  p2ships[0] = player2.placeCarrier();
  p2ships[1] = player2.placeBattleship();
  p2ships[2] = player2.placeCruiser();
  p2ships[3] = player2.placeSubmarine();
  p2ships[4] = player2.placeDestroyer();
  boolean p1placed = true;
  boolean p2placed = true;
  for (int i = 0; i < 5 && p1placed==true; i++) {
    p1ships[i].player = 1;
    p1placed = oceanPlayer1.placeShip(p1ships[i]);
  }
  for (int i = 0; i < 5 && p2placed==true; i++) {
    p2ships[i].player = 2;
    p2placed = oceanPlayer2.placeShip(p2ships[i]);
  }
  if (!p1placed && !p2placed) 
    mode = 3;
  else if (!p1placed)
    mode = 4;
  else if (!p2placed)
    mode = 5;
}

void playMode() {
  background(0);
  if (nextStep != step) {
    step++; 
    p1shot = player1.getNextShot();
    p2shot = player2.getNextShot();
    if (verifyShot(p1shot)) {
      oceanPlayer1.shootAt(p1shot[0], p1shot[1]);
    }
    if (verifyShot(p2shot)) {
      oceanPlayer2.shootAt(p2shot[0], p2shot[1]);
    }
  }
  oceanPlayer1.show();
  oceanPlayer2.show();
  if (step>0) {
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255);
    stroke(0);
    text("Player 1 shot at "+p1shot[0]+", "+p1shot[1]+"!", width/2-kCELL_WIDTH*8, height/2+kCELL_HEIGHT*8);
    text("Player 2 shot at "+p2shot[0]+", "+p2shot[1]+"!", width/2+kCELL_WIDTH*8, height/2+kCELL_HEIGHT*8);
  }
  if (oceanPlayer1.verifyWin() && oceanPlayer2.verifyWin()) {
    mode = 8;
  } else if (oceanPlayer1.verifyWin()) {
    mode = 7;
  } else if (oceanPlayer2.verifyWin()) {
    mode = 6;
  }
}

boolean verifyShot(int[] shot) {
  int x = shot[0];
  int y = shot[1];
  return x>=0 && x<=9 && y>=0 && y<=9;
}

void endGameMode() {
  background(0);
  textAlign(CENTER, CENTER);
  textSize(140);
  fill(255);
  stroke(0);
  if (mode == 3) {
    text("The game is over!", width/2, height/2-70);
    textSize(50);
    text("Both players had invalid ship placement!", width/2, height/2+50);
  } else if (mode == 4) {
    text("The game is over!", width/2, height/2-70);
    textSize(50);
    text("Player 1 had invalid ship placement!", width/2, height/2+50);
  } else if (mode == 5) {
    text("The game is over!", width/2, height/2-70);
    textSize(50);
    text("Player 2 had invalid ship placement!", width/2, height/2+50);
  } else if (mode == 6) {
    text("The game is over!", width/2, height/2-70);
    textSize(50);
    text("Player 1 wins!", width/2, height/2+50);
  } else if (mode == 7) {
    text("The game is over!", width/2, height/2-70);
    textSize(50);
    text("Player 2 wins!", width/2, height/2+50);
  } else if (mode == 8) {
    text("The game is over!", width/2, height/2-70);
    textSize(50);
    text("Both players lose!", width/2, height/2+50);
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    mode++;
    if(mode == 9){
      mode = 0; 
    }
    else if (mode > 1) {
      mode = 1;
    }
  }
  if (keyCode == UP) {
    nextStep++;
  }
}

public int getCell(int x, int y, playerAI p) {
  if (oceanPlayer1.playerOwner == p)
    return oceanPlayer1.getCell(x, y);
  else if (oceanPlayer2.playerOwner == p)
    return oceanPlayer2.getCell(x, y);     
  else
    return -7;
}
