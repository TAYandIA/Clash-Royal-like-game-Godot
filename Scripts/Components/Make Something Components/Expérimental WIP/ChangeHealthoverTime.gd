class_name PoisonBullet
extends Node
#TODO Améliorer de code pour permmetre Changer n'importe quelle stat sur le temps
@export_category("Poison")
@export var HealOrDamageValue : float = 0
@export var TimePerHeal : float = 0
@export var NumberOfHealing : int = 1

@onready var Health_component := "UI (subview)/HealthComponent"

func MakeSomething(body):
	if body.has_node(Health_component):
		body.get_node(Health_component).change_health_over_time(HealOrDamageValue,TimePerHeal,NumberOfHealing)
		print(body)
