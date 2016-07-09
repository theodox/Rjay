import UnityEngine


class Resetter(MonoBehaviour):

    public _ResetHeight = 2f


    def Update():
        if Input.GetAxis("Cancel"):

            rb = gameObject.GetComponent[of Rigidbody]()
            rb.isKinematic = true
            p = gameObject.transform.position
            gameObject.transform.position = Vector3(p.x, _ResetHeight, p.z)
            gameObject.transform.rotation = Quaternion.identity
            rb.isKinematic = false
