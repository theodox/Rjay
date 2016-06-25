import UnityEngine
import Mathf

public class ReactionThruster(MonoBehaviour):
"""
Apply force along a relative vector, falling off with distance.
Reaches theoretical max output at 0 distance to hit, falls off
to no output at distance, by exponent `_Falloff`
"""

    public _Distance = 3.0
    public _Falloff = 3
    public _Thrust = 100.0
    public _Axis = Vector3( 0, 0, 1 )


    _rb as Rigidbody
    _xform as Transform
    _hit as RaycastHit

    def Start():
        _rb = gameObject.GetComponent[of Rigidbody]()
        _xform = gameObject.transform

    def OnDrawGizmosSelected    ():
        xf = _xform or gameObject.transform
        Gizmos.color = Color.red
        Gizmos.DrawRay(
            xf.position,
            xf.TransformDirection( _Axis * _Distance)
            )


    def FixedUpdate():
        v = _xform.TransformDirection(_Axis)

        if Physics.Raycast( _xform.position, v, _hit, _Distance):
            d = 1 - Pow( _hit.distance / _Distance, _Falloff)
            _rb.AddForce(v * d * _Thrust * -1, ForceMode.Force)
