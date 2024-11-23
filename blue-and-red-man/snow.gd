extends Button


	


func _on_snow_pressed() -> void:
	var new_scene = preload("res://world.tscn")
	get_tree().change_scene_to_packed(new_scene)
	
