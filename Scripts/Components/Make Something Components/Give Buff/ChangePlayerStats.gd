@icon("res://Assets/IconForClasses/Icon Fleche.png")
class_name ChangeOrIncreaseStatOfPlayer
extends Node

# Le Programme récupère des variables avec les @export et les changes

##Présice si la valeur stat serra additionée avecValue ou serra changée enValue
@export_enum("Changer la stat","Additioner la stat") var TypeDeChangement : String
##Précise la stat à changer
@export_enum("Elixir") var StatToChange : String
##La valeur qui serra additionée avec la valeur de la stat ou la valeur qui remplacera la valeur stat
@export var Value : float 

##Variable du Calleur
var Calleur

func MakeSomething(ToBody = Calleur): ##ToBody (sois-même si aucune valeur) qui voit sa valeur changée
	match StatToChange: 
		"Elixir": ModifierVariable()
					
func ModifierVariable():
	if TypeDeChangement == "Changer la stat":
		%Button.SpawnerMarker.ElixirBar.value = Value
		print("iiid")
	elif TypeDeChangement == "Additioner la stat":
		%Button.SpawnerMarker.ElixirBar.value += Value

