import UnityEngine

class Grapple(MonoBehaviour):


    public _Owner as GameObject

    _anchor as Rigidbody
    _target as Rigidbody




    def Start():
        _anchor = gameObject.GetComponent[of Rigidbody]()
        _target = _Owner.GetComponent[of Rigidbody]()
        dist = (gameObject.transform.position - _Owner.transform.position).magnitude + 4f
        gameObject.GetComponent[of LineDrawer]()._Target = _Owner.transform
        for j in gameObject.GetComponents[of ConfigurableJoint]():
            j.connectedBody = _target
            j.linearLimit.limit = dist
            j.linearLimit.bounciness = 0.1f
            j.linearLimit.contactDistance = dist / 2f
            _anchor.isKinematic = true
            j.xMotion = 1
            j.yMotion = 1
            j.zMotion = 1

    def OnDisable():
        _anchor.isKinematic = false
        for j in gameObject.GetComponents[of ConfigurableJoint]():
            j.connectedBody = null
            j.xMotion = 2
            j.yMotion = 2
            j.zMotion = 2
        gameObject.Destroy(self)
