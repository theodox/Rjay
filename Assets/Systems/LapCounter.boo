import UnityEngine


public class LapCounter(MonoBehaviour):

    public _Targets as (LapGoal)
    public _LapCount = 0

    next = 0
    inner_list as List

    public def Start():
        inner_list = [i  for i in _Targets]

    public def Lap( lapStruct as  LapStruct):
        g as LapGoal = lapStruct.Goal
        idx = inner_list.IndexOf(g)
        if idx == next:
            next += 1
            next = next % len(_Targets)
            Debug.Log("Lapped")
