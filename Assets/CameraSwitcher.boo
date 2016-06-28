import UnityEngine


class CameraSwitcher(MonoBehaviour):

    public _Cameras as (GameObject)
    _index = 0
    _ready = true

    def Start():
        Activate(0)

    def Update():
        if _ready:
            if Input.GetAxis("NextCamera"):
                _index += 1
                _index = _index % len(self._Cameras)
                Activate(_index)
                _ready = false
                StartCoroutine(self.Reset())
            elif Input.GetAxis("PrevCamera"):
                _index -= 1
                if _index < 1:
                    _index += len(_Cameras)
                _index = _index % len(_Cameras)
                Activate(_index)
                _ready = false
                StartCoroutine(self.Reset())


    def Activate(idx as int):
        for idx as int, item as GameObject in enumerate(_Cameras):
            item.SetActive(idx == _index)

    def Reset() as IEnumerator:
        yield WaitForSeconds(.25)
        _ready = true
