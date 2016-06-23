import UnityEngine
import Mathf

class rocket_hover (MonoBehaviour):

	public HoverDistance = 1.0
	public HoverForce = 100
	public Position = Vector3(0,0,0)

	rigid as Rigidbody
	xform as Transform
	thruster as Vector3
	previous_y as single

	def Start():
		rigid = gameObject.GetComponent[of Rigidbody]()
		xform = gameObject.transform
		previous_y = xform.position.y

	def Update():
		
		thruster = xform.TransformPoint(Position.x, Position.y, Position.z)
		
		# vary thrush by delta H
		dy = Clamp((previous_y - thruster.y)  / Time.smoothDeltaTime, -2, 2)
		exp = dy + 1
		h = Clamp(xform.position.y, 0.0, HoverDistance) / HoverDistance
		
		power = Mathf.Pow(1-h, 3)
		_output_power = power * exp

		angle = xform.up *  (HoverForce * _output_power)
		rigid.AddForceAtPosition(angle, thruster, ForceMode.Force)


	def LateUpdate():
		previous_y =  xform.TransformPoint(Position.x, Position.y, Position.z).y