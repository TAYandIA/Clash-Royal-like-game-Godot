extends Area3D
##Vitesse du projectile
@export var SpeedBullet : float
##Dégats du projectile
@export var Percing : bool
##La Façon dont sont sélectionnées les troops entrantes et sortantes par rapport à l'entité
@export_enum("That are in the same Side","That are not in the same Side") var WhenCollideWithEntitities : int
@export_category("One Bullet Events")
##Evènements associés au projectile qui seront exécuter sur l'enemi, quand il touche un entité
@export var EventToDoToTheEnemy : Array[Node] = []
##Evènements associés au projectile qui seront exécuter sur le calleur, quand il touche un entité
@export var EventToDoToTheCalleur : Array[Node] = []

##Entité ayant tiré le projectile
var Calleur
var EventWhenHit

func _physics_process(delta):
	#Gère la vélocité du projectile et la façon dont elle bouge (en ligne droite)
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * SpeedBullet * delta)

func _on_body_entered(body: Node3D) -> void:
	if process_mode == Node.PROCESS_MODE_DISABLED or body not in GlobalVariables.Troops or body == Calleur:
		return
	#Filtrage des troupes selon leur Teamside et celui de l'entité
	if (body.TeamSide != Calleur.TeamSide and WhenCollideWithEntitities == 0) or (body.TeamSide == Calleur.TeamSide and WhenCollideWithEntitities == 1):
		return
		
	#On appelle les différents évènements selon l'array dont lequel appartient le MakeSomething
	EventWhenHit = EventToDoToTheCalleur + EventToDoToTheEnemy ##Tous les events associés à ce node
	for i in EventWhenHit:
		if Calleur and i != null: i.Calleur = Calleur
		if i in EventToDoToTheCalleur : i.MakeSomething(Calleur)
		if i in EventToDoToTheEnemy : i.MakeSomething(body)
			
		#On détruit le projectile si persing est faux
	if Percing == false : 
		# Rend l'objet invisible et désactive son mode de traitement
		call_deferred("queue_free")
