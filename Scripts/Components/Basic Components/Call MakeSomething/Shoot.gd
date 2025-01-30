@icon("res://Assets/IconForClasses/Icon Shoot.png")
class_name Shoot
extends Timer
##Les Events possédant la fonction : MakeSomething() ,qui vont être générés par ce component 
@export var EventShoot : Array[Node]
##Variable Calleur
var Calleur

func _ready():
	timeout.connect(_on_timer_nav_timeout)

#Appele la fonction MakeSomething à chaque Event quand le temps de TimerFire est écoulé
func _on_timer_nav_timeout(): 
	if Calleur and Calleur.CanShoot: #Si la variable CanShoot est active
		for event in EventShoot:
			event.Calleur = Calleur
			event.MakeSomething()

func Gain_Fire_Rate(FireRateValue):
	if wait_time + FireRateValue > 0.1 : wait_time += FireRateValue;print(wait_time)
	
func Change_Fire_Rate(FireRateValue):
	if FireRateValue > 0 : wait_time = FireRateValue
