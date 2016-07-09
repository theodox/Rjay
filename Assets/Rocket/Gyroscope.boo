import UnityEngine
import bootils
import Mathf

public class Gyroscope(HasHud):

    public _Pitch = 10f
    public _Roll = 50f
    public _Slew = 100f
    public _Response = 1
    public _DragRange  = Vector2(.6, .1)
    _rb as Rigidbody
    _xform as Transform
    xz_plane = Vector3(1,0,1)

    right as Vector3
    roll as single

    def Start():
        _rb = gameObject.GetComponent[of Rigidbody]()
        _xform = gameObject.transform


    def FixedUpdate():

        right = _xform.right
        roll = ProjectAxis(right, xz_plane)

        forward = _xform.forward
        pitch = ProjectAxis(forward, xz_plane)


        travel = _rb.velocity.ScaleBy(xz_plane).normalized
        if travel.magnitude < .1f:
            travel = forward

        orient = forward.ScaleBy(xz_plane).normalized
        slew = Vector3.Dot(travel, orient)
        slew *= Sign(Vector3.Dot(travel, right.ScaleBy(xz_plane)))


        m = 1 - Clamp(Min(Abs(pitch), Abs(roll)), 0, 1)
        _rb.angularDrag = Lerp(0.3f, 1f, m)
        _rb.drag = Lerp(_DragRange.x, _DragRange.y, Abs(slew))

        t = Vector3 ( pitch * _Pitch, slew * _Slew, roll * _Roll * -1)
        _rb.AddTorque(t * Time.deltaTime)

        _hud = "r {0:f} p {1:f} y {2:f}" % (roll, pitch, slew)



    def ProjectAxis (vec as Vector3, plane as Vector3) as single:
        flattened = vec.ScaleBy(plane).normalized
        dif = vec - flattened
        return  Atan(dif.y)

    def OnDrawGizmos():
        Gizmos.color = Color.red
        Gizmos.DrawRay(
            (_xform or gameObject.transform).position,
            right
            )
