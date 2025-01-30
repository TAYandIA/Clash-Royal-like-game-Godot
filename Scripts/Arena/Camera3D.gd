extends Camera3D

func _physics_process(delta):
	# Créer un rayon à la position de la camera,vers la position des objets issus de la variable globale Dragged_Object
	if GlobalVariables.dragged_object: raycast(GlobalVariables.dragged_object)

func raycast(Object_to_ray):
	
	#Créer un rayon à la position de la camera,vers la position de Object_to_ray
	var mouse_position = get_viewport().get_mouse_position() #A décoché si je veux que l'object va au milieu de la carte et non a la pos de la sourie Object_to_ray.global_position
	var camera := get_viewport().get_camera_3d()
	var origin := camera.project_ray_origin(mouse_position)
	var direction := camera.project_ray_normal(mouse_position)
	var ray_length := 10000
	var end := origin + direction * ray_length
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end)
	var result = space_state.intersect_ray(query)

	#Variable globale position sourie dans un monde 3D
	GlobalVariables.mouse_position_3D = result["position"] if result else null
	#Variable globale object touché avec sourie dans un monde 3D
	GlobalVariables.mouse_position_3D_COLLIDER =  result["collider"] if result and result["collider"] == $"../Floor"  else null
	
