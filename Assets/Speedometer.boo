import UnityEngine

public class Speedometer(MonoBehaviour):

    public _Speed as single

    _slices as (single)
    _last_position as Vector3
    _xform as Transform

    def Start():
        _slices = (0f, 0f, 0f, 0f, 0f)
        _xform = gameObject.transform
        _last_position = _xform.position

    def FixedUpdate():
        current_pos = Vector3.ProjectOnPlane(_xform.position, Vector3.up)
        delta = (current_pos - _last_position).magnitude / Time.deltaTime
        avg = 0.0
        for n in range(1, 4):
            avg += _slices[n]
            _slices[n-1] = _slices[n]
        _slices[4] = delta
        avg += delta

        _Speed = avg / 5.0
        _last_position = current_pos
