import UnityEngine
import bootils
import Mathf

public class Gyroscope(HasHud):

    public _Pitch = 10f
    public _Roll = 50f
    public _Response = 1
    _rigidbody as Rigidbody
    _xform as Transform

    def Start():
        _rigidbody = gameObject.GetComponent[of Rigidbody]()
        _xform = gameObject.transform

    def FixedUpdate():
        pitch_off = Pow( Vector3.Dot(_xform.up, Vector3.up), _Response) / Time.smoothDeltaTime
        roll_off = Pow ( Vector3.Dot(_xform.right, Vector3.up), _Response) / Time.smoothDeltaTime
        _rigidbody.AddRelativeTorque(Vector3.right * pitch_off * _Pitch )
        _rigidbody.AddRelativeTorque(Vector3.up *  roll_off * _Roll)

        _hud = "pitch {0:f} roll {1:f}" % (pitch_off * _Pitch, roll_off * _Roll)
