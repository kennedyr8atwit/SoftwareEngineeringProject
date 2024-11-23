extends Button




func _on_grass_pressed() -> void:
	var new_scene = preload("res://grass.tscn")
	get_tree().change_scene_to_packed(new_scene)
	
