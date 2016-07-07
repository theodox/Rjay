import UnityEngine
import bootils

class Steering(HasHud):

	public _Governor as Governor
	public _PitchGovernor as Governor
	public _Roll = 1.0f
	public _Yaw = 0.5f
	public _Pitch = 0.5f
	xform as Transform
	rigid as Rigidbody

	def Start():
		xform = gameObject.transform
		rigid = gameObject.GetComponent[of Rigidbody]()

	def FixedUpdate():
		h = Input.GetAxis("Horizontal")
		v = Input.GetAxis("Vertical")
		_Governor.Update(h, Time.deltaTime)
		_PitchGovernor.Update(v, Time.deltaTime)
		_Rudder = _Governor._Value
		_Aileron = _PitchGovernor._Value
		rigid.AddRelativeTorque(Vector3.forward * _Yaw * _Rudder * -1);
		rigid.AddRelativeTorque(Vector3.up * _Roll * _Rudder * -1);
		rigid.AddRelativeTorque(Vector3.right  * _Aileron * _Pitch * -1)

		_hud = "Rudder {0:f} Aileron {1:f}" % (_Rudder,_Aileron)
