class_name DétectionComponent
extends Area3D
@onready var Troops = GlobalVariables.Troops
##Instance rotatif (pour que les autres nodes utilisant la rotation du parent fonctionne correctement
@export var BodyMesh: MeshInstance3D
##La Façon dont sont sélectionnées les troops entrantes et sortantes par rapport à l'entité
@export_enum("That are in the same Side","That are not in the same Side") var CountEntitiesThat : int
var troops_in_area = []
##Variable du Calleur
var Calleur

func _ready() -> void:
	#Connection des signaux De l'Area3D
	body_entered.connect(When_Body_Entered)
	body_exited.connect(When_Body_Exited)
	
func _physics_process(delta):
	if troops_in_area:  #Si la Variable troops_in_area possède une valeur
		owner.CanMove = false #On refuse l'autorisation aux autres nodes de bouger
		owner.CanShoot = true #On donne l'autorisation aux autres nodes de shoot
		
		#Gère la rotation (pour que les autres nodes utilisant la rotation du parent fonctionne correctement)
		BodyMesh.look_at($"../MoveComponent".target_position) #si onveut que la troooop de lock pas sur une cible mais change de cible dès qu'elle trouve une nouvelle plus proche
		BodyMesh.rotate_y(deg_to_rad(180))
	else:
		owner.CanMove = true
		owner.CanShoot = false

#Ajoute body dans la variable troops_in_area si on rentre dans l'area et on la supprime si inverse
func When_Body_Entered(body):
	#Filtrage des troupes selon leur Teamside et celui de l'entité
	if body in Troops and body != Calleur:
		if (body.TeamSide == Calleur.TeamSide and CountEntitiesThat == 0) or (body.TeamSide != Calleur.TeamSide and CountEntitiesThat == 1): 
			troops_in_area.append(body)
			
func When_Body_Exited(body):
	#Si un body sort de l'area
	if body in troops_in_area : troops_in_area.erase(body) #on le supprime de troops_in_area

