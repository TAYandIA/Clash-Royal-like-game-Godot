@icon("res://Assets/IconForClasses/icon bullet.png")
class_name ShootSplashBullet
extends Node3D

##Instance servant de repère de position et de rotation pour permettre le spawning des projectiles
@export var MeshOfBody : MeshInstance3D

##Scène créée en tant que projectile
@export var Bullet : PackedScene

##L'angle oû apparaisent les projectiles
@export_range(0,360) var ArcOfSplash

##Le Nombre de Projectiles, soustraît par 1 ,qui apparaissent dans l'angle
@export var NumberOfBullet : int

##Variable du Calleur
var Calleur

func MakeSomething(body = null):
	# Calculez l'angle d'incrément pour chaque projectile.
	var increment = deg_to_rad(ArcOfSplash) / max(NumberOfBullet - 1, 1)
	for i in range(NumberOfBullet):
		# Créez un projectile.
		var projectile = Bullet.instantiate()
		
		# Configurez les propriétés du projectile.
		projectile.Calleur = Calleur
		
		# Positionnez le projectile à l'emplacement du BulletSpawner.
		projectile.global_transform = global_transform
		var rotation = MeshOfBody.rotation.y if MeshOfBody else 0
		# Calculez l'angle de rotation pour ce projectile.
		var angle = rotation + increment * i - deg_to_rad(ArcOfSplash) / 2
		
		# Appliquez la rotation au projectile.
		projectile.rotation.y = angle
		
		# Ajoutez le projectile à la scène.
		get_tree().get_root().add_child(projectile)

