import UnityEngine


class Resetter(MonoBehaviour):


    def Update():
        if Input.GetAxis("Cancel"):

            rb = gameObject.GetComponent[of Rigidbody]()
            rb.isKinematic = true

            gameObject.transform.position = gameObject.transform.position + Vector3( 0, 1, 0 )

            gameObject.transform.rotation = Quaternion.EulerAngles(90,0,0)

            rb.isKinematic = false
