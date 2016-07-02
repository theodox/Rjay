import UnityEngine


class Resetter(MonoBehaviour):

    public _ResetHeight = 2f
    public _ResetAngle = Quaternion.AngleAxis(90, Vector3.right)

    def Update():
        if Input.GetAxis("Cancel"):

            rb = gameObject.GetComponent[of Rigidbody]()
            rb.isKinematic = true
            p = gameObject.transform.position
            gameObject.transform.position = Vector3(p.x, _ResetHeight, p.z)
            gameObject.transform.rotation = _ResetAngle
            rb.isKinematic = false
