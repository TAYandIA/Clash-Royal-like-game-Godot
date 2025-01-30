@icon("res://Assets/IconForClasses/icon bullet.png")
class_name ShootOneBullet
extends Marker3D
##Scène créée en tant que projectile
@export var Bullet : PackedScene
##Instance servant de repère de position et de rotation pour permettre le spawning des projectiles
@export var MeshOfBody : MeshInstance3D
##Variable Calleur
var Calleur
func MakeSomething(body =null):
		rotation.y = MeshOfBody.rotation.y
		# Créer un projectile
		var projectile = Bullet.instantiate()
		# Créer ses propriétés
		projectile.Calleur = Calleur #NOTE : J'ai pas mis "owner" mais la variable Calleur (associé à self) directement pour permmetre de  créer des projectiles à partir de projectile
		projectile.global_transform = self.global_transform
		#L'ajoute à la scène
		get_tree().get_root().add_child(projectile)

