import UnityEngine
import Mathf

class PlayerCam(HasHud):

    public _Reference as GameObject

    public _Recenter = 0.1f
    public _YawSpeed = 10f
    public _PitchSpeed = 50f
    public _TurnCam = 0.1f

    public _PreservePitch = 0.2f
    public _PreserverRoll = 0.1f

    _lookahead = 0f
    _yaw = 0f
    _pitch = 0f

    _xform as Transform
    _reference as Transform

    final _deadzone = 0.05f
    final _plane = Vector3(1,0,1)

    def Start():
        _xform = gameObject.transform
        _reference = _Reference.transform

    def LateUpdate():
        y = Input.GetAxis("CameraYaw")
        p = Input.GetAxis("CameraPitch")
        turn = Input.GetAxis("Horizontal")

        if Abs(y) > _deadzone :
            _yaw += y * Time.deltaTime * _YawSpeed
        else:
            _yaw *= 1 - (_Recenter * Time.deltaTime)

        if Abs(turn) > _deadzone:
            _lookahead += turn * Time.deltaTime * _TurnCam
        else:
            _lookahead *= 1 - (_Recenter * Time.deltaTime)

        if Abs(p) > _deadzone :
            _pitch += -p * Time.deltaTime * _PitchSpeed
        else:
            _pitch *= 1 - (_Recenter * Time.deltaTime)

        ref_right = _reference.right * (_yaw + _lookahead)



        ref_forward = (_reference.forward  + ref_right + Vector3 (0, _pitch, 0)).normalized

        forward = Vector3.Lerp(
             ref_forward.ScaleBy(_plane).normalized,
             ref_forward,
             _PreservePitch
             ).normalized

        right = Vector3.Lerp(
              _reference.right.ScaleBy(_plane).normalized,
              _reference.right,
              _PreserverRoll
              ).normalized

        up = Vector3.Cross(forward, right)

        _xform.rotation = Quaternion.LookRotation(forward, up)

        _hud = "ChaseCam: {0:F}, {1:F}" % (_yaw, _pitch)
