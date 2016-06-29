import UnityEngine
import Mathf

class PlayerCam(MonoBehaviour):


    public _Recenter = 0.1f
    public _YawSpeed = 10f
    public _PitchSpeed = 50f
    public _TurnCam = 0.1f

    _lookahead = 0f
    _yaw = 0f
    _pitch = 0f
    _xform as Transform
    y = 0f
    p = 0f
    _debug_rect = Rect(10,70, 240, 20)

    def Start():
        _xform = gameObject.transform


    def Update():
        y = Input.GetAxis("CameraYaw")
        p = Input.GetAxis("CameraPitch")


        if Abs(y) > .01 :
            _yaw += y * Time.deltaTime * _YawSpeed
        else:
            _yaw *= 1 - (_Recenter * Time.deltaTime)

        turn = Input.GetAxis("Horizontal")
        if Abs(turn) > .01:
            _lookahead += turn * Time.deltaTime
        else:
            _lookahead *= 1 - (_Recenter * Time.deltaTime)

        _lookahead = Clamp(_lookahead, -1 , 1)
        look_yaw =  (_lookahead + Pow(_lookahead, 3)/2f) * _TurnCam

        if Abs(p) > .01 :
            _pitch += -p * Time.deltaTime * _PitchSpeed
        else:
            _pitch *= 1 - (_Recenter * Time.deltaTime)

        _xform.localEulerAngles = Vector3(_pitch, _yaw + look_yaw, 0)

    def OnGUI():
        GUI.Label(_debug_rect, "  y {0:f} p {1:f}" % (y, p) )
