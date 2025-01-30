class_name MakeEventInArea
extends Area3D

##Les Events possédant la fonction : MakeSomething() ,qui vont être générés par ce component
@export var Event : Array[Node]

##La Façon dont sont sélectionnées les troops entrantes et sortantes par rapport à l'entité
@export_enum("Entities that are in the same Side","Entities that are not in the same Side") var ApplyEventTo
##Permet de compter, si oui ou non, cette entitée dont le calcul des troops sélectionnées
@export var CountSelfToo : bool
##variable du calleur
var Calleur

func _ready() -> void:
	body_entered.connect(When_Body_Entered)
	
func MakeSomething(body = null):
	visible = true
	$CollisionShape3D.call_deferred("set_disabled",true)
	$CollisionShape3D.call_deferred("set_disabled",false)
	if has_node("AnimationPlayer"): $AnimationPlayer.play("CheckInArea")
func When_Body_Entered(body):
	if not Calleur or body not in GlobalVariables.Troops:
		return
	if CountSelfToo != true and body == Calleur:
		return
		#Filtrage des troupes selon leur Teamside et celui de l'entité et Ajoute Calleur si CountSelfToo est vrai
	if (body.TeamSide == Calleur.TeamSide and ApplyEventTo == 0) or (body.TeamSide != Calleur.TeamSide and ApplyEventTo == 1): 
		#Appelle Event
		for i in Event:
			if Calleur and i != null: 
				i.Calleur = Calleur
				i.MakeSomething(body)
