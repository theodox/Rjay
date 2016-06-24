import UnityEngine

public class LineDrawer(MonoBehaviour):

    public _Target as Transform
    _Line as LineRenderer
    _Xform as Transform

    def Start():
        _Line = gameObject.GetComponent[of LineRenderer]()
        _Xform = gameObject.transform
        
    def Update():
        _Line.SetPosition(0, _Xform.position)
        _Line.SetPosition(1, _Target.position)
