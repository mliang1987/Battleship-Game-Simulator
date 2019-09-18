class ship {
  int size;
  int x;
  int y;
  boolean isVertical;
  String name;
  int player;

  public ship(int x, int y, boolean isVert) {
    this.x = x;
    this.y = y;
    this.isVertical = isVert;
    player = 0;
  }

}
