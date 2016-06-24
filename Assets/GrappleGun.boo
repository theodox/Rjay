import UnityEngine
import System.Collections

class GrappleGun (MonoBehaviour):


    _Parent as GameObject
    _ParentRB as Rigidbody
    _Xform as Transform
    _MyRB as Rigidbody
    _hits as (RaycastHit)
    _ready = true

    def Start():
        _Parent = gameObject.transform.parent.gameObject
        _ParentRB = _Parent.GetComponent[of Rigidbody]()
        _MyRB = gameObject.GetComponent[of Rigidbody]()
        _Xform = gameObject.transform

    def Update():
        if _ready and Input.GetAxis("Fire1"):
            _hits = _MyRB.SweepTestAll(_Xform.forward, 500 )
            _ready = false
        else:
            Debug.Log(_ready)
            return

        nearest  as Vector3
        distant  = 999.0
        pos = _Xform.position

        for h in _hits:
            d = Vector3.Distance(pos, h.point)
            if d < distant:
                distant = d
                nearest = h.point

        if nearest != Vector3.zero:
            cube = GameObject.CreatePrimitive(PrimitiveType.Cube)
            cube.transform.position = nearest

        StartCoroutine(self.Reload())

    def Reload() as IEnumerator:
        yield WaitForSeconds(2.0)
        _ready = true
