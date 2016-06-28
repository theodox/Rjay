import UnityEngine


public class ChaseCam(MonoBehaviour):
    public _Target as GameObject
    public _Camera as GameObject
    public _Distance = 5f
    public _Recenter = 0.1f
    public _YawSpeed = 10f
    public _PitchSpeed = 50f
    public _TurnCam = 0.1f

    _pitch = 10f
    _yaw = 0f
    _target_xform as Transform
    _xform as Transform

    _debug_rect = Rect(10,70, 240, 20)

    def Start():
        _target_xform = _Camera.transform
        _xform  = gameObject.transform
\
    def Update():
        y = Input.GetAxis("CameraYaw")
        p = Input.GetAxis("CameraPitch")

        # todo: clamp contributuion
        y += Input.GetAxis("Horizontal") * _TurnCam

        if Abs(y) > .01 :
            _yaw += y * Time.deltaTime * _YawSpeed
        else:
            _yaw *= 1 - (_Recenter * Time.deltaTime)

        if Abs(p) > .01 :
            _pitch += -p * Time.deltaTime * _PitchSpeed
        else:
            _pitch *= 1 - (_Recenter * Time.deltaTime)

        _pitch = Clamp(_pitch, 0f, 30f)


        _xform.localEulerAngles = Vector3(_pitch, 0, _yaw)
        _target_xform.localPosition = Vector3(0, - 1 * _Distance, 0)
