extends NavigationRegion3D

#Fichier pour Créer la NAVIGATION REGION et l'actualiser

#TODO: faire l'actualisation
#

#func _on_bake_finished() -> void:
	#await get_tree().create_timer(0.1).timeout
	#bake_navigation_mesh()

func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area :
	# Rend l'objet invisible et désactive son mode de traitement
		area.call_deferred("queue_free")

#func _ready() -> void:
	#var somme = 0
	#for i in GlobalVariables.Troops:
		#if i.TeamSide == GlobalVariables.PlayerTeam :
			#somme += i.get_node("UI (subview)/HealthComponent").max_value
	#$"../CanvasLayer/ProgressBar2".max_value = somme
