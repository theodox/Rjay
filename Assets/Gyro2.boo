import UnityEngine
import Mathf

class Gyro2(HasHud):

    public _RollForce = 100f
    public _PitchForce = 100f
    public _SlewForce = 100f

    _rb as Rigidbody
    _xform as Transform
    xz_plane = Vector3(1,0,1)

    def Start():
        _rb = gameObject.GetComponent[of Rigidbody]()
        _xform = gameObject.transform

    def FixedUpdate():

        right = _xform.right
        roll = ProjectAxis(right, xz_plane)

        forward = _xform.forward
        pitch = ProjectAxis(forward, xz_plane)


        travel = _rb.velocity.ScaleBy(xz_plane)
        if travel.magnitude < .1f:
            travel = _xform.forward

        orient = _xform.forward.ScaleBy(xz_plane)
        slew = Vector3.Dot(travel, forward)
        slew = 1 - slew
        slew *= Sign(Vector3.Dot(travel, right.ScaleBy(xz_plane)))


        m = 1 - Clamp(Min(Abs(pitch), Abs(roll)), 0, 1)
        _rb.angularDrag = Lerp(0.3f, 1f, m)
        _rb.drag = Lerp(.6, .1, Abs(slew))

        t = Vector3 ( pitch * _PitchForce, slew * _SlewForce, roll * _RollForce * -1)
        _rb.AddTorque(t)
        _hud = "r {0:f} p {1:f} y {2:f}" % (roll, pitch, slew)



    def ProjectAxis (vec as Vector3, plane as Vector3) as single:
        flattened = vec.ScaleBy(plane).normalized
        dif = vec - flattened
        return  Atan(dif.y)
