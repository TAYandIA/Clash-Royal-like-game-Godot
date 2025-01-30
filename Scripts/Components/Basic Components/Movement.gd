@icon("res://Assets/IconForClasses/Icon Move.png")
class_name MoveComponent
extends NavigationAgent3D

##Le Timer qui gère le temps entre les différents analyses de chemin
@export var TimerNav : Timer
##La Valeur Vitesse du mouvement
@export var Speed : float = 0.0
##Pour Permètre la rotation de l'entité lors du mouvement
@export var BodyMesh : MeshInstance3D
##La Façon dont sont sélectionnées les troops entrantes et sortantes par rapport à l'entité
@export_enum("That are in the same Side","That are not in the same Side") var CountEntitiesThat : int
var distance = []
var TroopsInDistance = []
var Troops = GlobalVariables.Troops

func _ready():
	check_Speed()
	#Connecte TimerNav
	TimerNav.timeout.connect(_on_timer_nav_timeout) 

func check_Speed():
	if Speed == 0: 
		print("Pas de vitesse pour " + str(self))

func _physics_process(delta):
	await get_tree().process_frame
	await _on_timer_nav_timeout()
	
	if is_movable_and_in_troops():
		move_body_to_target()
		orient_body_to_target()	
	
func is_movable_and_in_troops():
	#Check si l'entité est une troupe,si elle est autorisé à bouger et si elle possède une cible
	return owner in Troops and owner.CanMove and distance

func move_body_to_target():
	#Gèere le mouvement vers une cible donnée
	var location = (get_next_path_position() - owner.global_position).normalized()
	owner.velocity = location * Speed * get_physics_process_delta_time()
	owner.move_and_slide()
	#set_velocity(location * Speed) si on veut faire de l'avoidance
#
#func _on_velocity_computed(safe_velocity):
	#if is_movable_and_in_troops():
		#owner.velocity = safe_velocity
		#owner.move_and_slide()

func orient_body_to_target():
	#Gère la rotation de l'entité
	BodyMesh.look_at(target_position)
	BodyMesh.rotate_y(deg_to_rad(180))

func _on_timer_nav_timeout():
	#Si TimerNav est écoulé
	calculate_distance_to_troops() #On Calcule la position des différentes cibles
	
func calculate_distance_to_troops():
	distance = [] #Reset Distance
	
# On parcourt toutes les troupes de chaque joueur selon leur TeamSide et la variable countentities
	match CountEntitiesThat:
		# Si la troupe et l'entité owner ne sont pas dans la même team, on l'ajoute à TroopsInDistance
		1: TroopsInDistance = GlobalVariables.Troops.filter(func(idk): return owner.TeamSide != idk.TeamSide and idk != owner) 
		# Si la troupe et l'entité owner sont dans la même team, on l'ajoute à TroopsInDistance
		0: TroopsInDistance = GlobalVariables.Troops.filter(func(idk): return owner.TeamSide == idk.TeamSide and idk != owner) 

# Pour chaque troupe dans TroopsInDistance, on ajoute un tableau à la liste distance qui contient la distance au carré entre la position de l'entité owner et la position de la troupe, ainsi que la position de la troupe
	for troop in TroopsInDistance:
		distance.append([owner.global_position.distance_squared_to(troop.global_position), troop.global_position])

# On trouve la troupe qui possède la distance la plus faible avec l'entité et on enregistre sa position
	if distance:
		target_position = distance.min()[1]

func Gain_Speed(SpeedValue):
	Speed += SpeedValue
func Change_Speed(SpeedValue):
	Speed = SpeedValue
