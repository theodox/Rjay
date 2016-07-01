import UnityEngine
import bootils

class Thruster(HasHud):

	public _Governor as Governor
	public Thrust = 100.0
	public _Response  = 1.0
	rigid as Rigidbody
	xform as Transform
	stick as single


	def Start():
		rigid = gameObject.GetComponent[of Rigidbody]()
		xform = gameObject.transform

	def FixedUpdate():
		# todo  - use an intersction test instead of height
		stick = Input.GetAxis("Vertical")
		_Governor.Update(stick * _Response, Time.deltaTime)
		rigid.AddRelativeForce(xform.forward * (_Governor._Value * Thrust * -1), ForceMode.Force)
		_hud = "Engine {0:f}  Stick {1:f}" % (_Governor._Value, stick ) 
