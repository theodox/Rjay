namespace bootils
import UnityEngine
import Mathf
import System.Collections.Generic


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



public class HasHud(MonoBehaviour):

	static _rects = Dictionary[of int, Rect]()
	static _width = 200
	static _height = 20
	static _left = 20


	_hud as string

	public static def Register(g as Component):
		count = 1 +  _rects.Count
		_rects[g.GetInstanceID()] =  Rect(_left,  _height * count,  _width,  _height)
		Debug.Log("Register {0}  @ {1}" % (g, count))

	public static def Hud (g as Component, str as string):
		r = _rects[g.GetInstanceID()]
		GUI.Label(r, str)

	def Awake():
		Register(self)

	def OnGUI():
		if _hud:
			Hud(self, _hud)
