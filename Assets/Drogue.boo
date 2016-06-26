import UnityEngine

public class Drogue(MonoBehaviour):

    public _Drag = 1f
    public _Distance = 3f
    _chute as GameObject

    def Start():
        r = gameObject.GetComponentsInChildren[of Rigidbody](true)[-1]
        Debug.Log(r)
        _chute = r.gameObject

    def Update():
        if Input.GetAxis("Jump"):
            _chute.SetActive(true)
        else:
            _chute.SetActive(false)
