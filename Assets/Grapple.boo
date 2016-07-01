import UnityEngine

class Grapple(MonoBehaviour):


    public _Owner as GameObject

    _anchor as Rigidbody
    _target as Rigidbody
    _joint  as ConfigurableJoint




    def Start():
        _anchor = gameObject.GetComponent[of Rigidbody]()
        _target = _Owner.GetComponent[of Rigidbody]()
        _joint = gameObject.AddComponent[of ConfigurableJoint]()
        _joint.connectedBody = _target
        dist = (gameObject.transform.position - _Owner.transform.position).magnitude + 0.5f
        _joint.linearLimit.limit = dist
        _joint.linearLimit.bounciness = 0.1f
        _joint.linearLimit.contactDistance = 4f
        _anchor.isKinematic = true
        _joint.xMotion = 0
        _joint.yMotion = 0
        _joint.zMotion = 0

    def OnDisable():
        _anchor.isKinematic = false
        gameObject.Destroy(_joint)
        gameObject.Destroy(self)
