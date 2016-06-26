import UnityEngine

public class Drogue(MonoBehaviour):

    public _Drag = 1f
    public _Distance = 3f
    public _Chute as GameObject
    public _Spawn = Vector3(0, -2, 1)

    _chute_instance as GameObject


    def Update():
        if _chute_instance:
            if not Input.GetAxis("Jump"):
                _chute_instance.SetActive(false)
                _chute_instance = null
            return
        else:
            if Input.GetAxis("Jump"):
                _chute_instance  = GameObject.Instantiate(_Chute)
                _chute_instance.transform.position = gameObject.transform.TransformPoint(_Spawn)
                joint = _chute_instance.GetComponent[of SpringJoint]()
                joint.connectedBody = gameObject.GetComponent[of Rigidbody]()
                _chute_instance.SetActive(true)
