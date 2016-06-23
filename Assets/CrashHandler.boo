import UnityEngine
import System.Collections

class CrashHandler(MonoBehaviour):



  def OnCollisionEnter(collision as Collision):

    StartCoroutine(self.Crash())

  private def Crash() as IEnumerator:
    yield  WaitForSeconds(2.0)
    
   	bootils.SendSystemMessage("OnCrash")