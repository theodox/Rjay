import UnityEngine

public class GameEnder(MonoBehaviour):

  public  _EndScreen as GameObject

  def OnCrash():
    GameState.GetInstance()._State = GameStateEnum.Ended
    _EndScreen.SetActive(true)
