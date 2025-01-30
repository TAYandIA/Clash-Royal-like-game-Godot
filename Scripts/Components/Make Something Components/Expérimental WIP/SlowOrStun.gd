class_name BuffSpeedBulletsComponent
extends Node

#TODO Améliorer de code pour permmetre Changer n'importe quelle stat sur le temps
@export_category("Speed,Slow and Stun")
@export var CoefficientOfSpeed : float = 1
@export var SpeedDuration : float = 0

#@export_subgroup("Poison")
#@export var PoisonDamageValue : float = 0
#@export var PoisonDuration : float = 0
#
#@export_subgroup("Silence")
#@export var SilenceDuration : float = 0

@onready var Move_component := "Components/MoveComponent"

func MakeSomething(body):
	if body.has_node(Move_component): 
		body.get_node(Move_component).change_speed_value(SpeedDuration,CoefficientOfSpeed)
