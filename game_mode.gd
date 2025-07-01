extends Node2D

# Load the enemy scene so it can be called later
var Enemy = preload("res://enemy.tscn")
#Once the game loads , it links these variables to nodes and UI elements
@onready var enemy_container = $EnemyContainer
@onready var spawn_container = $SpawnContainer
@onready var spawn_timer = $SpawnTimer
@onready var difficulty_timer = $DifficultyTimer

@onready var difficulty_value = $CanvasLayer/VBoxContainer/BottomRow/HBoxContainer/DifficultyValue
@onready var killed_value = $CanvasLayer/VBoxContainer/TopRow2/TopRow/EnemiesKilledValue
@onready var game_over_screen = $CanvasLayer/GameOverScreen
@onready var highscore_value = $CanvasLayer/VBoxContainer/BottomRow/HBoxContainer/HighScoreValue

var highscore: int = 0 #Initialising Highscore to 0
var active_enemy = null # No Currently focused enemy for now
var current_letter_index: int = -1  # Tracks typing position

var difficulty: int = 0 #Setting difficulty as 0 for now
var enemies_killed: int = 0 #Setting the killed enemies to be 0 for now

# Runs when scene is ready
func _ready() -> void:
	load_highscore() #Loads highscore right when the scene is ready
	start_game() #Starts the game 

# Looks for an enemy whose word starts with the typed letter
func find_new_active_enemy(typed_character: String):
	for enemy in enemy_container.get_children(): #Loops through all the enemies
		var prompt = enemy.get_prompt() #gets the enemies word
		var next_character = prompt.substr(0 , 1) # gets the first letter
		if next_character == typed_character: #If the input matches the typed character
			print("found new enemy that starts with %s" % next_character ) #Testing
			active_enemy = enemy #Set as active enemy
			current_letter_index = 1 #Incrememnt to next letter
			active_enemy.set_next_character(current_letter_index) # Update the highlighting of texts
			$LazerMusic.play() #Play a lazer sound for every correct input
			return #exit the loop
			
#Handles all the inputs by the user
func _unhandled_input(event: InputEvent) -> void: 
	if event is InputEventKey and event.is_pressed(): # If a key was pressed
		var typed_event = event as InputEventKey  # Convert the input event into a key press event
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8() # Convert key to string

		if active_enemy == null:
			find_new_active_enemy(key_typed) #If there is no active enemy , then find a new one using the users input
		else:
			var prompt = active_enemy.get_prompt() #Get the prompt from the enemy
			var next_character = prompt.substr(current_letter_index, 1) # Get expected character
			if key_typed == next_character: #If input is correct
				print("sucessfully typed %s" % key_typed) #Testing
				current_letter_index +=1 # Move to next letter
				active_enemy.set_next_character(current_letter_index) # Update tje highlighting of the text
				$LazerMusic.play() #Play shooting sound
				
				if current_letter_index == prompt.length(): #If the user finished the word
					print("done") #testing
					current_letter_index = -1 #Set back to original
					active_enemy.queue_free() # Remove the Enemy
					active_enemy = null #No more active enemy 
					enemies_killed += 1 #Incrememnt the kills
					killed_value.text = str(enemies_killed) #Change the text on screen
					$ExplosionMusic.play() #Play explosion sound 
					
					if enemies_killed > highscore: #Checks if the user got a highscore
						highscore = enemies_killed # makes the highscore the kills the user got
						highscore_value.text = str(highscore) #Changes the text
						save_highscore() #Saves the highscore
					
			else: # If the user inputs wrong
				print("incorrectly typed %s instead of %s" % [key_typed , next_character]) #Test
				
	


func _on_spawn_timer_timeout() -> void: 
	spawn_enemy() #Once the spawn timer runs out , and enemy will be spawned

	
# Create and place a new enemy 
func spawn_enemy():
	var enemy_instance = Enemy.instantiate() # Create enemy
	var spawns = spawn_container.get_children() # Get spawn points
	var index = randi() % spawns.size() # Pick random spawn
	enemy_instance.global_position = spawns[index].global_position # Set position
	enemy_container.add_child(enemy_instance) # Add to scene
	enemy_instance.set_difficulty(difficulty) # Set difficulty for the enemy

# Make the speed of the enemies increase over time
func _on_difficulty_timer_timeout() -> void:
	if difficulty >= 20: # sets a maximum amount of diffuclty to 20
		difficulty_timer.stop() #Stops the timer if this value is reached
		difficulty = 20
		return #Exits the loop
	
	difficulty += 1 #Increment diffifuclty once timer runs out
	GlobalSignals.emit_signal("difficulty_increased", difficulty) # Emit signal
	print("Difficulty increased to %d" % difficulty) #testing
	var new_wait_time = spawn_timer.wait_time - 0.2 # Make enemies spawn faster by removing 0.2 sec
	spawn_timer.wait_time = clamp(new_wait_time , 1 , spawn_timer.wait_time) # Keep within limits
	difficulty_value.text = str(difficulty) # Update the text on screen

#Once the loose area detects an enemy
func _on_loose_area_body_entered(body: Node2D) -> void:
	game_over() #Ends the game 
	
func game_over():
	$BackgroundMusic.stop() #Stops the music
	$GameOverMusic.play() #Plays the game over sound
	game_over_screen.show() #Shows the game over screen
	spawn_timer.stop() #Stops the spawn timer
	difficulty_timer.stop() #stops the difficulty timer
	#clear out any existing enemies after game ends.
	active_enemy = null # Clear active enemy
	current_letter_index = -1 # Reset typing index
	for enemy in enemy_container.get_children(): # loops for all the enemies 
		enemy.queue_free() #removes each enemy from the screen
	
# Start or restart the game
func start_game():
	game_over_screen.hide() # Hide game over UI
	difficulty = 0 # Reset difficulty
	enemies_killed = 0 # Reset kills
	difficulty_value.text = str(0) # Update UI
	killed_value.text = str(0) # Update UI
	randomize() #gets a random number
	spawn_timer.start() #Starts the spawn timer
	difficulty_timer.start() #Starts the difficulty timer
	spawn_enemy() # Spawn enemies
	highscore_value.text = str(highscore) # Change the text for the highscore
	$BackgroundMusic.play() #Play the background music again
	
# Runs when the restart button on game over screen is pressed
func _on_restart_button_pressed() -> void:
	spawn_timer.wait_time = 5 # 5 sec interval 
	start_game() #Starts the game

#Runs when the homebutton on top corner of screen is pressed
func _on_home_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn") #Redirects user to home page

#Runs when the homebutton on the game over screen is pressed
func _on_home_button_1_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn") #Redirects user to home page

#Function that saves the user highscore once one is detected
func save_highscore():
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE) # Open file to write
	file.store_var(highscore) # Save the highscore
	file.close() #Closes the file

func load_highscore():
	if FileAccess.file_exists("user://highscore.save"):  # Check if file exists
		var file = FileAccess.open("user://highscore.save", FileAccess.READ) # Open file to read
		highscore = file.get_var() # Load highscore value
		file.close() #Closes the file
