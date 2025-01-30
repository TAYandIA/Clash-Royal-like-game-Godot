@icon("res://Assets/IconForClasses/Carteicon.png")
class_name CardAndDragComponent
extends Button

# Déclaration des variables
var is_dragged : bool = false  ## Indique si l'objet est en train d'être déplacé
var offset : Vector2  ## Offset de la position de la souris par rapport à l'objet
var SpawnerMarker : Node2D  ## Marqueur de position d'origine de la carte
var Calleur : Node ##Variable du Calleur
##Les Events possédant la fonction : MakeSomething() ,qui vont être générés par ce component lorque la carte serra posé dans l'arène
@export var MakeSomethingEvent : Array[Node]
##Pour ajouter ,si oui ou non, cette entité dans la variable global Troop, lorsqu'elle est posé dans l'arène
@export var AjouterDansTroops: bool
##Elixir connsomées lors de l'entrée de cette troupes dans l'arène
@export var Elixir : float

# Initialisation
func _ready() -> void:
	set_physics_process(is_dragged)  # Active le processus physique si l'objet est en train d'être déplacé

# Mise à jour à chaque frame
func _physics_process(delta: float) -> void:
	if is_dragged:  # Si l'objet est en train d'être déplacé
		update_position()  # Met à jour la position de l'objet

# Met à jour la position de l'objet en fonction de la position de la souris
func update_position() -> void:
	global_position = get_global_mouse_position() - offset

# Vérifie si une troupe est associée à la carte et la déplace si c'est le cas
func check_and_drag_troop() -> void:
	if GlobalVariables.mouse_position_3D: #Si la mouse_position_3D existe (voir script camera.gd qui gère ça)
		#On va à cette position
		Calleur.position = Vector3(GlobalVariables.mouse_position_3D.x,owner.position.y,GlobalVariables.mouse_position_3D.z) 

# Déclenché lorsque le bouton est pressé
func _on_button_down() -> void:
	start_dragging()  # Commence à déplacer l'objet

# Commence à déplacer l'objet
func start_dragging() -> void:
	is_dragged = true  # Indique que l'objet est en train d'être déplacé
	offset = get_global_mouse_position() - global_position  # Calcule l'offset
	GlobalVariables.dragged_object = self  # Enregistre l'objet en cours de déplacement
	set_physics_process(is_dragged)  # Active le processus physique

# Déclenché lorsque le bouton est relâché
func _on_button_up() -> void:
	is_dragged = false  # Indique que l'objet n'est plus en train d'être déplacé
	if GlobalVariables.mouse_position_3D_COLLIDER and SpawnerMarker.ElixirBar.value - Elixir >= 0:  # Si la souris est sur un collider 3D et la progress bar de Spawner Bar peut permettre la soustraction de sa valeur
		add_troop_to_arena()  # Ajoute la troupe à la scène
		check_and_drag_troop()  # Vérifie et déplace la troupe
		disable_card()  # Désactive la carte
		call_functionalities() #Appelle les MakeSomethings components et enlève de l'élixir à la barre
	else:
		move_to_spawner_marker()  # Retourne l'objet à sa position d'origine
	set_physics_process(is_dragged)  # Désactive le processus physique

# Ajoute la troupe à la scène
func add_troop_to_arena() -> void:
	if not Calleur in GlobalVariables.object_in_arena: GlobalVariables.object_in_arena.append(Calleur)  # Ajoute la troupe à la liste des objets dans l'arène
	if not Calleur in GlobalVariables.Troops and AjouterDansTroops == true : GlobalVariables.Troops.append(Calleur)  # Ajoute la troupe à la liste des troupes
	if Calleur in GlobalVariables.object_in_hand : GlobalVariables.object_in_hand.erase(Calleur)
	Calleur.revive()
	

# Appelle différente fonctionnalité lorsque la carte est posée
func call_functionalities():
	# Enlève de l'élixir à la progress bar issus de la scene de Spawner Marker
	SpawnerMarker.ElixirBar.value -= Elixir
	# Permet de Call des events quand la carte est posé dans l'arène
	for event in MakeSomethingEvent:
		event.Calleur = Calleur
		event.MakeSomething()

# Désactive la carte
func disable_card() -> void:
	disabled = true  # Désactive le bouton de la carte
	#size = Vector2(50,50)
	#global_position = get_global_mouse_position() - size/2
	visible = false  # Supprime la texture de la carte
	
# Retourne l'objet à sa position d'origine
func move_to_spawner_marker() -> void:
	var tween = get_tree().create_tween()  # Crée une animation
	tween.tween_property(self,"global_position",SpawnerMarker.global_position,0.2).set_ease(Tween.EASE_OUT)  # Anime la position de l'objet vers la position d'origine

func remove_in_hand():
	SpawnerMarker.picked_troop.queue_free()
	GlobalVariables.object_in_hand.erase(Calleur)
