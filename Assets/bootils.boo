namespace bootils
import UnityEngine
import Mathf



public static def SendSystemMessage(message as string, arg as object, options as SendMessageOptions ):
	manager = GameObject.FindWithTag("GameManager")
	if not manager:
		raise "Manager object not found"

	manager.BroadcastMessage(message, arg, options)

public static def SendSystemMessage(message as string, arg):
	SendSystemMessage(message, arg, SendMessageOptions.DontRequireReceiver)

public static def SendSystemMessage(message as string):
	SendSystemMessage(message,  SendMessageOptions.DontRequireReceiver)



public class Governor():
"""
Input historesis
"""
	public _Decay = .1f
	public _Range as Vector2
	public _Friction = .05f

	_inertia = 0f
	_lastvalues = (0f, 0f, 0f)
	public _value  = 0f
	_derivative = 0f

	public _Value as single:
		get:
			return _value

	public _Derivative as single:
		get:
			return _derivative

	public  def Update(force as single, interval as single):
		_inertia -= _Decay * interval * Mathf.Sign(_value)
		_inertia *= 1 - _Friction
		_inertia += force * interval
		_value += _inertia
		if (_value <= _Range.x):
			_value = _Range.x
			_inertia = Clamp(_inertia, 0, 1)
		elif (_value >= _Range.y):
			_value = _Range.y
			_inertia = Clamp(_inertia, -1, 0)

		_lastvalues[0] = _lastvalues[1]
		_lastvalues[1] = _lastvalues[2]
		_lastvalues[2] = _value
		_derivative = _lastvalues[0] + _lastvalues[1] / _lastvalues[1] + _lastvalues[2]
