@icon("res://Assets/IconForClasses/IconSpawn.png")
class_name SpawnNode
extends Marker3D

#NOTE IL FAUT QUE LE NODE QUI EST CRéER N'A PAS DE PARENT AUTRE QUE LE PARENT PRINCIPAL
#POUR QUE LES EVENT DU NODE CREER NE S'INTEROMPE PAS QUAND LE NODE PARENT PRINCIPAL MEURT
## L'entité qui sera spawn par ce MakeSomething component. NOTE : IL FAUT QUE LE NODE QUI EST CRéER N'A PAS DE PARENT AUTRE QUE LE PARENT PRINCIPAL
@export var ArrayOfSomethingToSpawn : Array[Node]
##Variable du Calleur
var Calleur

func MakeSomething(body = owner):
	for Something in ArrayOfSomethingToSpawn: #Pour chaque entité de l'array ArrayOfSomethingToSpawn
		# Créer Une Entité
		var TheThing = Something.duplicate()
		if "Calleur" in TheThing : TheThing.Calleur = Calleur
		
		# Ajoute TheThing à la scène
		if TheThing.get_parent():
			TheThing.get_parent().remove_child(TheThing)
		get_tree().get_root().add_child(TheThing)
		
		# Créer ses propriétés
		if TheThing is Node3D:
			TheThing.visible = true
			TheThing.global_position = body.global_position
			
		# Appelle MakeSomething()
		if TheThing.has_method("MakeSomething"): 
			TheThing.MakeSomething(body)
		
