import UnityEngine
import System.Collections

class GrappleGun (MonoBehaviour):

    public _Grapple as GameObject
    public _Parent as GameObject
    _ParentRB as Rigidbody
    _Xform as Transform
    _hits as (RaycastHit)
    _ready = true
    _Spring as SpringJoint

    def Start():
        _ParentRB = _Parent.GetComponent[of Rigidbody]()
        _Xform = gameObject.transform
        _Spring = _Grapple.GetComponent[of SpringJoint]()

    def Update():
        if _ready and Input.GetAxis("Jump"):
            _hits = _ParentRB.SweepTestAll(_Xform.forward, 500 )
            _ready = false
        else:
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
            _Grapple.transform.position = nearest
            _Spring.maxDistance = distant
            _Grapple.SetActive(true)

        StartCoroutine(self.Reload())
        StartCoroutine(self.Drop())

    def Reload() as IEnumerator:
        yield WaitForSeconds(2.0)
        _ready = true

    def Drop() as IEnumerator:
        yield WaitForSeconds(5)
        _Grapple.SetActive(false)
