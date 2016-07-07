import UnityEngine
import Mathf

class PlayerCam(MonoBehaviour):

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

    _plane = Vector3(1,0,1)

    y = 0f
    p = 0f
    _debug_rect = Rect(10,70, 240, 20)

    def Start():
        _xform = gameObject.transform
        _reference = _Reference.transform

    def Update():



        y = Input.GetAxis("CameraYaw")
        p = Input.GetAxis("CameraPitch")
        turn = Input.GetAxis("Horizontal")

        if Abs(y) > .01 :
            _yaw += y * Time.deltaTime * _YawSpeed
        else:
            _yaw *= 1 - (_Recenter * Time.deltaTime)


        if Abs(turn) > .01:
            _lookahead += turn * Time.deltaTime * _TurnCam
        else:
            _lookahead *= 1 - (_Recenter * Time.deltaTime)


        ref_right = _reference.right * (_yaw + _lookahead)

        if Abs(p) > .01 :
            _pitch += -p * Time.deltaTime * _PitchSpeed
        else:
            _pitch *= 1 - (_Recenter * Time.deltaTime)


        ref_forward = (_reference.up  + ref_right + Vector3 (0, _pitch, 0)).normalized

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

        q = Quaternion.identity
        q.SetLookRotation(forward, up)
        _xform.rotation = q
