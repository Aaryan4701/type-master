extends Control


func _on_speed_testbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://speed_test.tscn")

func _on_game_modebutton_pressed() -> void:
	get_tree().change_scene_to_file("res://game_mode.tscn")


#Adding animation when mouse hovers above the game mode section
func _on_game_modebg_mouse_entered() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($"GameMode-bg", "size:x", 1300, 0.2)
	tween.parallel().tween_property($"SpeedTest-bg", "size:x", 620, 0.2)
	tween.parallel().tween_property($"SpeedTest-bg", "position:x", 1300, 0.2)
	

func _on_game_modebg_mouse_exited() -> void:
	if not $"GameMode-bg".get_rect().has_point(get_local_mouse_position()):
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property($"GameMode-bg", "size:x", 960, 0.2)
		tween.parallel().tween_property($"SpeedTest-bg", "size:x", 960, 0.2)
		tween.parallel().tween_property($"SpeedTest-bg", "position:x", 960, 0.2)
	

#Adding animation when mouse hovers above the Speed test section
func _on_speed_testbg_mouse_entered() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($"SpeedTest-bg", "size:x", 1300, 0.2)
	tween.parallel().tween_property($"SpeedTest-bg", "position:x", 620, 0.2)
	tween.parallel().tween_property($"GameMode-bg", "size:x", 620, 0.2)
	tween.parallel().tween_property($"GameMode-bg", "position:x", 0, 0.2)
	
	
func _on_speed_testbg_mouse_exited() -> void:
	if not $"SpeedTest-bg".get_rect().has_point(get_local_mouse_position()):
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property($"GameMode-bg", "size:x", 960, 0.2)
		tween.parallel().tween_property($"GameMode-bg", "position:x", 0, 0.2)
		tween.parallel().tween_property($"SpeedTest-bg", "size:x", 960, 0.2)
		tween.parallel().tween_property($"SpeedTest-bg", "position:x", 960, 0.2)
