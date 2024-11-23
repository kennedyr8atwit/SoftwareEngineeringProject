extends Button




func _on_castle_pressed() -> void:
	var new_scene = preload("res://castle.tscn")
	get_tree().change_scene_to_packed(new_scene)
	
