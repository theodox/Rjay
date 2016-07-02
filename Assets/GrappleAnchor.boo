import UnityEngine

public class GrappleAnchor(MonoBehaviour):


    public _Owner as GameObject

    _rb as Rigidbody

    def Start():
        _rb = gameObject.GetComponent[of Rigidbody]()

    def OnCollisionEnter(c as Collision):
        _rb.isKinematic = true
        comp = gameObject.AddComponent[of Grapple]()
        comp._Owner = _Owner
