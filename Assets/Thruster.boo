import UnityEngine
import bootils

class Thruster(MonoBehaviour):

	public _Governor as Governor
	public Thrust = 100.0
	public _Response  = 1.0
	rigid as Rigidbody
	xform as Transform

	_debug_rect = Rect(10,30, 100, 20)

	def Start():
		rigid = gameObject.GetComponent[of Rigidbody]()
		xform = gameObject.transform

	def FixedUpdate():
		# todo  - use an intersction test instead of height
		v = Input.GetAxis("Vertical")
		_Governor.Update(v * _Response, Time.deltaTime)
		rigid.AddRelativeForce(xform.forward * (_Governor._Value * Thrust * -1), ForceMode.Force)

	def OnGUI():
		GUI.Label(_debug_rect, "Engine {0:f}" % (_Governor._Value,) )
