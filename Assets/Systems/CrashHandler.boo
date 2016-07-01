import UnityEngine
import System.Collections
import Mathf

class CrashHandler(MonoBehaviour):

    public _CrashForce = 2000

    _rigidbody as Rigidbody

    def Start():
        _rigidbody = gameObject.GetComponent[of Rigidbody]()

    def OnCollisionEnter(collision as Collision):
        impact = collision.impulse.magnitude / Time.deltaTime
        if impact > _CrashForce:
            bootils.SendSystemMessage("OnCrash", collision)
        else:
            bootils.SendSystemMessage("OnScrape", collision)

    private def Crash() as IEnumerator:
        yield  WaitForSeconds(.2)
