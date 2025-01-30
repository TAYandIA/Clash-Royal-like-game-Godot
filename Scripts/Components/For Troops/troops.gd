extends Node3D
##La Team associée avec l'entité se battant se battant contre les entités ayant une variable Team différente
@export var TeamSide: String
##Variable donnant l'autorisation aux autres nodes de bouger cette entité
@onready var CanMove = true
##Variable donnant l'autorisation aux autres nodes de permettre l'attaque de cette entité
@onready var CanShoot = false
##Variable Pointant que CETTE entité (pour permettre la suscession de pattern de projectiles dits MakeSomething
@onready var Calleur = self
##Pour l'ajouter dans la variable Troops sans passer par d'autre moyen : utilise pour les entités non joueurs, qui ne peuvent pas être des cartes
@export var InTroops: bool
##Info à propos de la carte
@export_multiline var Description : String
func _ready():
	if InTroops == true:
		GlobalVariables.Troops.append(Calleur)
		remove_child($CanvasLayer)
		
	if Calleur.InTroops == false : Calleur.kill(false)
	
	for i in get_all(self):
		if "Calleur" in i: 
			i.Calleur = Calleur
			
func get_all(node:Node):
	var all_children := []
	for child in node.get_children():
		all_children.append(child)
		for grand_child in get_all(child):
			all_children.append(grand_child)
	return all_children
	
func revive():
	# Réactive le mode de traitement de l'objet
	process_mode = Node.PROCESS_MODE_INHERIT
	# Rend l'objet visible
	visible = true
	if has_node("CollisionShape3D"):$CollisionShape3D.disabled = false

func kill(definitif : bool):
	# Vérifie si l'opération de suppression est définitive et si l'objet existe dans la liste des troupes avant de l'effacer
	if definitif:
		if self in GlobalVariables.Troops :GlobalVariables.Troops.erase(self)
		Calleur = null
		
	# Rend l'objet invisible et désactive son mode de traitement
	visible = false
	if has_node("CollisionShape3D"): $CollisionShape3D.disabled = true
	process_mode = Node.PROCESS_MODE_DISABLED
	if has_node("CanvasLayer/Button") : $CanvasLayer/Button.process_mode = Node.PROCESS_MODE_ALWAYS
	# Empêche l'objet de tirer
	CanShoot = false

#Do You Want To Play With Me.
#The Fires Sing My Symphony
#The Three Of You,POWERS SO DIVINE
#In The End,IT'LL ALL BE MINE
