extends Button


func _on_metal_pressed() -> void:
	var new_scene = preload("res://metal.tscn")
	get_tree().change_scene_to_packed(new_scene)
