import UnityEngine
import Mathf

class CameraFollower(MonoBehaviour):

	public _Target as Transform

	def Update():
		gameObject.transform.LookAt(_Target)
