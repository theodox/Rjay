import UnityEngine

class Steering(MonoBehaviour):

	public _Rudder as single = 0.0
	public _Response = 1.0
	public _Torque = 1.0
	public _Yaw = 0.5

	xform as Transform
	rigid as Rigidbody

	def Start():
		xform = gameObject.transform
		rigid = gameObject.GetComponent[of Rigidbody]()

	def Update():
		h = Input.GetAxis("Horizontal")
		_Rudder += h * Time.deltaTime * _Response
		_Rudder = Clamp(_Rudder, -1.0, 1.0)
		rigid.AddRelativeTorque(Vector3.forward * _Torque * _Rudder * -1);
		rigid.AddRelativeTorque(Vector3.up * _Yaw * _Rudder * -1);


	def LateUpdate():
		_Rudder -= (Sign(_Rudder) *  Time.deltaTime)
		if Abs(_Rudder) < (Time.deltaTime * .5):
			_Rudder = 0.0
