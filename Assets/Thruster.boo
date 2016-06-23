import UnityEngine
import Mathf

class Thruster(MonoBehaviour):

	public Thrust = 100.0
	public _Throttle as single = 0.0
	public _Response  = 1.0
	rigid as Rigidbody
	xform as Transform

	def Start():
		rigid = gameObject.GetComponent[of Rigidbody]()
		xform = gameObject.transform

	def Update():
		# todo  - use an intersction test instead of height
		v = Input.GetAxis("Vertical")
		_Throttle += (v * Time.deltaTime * _Response)
		_Throttle = Clamp(_Throttle, -1.0, 1.0)
		rigid.AddRelativeForce(xform.forward * (_Throttle * Thrust * -1), ForceMode.Force)

	def LateUpdate():
		_Throttle -= (Sign(_Throttle) *  Time.deltaTime)
		if Abs(_Throttle) < (Time.deltaTime / 2.0):
			_Throttle = 0.0

