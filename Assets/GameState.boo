
# use this for all shared state

public enum GameStateEnum:
		None
		Starting
		Running
		Ended

public class GameState:

	public _State as GameStateEnum

	def constructor():
    	_State = GameStateEnum.None

  	public static _instance as GameState

	public static def GetInstance() as GameState:
		if not GameState._instance:
			GameState._instance = GameState()
		return GameState._instance
