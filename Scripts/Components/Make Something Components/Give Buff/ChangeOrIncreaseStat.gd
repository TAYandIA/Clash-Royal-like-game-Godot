@icon("res://Assets/IconForClasses/Icon Fleche.png")
class_name ChangeOrIncreaseStats
extends Node

# Le Programme récupère des variables avec les @export et les changes

##Présice si la valeur stat serra additionée avecValue ou serra changée enValue
@export_enum("Changer la stat","Additioner la stat") var TypeDeChangement : String
##Précise la stat à changer
@export_enum("Speed","Health","FireRate","Capacity") var StatToChange : String
##La valeur qui serra additionée avec la valeur de la stat ou la valeur qui remplacera la valeur stat
@export var Value : float 
##Le component adécquoit qui verra sa value changée
var ComponentToChange
##Variable du Calleur
var Calleur
func _ready() -> void:
	match StatToChange: 
		# Définit ComponentToChange à un component et à sa valeur, qui sont associés avec la variable StatToChange
		"Speed": ComponentToChange = ["Components/MoveComponent","Speed"]
		"Health":  ComponentToChange = ["UI (subview)/HealthComponent","Health"]
		"Capacity":  ComponentToChange = ["UI (subview)/Capacité","Capacity"]
		"FireRate": ComponentToChange = ["Components/Shoot","Fire_Rate"]
		
func MakeSomething(ToBody = Calleur): ##ToBody (sois-même si aucune valeur) qui voit sa valeur changée
# Il vérifie si le Body dont lequel on veux changer sa valeur possède le component adécquoit
	if ToBody.has_node(ComponentToChange[0]): 
		if TypeDeChangement == "Changer la stat":
# Si oui, Il change la valeur que l'on veut changer pour qu'elle devienneValue...	
			ToBody.get_node(ComponentToChange[0]).call("Change_"+ComponentToChange[1],Value)
# Ou Il change la valeur pour qu'elle sois additionée avecValue
		elif TypeDeChangement == "Additioner la stat":
			ToBody.get_node(ComponentToChange[0]).call("Gain_"+ComponentToChange[1],Value)
