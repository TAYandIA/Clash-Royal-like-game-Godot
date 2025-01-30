@icon("res://Assets/IconForClasses/Icon Fleche.png")
class_name GiveOrRemoveCard
extends Node

# Le Programme récupère des variables avec les @export et les changes

##Présice si la valeur serra rajoutée ou supprimée
@export_enum("Give Card","Remove Card") var TypeDeChangement : String
##Précise la manière de supprimer
@export var SupprimerInHand : bool
@export var SupprimerNotInHand : bool
##Précise la valeur Card
@export var Card : PackedScene
@onready var CardPath = str(Card.get_path()) if Card != null else "res://Scènes/Troops/ElixirGolem.tscn"

##Variable du Calleur
var Calleur

func MakeSomething(ToBody = Calleur): ##ToBody (sois-même si aucune valeur) qui voit sa valeur changée
	
	match TypeDeChangement: 
		"Give Card": 
			GlobalVariables.object_not_in_arena.append(CardPath)
		"Remove Card": 
			RemoveCard()

func RemoveCard():
		if SupprimerInHand:
			var Spawners = get_tree().get_root().get_node("Node/CanvasLayer/UI Arena/Markers")
			for Spawner in Spawners.get_children():
				if Spawner.picked_troop !=  null and load(CardPath).instantiate().Description == Spawner.picked_troop.Description:
					Spawner.picked_card.remove_in_hand()
					return
		if SupprimerNotInHand and CardPath in GlobalVariables.object_not_in_arena: 
			GlobalVariables.object_not_in_arena.erase(CardPath)
