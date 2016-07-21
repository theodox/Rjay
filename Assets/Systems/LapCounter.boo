import UnityEngine


public class LapCounter(HasHud):

    public _Targets as (LapGoal)
    public _LapCount = 0
    public _Times = List[of single]()

    next = 1
    inner_list as List

    public def Start():
        inner_list = [i  for i in _Targets]
        _hud = "Score: 0"
        _Times.Add(Time.time)


    public def Lap( lapStruct as  LapStruct):
        g as LapGoal = lapStruct.Goal
        idx = inner_list.IndexOf(g)
        if idx == next:
            next += 1
            next = next % len(_Targets)
            if next == 0:
                Debug.Log("Lapped")
                _LapCount += 1
                _hud = "Score: {0}" % (_LapCount, )
                _Times.Add(Time.time)
