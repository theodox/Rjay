import UnityEngine


public struct LapStruct:
    Goal as LapGoal
    Collider as Collider

    public def constructor(c as LapGoal, cl  as Collider):
        Goal = c
        Collider = cl

public class LapGoal(MonoBehaviour):


    def OnTriggerEnter(col as Collider):
        msg = LapStruct()

        SendSystemMessage("Lap",  LapStruct(self, col))
