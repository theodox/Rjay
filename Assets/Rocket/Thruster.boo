import UnityEngine
import bootils

class Thruster(HasHud):

	public _Governor as Governor
	public Thrust = 100.0
	public _Response  = 1.0
	public _Axis = Vector3(0,0,-1)
	rigid as Rigidbody
	xform as Transform
	stick as single


	def Start():
		rigid = gameObject.GetComponent[of Rigidbody]()
		xform = gameObject.transform

	def FixedUpdate():
		# todo  - use an intersction test instead of height
		stick = Input.GetAxis("Throttle")
		_Governor.Update(stick * _Response, Time.deltaTime)
		rigid.AddRelativeForce(_Axis * (_Governor._Value * Thrust), ForceMode.Force)
		_hud = "Engine {0:f}  Stick {1:f}" % (_Governor._Value, stick )
