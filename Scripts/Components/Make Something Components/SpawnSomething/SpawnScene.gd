class_name SpawnScene
extends Marker3D

##L'entité qui sera spawn par ce MakeSomething component
@export var Something : PackedScene
@export var test : Node
func MakeSomething(body = owner):
		# Créer Une Entité
		var TheThing = Something.instantiate()
		# Créer ses propriétés
		TheThing.global_transform = body.global_transform
		for property in TheThing.get_property_list():
			TheThing[property.name] = test[property.name]
		#L'ajoute à la scène
		get_tree().get_root().add_child(TheThing)
