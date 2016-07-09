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
        if _Target:
            counter = 0
            for c as ConfigurableJoint in  gameObject.GetComponents[of ConfigurableJoint]():
                counter += 1
                _Line.SetPosition(counter, _Target.TransformPoint(c.connectedAnchor))

            _Line.SetPosition(counter + 1, _Xform.position)
            _Line.SetVertexCount(4)

        else:
            _Line.SetPosition(1, _Xform.position)
            _Line.SetVertexCount(2)
