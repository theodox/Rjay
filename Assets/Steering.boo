import UnityEngine
import bootils

class Steering(HasHud):

	public _Governor as Governor
	public _Rudder as single = 0.0
	public _Torque = 1.0
	public _Yaw = 0.5

	xform as Transform
	rigid as Rigidbody

	_debug_rect = Rect(10,10, 100, 20)

	def Start():
		xform = gameObject.transform
		rigid = gameObject.GetComponent[of Rigidbody]()

	def FixedUpdate():
		h = Input.GetAxis("Horizontal")
		_Governor.Update(h, Time.deltaTime)
		_Rudder = _Governor._Value
		rigid.AddRelativeTorque(Vector3.forward * _Torque * _Rudder * -1);
		rigid.AddRelativeTorque(Vector3.up * _Yaw * _Rudder * -1);

		_hud = "Rudder {0:f}" % (_Rudder,)
