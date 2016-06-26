import UnityEngine
import bootils

class Steering(MonoBehaviour):

	public _Governor as Governor
	public _Rudder as single = 0.0
	public _Torque = 1.0
	public _Yaw = 0.5

	xform as Transform
	rigid as Rigidbody

	def Start():
		xform = gameObject.transform
		rigid = gameObject.GetComponent[of Rigidbody]()

	def FixedUpdate():
		h = Input.GetAxis("Horizontal")
		_Governor.Update(h, Time.deltaTime)
		_Rudder = _Governor._Value
		rigid.AddRelativeTorque(Vector3.forward * _Torque * _Rudder * -1);
		rigid.AddRelativeTorque(Vector3.up * _Yaw * _Rudder * -1);


	def LateUpdate():
		_Rudder -= (Sign(_Rudder) *  Time.deltaTime)
		if Abs(_Rudder) < (Time.deltaTime * .5):
			_Rudder = 0.0
