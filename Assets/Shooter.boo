import UnityEngine

public class Shooter(EffectPool):

    public _Speed = 100f
    public _Aim as Vector3
    public _Offset = 1
    public _Pause = 1f

    _ready = true
    _rb as Rigidbody

    override def Start():
        super()
        _rb = gameObject.GetComponent[of Rigidbody]()


    def Update():
        if _ready and Input.GetAxis("Fire1") > 0.5f:
            Fire()
            _ready = false
            StartCoroutine(Reset())

    def Reset() as IEnumerator:
        yield WaitForSeconds(_Pause)
        _ready = true


    def Fire():
        t = gameObject.transform
        Spawn(t.TransformPoint(_Aim * _Offset), t.rotation)
        bullet = _pool[_pointer]
        rb = bullet.GetComponent[of Rigidbody]()
        rb.velocity = _rb.velocity
        rb.AddForce(t.TransformVector(_Aim   * _Speed))
        anchor = bullet.GetComponent[of GrappleAnchor]()
        anchor._Owner = gameObject
