class_name Capacité
extends ProgressBar

##Les Events possédant la fonction : MakeSomething() ,qui vont être générés par ce component 
@export var EventCapacities : Array[Node]

#Génère les events, puis rénitialise la "value" de ProgressBar
func _physics_process(delta: float) -> void:
	if value >= max_value:
		for event in EventCapacities:
			if event != null :event.MakeSomething()
		value = 0

func Gain_Capacity(CapacityValue):
	value += CapacityValue
	
func Change_Capacity(CapacityValue):
	value = CapacityValue
		
