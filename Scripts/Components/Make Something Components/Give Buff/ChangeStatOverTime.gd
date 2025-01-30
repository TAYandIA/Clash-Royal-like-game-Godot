class_name MakeSomethingMultipleTime
extends Timer

##Node ChangeOrIncreaseStat gérant le changement de stat
@export var Events: Array[Node]
##Nombre de fois oû le makesomething est appelé
@export var NumberOfTime : int
##Variable du Calleur
var Calleur : Node
##Variable de la victime
var Victime

func _ready() -> void:
	#Connection Signal
	timeout.connect(when_timeout)
	
func MakeSomething(ToBody = Calleur):
	start() #Lance le chrono
	Victime = ToBody #Définit Victime à ToBody pour permettre aux autres fonctions d'utiliser cette variable
	CallEvents()
	
func when_timeout():
	if NumberOfTime > 0: #Si NumberOfTime est au dessus de 0
		CallEvents() #On appelle les évènements
		NumberOfTime -= 1 #On soustrait NumberOfTime par 1
	else: queue_free() #Si NumberOfTime atteint 0, On supprime ce node
	
func CallEvents():
	#Victime.get_node("MeshInstance3D").mesh.material.albedo_color = Color.CHARTREUSE
	#Appelle les évènements
	for i in Events:
		if i != null:
			i.Calleur = Calleur
			i.MakeSomething(Victime)
	

