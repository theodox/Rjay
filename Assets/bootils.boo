namespace bootils
import UnityEngine



public static def SendSystemMessage(message as string, arg as object, options as SendMessageOptions ):
	manager = GameObject.FindWithTag("GameManager")
	if not manager:
		raise "Manager object not found"
		
	manager.BroadcastMessage(message, arg, options)
	
public static def SendSystemMessage(message as string, arg):
	SendSystemMessage(message, arg, SendMessageOptions.DontRequireReceiver)
	
public static def SendSystemMessage(message as string):
	SendSystemMessage(message,  SendMessageOptions.DontRequireReceiver)