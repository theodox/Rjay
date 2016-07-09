import UnityEngine
import Mathf


public struct Vernier():

    public distance as single
    public thrust  as single
    public axis  as Vector3
    public offset as Vector3

    def constructor(_distance as single, _thrust as single, _axis as Vector3, _offset as Vector3 ):
        distance = _distance
        thrust = _thrust
        axis = _axis
        offset = _offset

public class ReactionThruster(MonoBehaviour):
"""
Apply force along a multiple vectors, falling off with distance.
Reaches theoretical max output at 0 distance to hit, falls off
to no output at distance, by exponent `_Falloff`
"""

    public _Falloff = 3
    public _Thrusters as (Vernier)


    _rb as Rigidbody
    _xform as Transform
    _hit as RaycastHit

    def Start():
        _rb = gameObject.GetComponent[of Rigidbody]()
        _xform = gameObject.transform
        if not _Thrusters:
            _Thrusters = ( Vernier(4.0, 200.0, Vector3.forward, Vector3.zero), )
    def OnDrawGizmosSelected    ():
        xf = _xform or gameObject.transform
        for t in _Thrusters:

            Gizmos.color = Color.red
            Gizmos.DrawRay(
                xf.TransformPoint(t.offset),
                xf.TransformDirection( t.axis * t.distance)
                )


    def FixedUpdate():

        for t in _Thrusters:

            v = _xform.TransformDirection(t.axis)
            p = _xform.TransformPoint(t.offset)

            if Physics.Raycast( p, v, _hit, t.distance):
                d = 1 - Pow( _hit.distance / t.distance, _Falloff)
                _rb.AddForceAtPosition(v * d * t.thrust * -1 * Time.deltaTime, p, ForceMode.Force)
