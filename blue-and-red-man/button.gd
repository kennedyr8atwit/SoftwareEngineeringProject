extends Button


func _on_pressed():
	var new_scene = preload("res://levels_selection.tscn")
	get_tree().change_scene_to_packed(new_scene)
	
	
