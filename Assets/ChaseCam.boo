import UnityEngine


public class ChaseCam(HasHud):
    public _Target as GameObject
    public _Camera as GameObject
    public _Distance = 5f
    public _Recenter = 0.1f
    public _YawSpeed = 10f
    public _PitchSpeed = 50f
    public _TurnCam = 40f

    _pitch = 10f
    _yaw = 0f
    _lookahead = 0
    _target_xform as Transform
    _xform as Transform

    _debug_rect = Rect(10,70, 240, 20)

    def Start():
        _target_xform = _Camera.transform
        _xform  = gameObject.transform

    def Update():
        y = Input.GetAxis("CameraYaw")
        p = Input.GetAxis("CameraPitch")



        if Abs(y) > .01 :
            _yaw += y * Time.deltaTime * _YawSpeed
        else:
            _yaw *= 1 - (_Recenter * Time.deltaTime)

        # todo: clamp contributuion
        turn = Input.GetAxis("Horizontal")
        if Abs(turn) > .01:
            _lookahead += turn * Time.deltaTime * _YawSpeed
        else:
            _lookahead *= 1 - (_Recenter * Time.deltaTime)

        _lookahead = Clamp(_lookahead, -1 * _TurnCam, _TurnCam) / _TurnCam

        if Abs(p) > .01 :
            _pitch += -p * Time.deltaTime * _PitchSpeed
        else:
            _pitch *= 1 - (_Recenter * Time.deltaTime)

        _pitch = Clamp(_pitch, 0f, 30f)


        _xform.localEulerAngles = Vector3(_pitch, 0, _yaw + (Pow(_lookahead, 2) * _TurnCam))
        _target_xform.localPosition = Vector3(0, - 1 * _Distance, 0)

        _hud = "ChaseCam: {0:F}, {1:F}" % (_yaw, _pitch)
