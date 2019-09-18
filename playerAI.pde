public interface playerAI {
  public ship placeCarrier();
  public ship placeBattleship();
  public ship placeCruiser();
  public ship placeSubmarine();
  public ship placeDestroyer();
  public int[] getNextShot();
  public String getName();
}
