extends Control

#Loads the Speed Test scene once the button is pressed
func _on_speed_testbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://speed_test.tscn")
#Loads the Game Mode scene once the button is pressed
func _on_game_modebutton_pressed() -> void:
	get_tree().change_scene_to_file("res://game_mode.tscn")
	
#Plays a soundeffect once the user hovers above the button
func _on_speed_testbutton_mouse_entered() -> void:
	$ButtonSound.play()
	
#Plays a soundeffect once the user hovers above the button
func _on_game_modebutton_mouse_entered() -> void:
	$ButtonSound.play()


#Adding animation when mouse hovers above the game mode section
func _on_game_modebg_mouse_entered() -> void:
	$SpeedTestSound.stop() #Stops the sound
	$GameModeSound.play() #Plays the sound
	var tween = create_tween() # Create a tween animation
	tween.set_trans(Tween.TRANS_SINE) # Use sine transition
	tween.set_ease(Tween.EASE_OUT) # Ease out for smoother animation
	tween.tween_property($"GameMode-bg", "size:x", 1300, 0.2) # Widen Game Mode background
	tween.parallel().tween_property($"SpeedTest-bg", "size:x", 620, 0.2) # Shrink Speed Test background at the same time
	tween.parallel().tween_property($"SpeedTest-bg", "position:x", 1300, 0.2) #Change the position of the Background at the same time
	

func _on_game_modebg_mouse_exited() -> void:
	if not $"GameMode-bg".get_rect().has_point(get_local_mouse_position()): # Check if mouse actually left the background and not button
		var tween = create_tween() #Create tween animation
		tween.set_trans(Tween.TRANS_SINE) # Use a sine transition
		tween.set_ease(Tween.EASE_OUT) # Ease out for smoother animation
		tween.tween_property($"GameMode-bg", "size:x", 960, 0.2) #Changes the size of the background to its original
		tween.parallel().tween_property($"SpeedTest-bg", "size:x", 960, 0.2) #Changes the size of the speed test background to its original at the same time
		tween.parallel().tween_property($"SpeedTest-bg", "position:x", 960, 0.2) #Changes its position to its original
	

#Adding animation when mouse hovers above the Speed test section
func _on_speed_testbg_mouse_entered() -> void:
	$GameModeSound.stop() # Stop Game Mode sound
	$SpeedTestSound.play() # Play Speed Test sound
	var tween = create_tween() #Create tween animation
	tween.set_trans(Tween.TRANS_SINE) 
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($"SpeedTest-bg", "size:x", 1300, 0.2) # Widen Speed Test background
	tween.parallel().tween_property($"SpeedTest-bg", "position:x", 620, 0.2) # Shift Speed Test to the left
	tween.parallel().tween_property($"GameMode-bg", "size:x", 620, 0.2) # Shrink Game Mode background
	tween.parallel().tween_property($"GameMode-bg", "position:x", 0, 0.2) # Shift the Game mode background to the left
	
	
func _on_speed_testbg_mouse_exited() -> void:
	if not $"SpeedTest-bg".get_rect().has_point(get_local_mouse_position()): # Check if mouse actually left the background rather than the button
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property($"GameMode-bg", "size:x", 960, 0.2) # Reset Game Mode size
		tween.parallel().tween_property($"GameMode-bg", "position:x", 0, 0.2) # Reset Game Mode position at same time to the rest
		tween.parallel().tween_property($"SpeedTest-bg", "size:x", 960, 0.2)  # Reset Speed Test size at same time
		tween.parallel().tween_property($"SpeedTest-bg", "position:x", 960, 0.2) # Reset Speed Test position at same time
		
