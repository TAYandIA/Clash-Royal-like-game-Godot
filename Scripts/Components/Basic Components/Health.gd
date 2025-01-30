class_name HealthComponent
extends ProgressBar
##Pour Le Nombre D'FPS (Débugging)
@export var DebugText : Label
##Les Events possédant la fonction : MakeSomething() ,qui vont être générés par ce component lorsque que le CAlleur prend des dégats
@export var EventWhenDamaged : Array[Node]
##Variable du Calleur
var Calleur

func _process(delta):
	#Gère le text pour faire apparaître les FPS (débugging)
	DebugText.text = str(Engine.get_frames_per_second())+" FPS\n"
	
	#Si PV en dessous de 0
	if value <=0:
		owner.kill(true) #On kill Définitevemnt (d'oû le paramètre true) avce la fonction kill() (voir script troop.gd)

func Gain_Health(HealValue):
	value += HealValue
	#Call_Event lors de la prise de dégats
	if HealValue < 0: Call_Event()
	
func Change_Health(HealthValue):
	if HealthValue < value : Call_Event()
	value = HealthValue
	
#Appelle les évènements
func Call_Event():
	for i in EventWhenDamaged:
		i.Calleur = Calleur
		i.MakeSomething(Calleur)
