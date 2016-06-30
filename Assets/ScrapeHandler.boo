import UnityEngine

public class ScrapeHandler(MonoBehaviour):
"""
Spawn an effect prefab at each contact point
"""
    public _Effect as GameObject
    public _Quota = 10
    public _Lifespan = 0.2f

    _instances = List[of GameObject]()
    _pointer = -1

    def Awake():
        for n in range(_Quota):
            g = GameObject.Instantiate(_Effect)
            g.SetActive(false)
            _instances.Add(g)

    public def OnScrape(col as Collision):
        for c in col.contacts:
            _pointer += 1
            _pointer = _pointer % _Quota
            item = _instances[_pointer]
            item.SetActive(true)
            item.transform.position = c.point
            item.transform.rotation = Quaternion.AngleAxis(0, c.normal)
            StartCoroutine(Disable(item))

    public def Disable(g as GameObject) as IEnumerator:
    """
    disable the game object after a delay
    """
        yield WaitForSeconds(_Lifespan)
        g.SetActive(false)
