extends Node2D

#Gère le Spawning des unités  
#issus de la variable globable object_not_in_arena pour chaque marker3D

##Variable pointant vers l'élixir bar (pour gérer le systeme de soustraction d'élixir quand on pose une troupe
@onready var ElixirBar : ProgressBar = $"../../ProgressBar" 

##Valeur érant l'occupation de l'objet (si oui le marqueur fera spawn un objet,le non l'empechera)
var is_occupied : bool = false

##L'objet qui serra spawn
var picked_troop

##La carte de picked_troop (pour permettre la communication quand la carte serra posé sur l'arène)
var picked_card : Node

@export var Team : String
func _physics_process(delta):
	if is_occupied == false and GlobalVariables.object_not_in_arena:
		spawn_unit()
	if picked_troop not in GlobalVariables.object_in_hand: 
		is_occupied = false

	if Input.is_action_just_pressed("ui_accept"):
		debug()

func spawn_unit() -> void:
	picked_troop = load(GlobalVariables.object_not_in_arena[0]).instantiate()
	
	GlobalVariables.object_not_in_arena.remove_at(0)
	GlobalVariables.object_in_hand.append(picked_troop)
	
	#Gère les propriétés de la cartes
	picked_card = picked_troop.get_node("CanvasLayer/Button")
	picked_card.SpawnerMarker = self
	picked_card.global_position = global_position
	#Celle de la Troop
	picked_troop.InTroops = false
	picked_troop.TeamSide = Team
	#L'ajoute à la scène
	$"../..".add_child(picked_troop)
	
	is_occupied = true
	
func debug():
	ElixirBar.value = 100
