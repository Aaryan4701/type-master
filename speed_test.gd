extends Node2D


	
# List of sample English paragraphs
var sample_texts = [
	"The quick brown fox jumps over the lazy dog near the shimmering riverbank, where morning light gleams across the water’s surface. Birds sing melodious tunes from the treetops, filling the air with a soft, comforting rhythm. A gentle breeze moves through the branches, rustling the leaves and carrying the scent of fresh earth and wildflowers. The sky above glows with soft shades of orange and blue, while squirrels scurry playfully across the ground. Nature awakens slowly, calmly, with grace. As the day begins, this peaceful environment offers quiet reflection and a moment of stillness. The fox stops briefly, listening to the river’s hum before continuing its journey across the mossy stones. Everything moves with purpose but without hurry, as if the world itself breathes slowly. In this perfect moment, the connection between living things and their surroundings is clear, reminding us to pause, to look, and to appreciate the beauty of the present.",

	"As technology accelerates, it becomes increasingly important to balance innovation with ethical responsibility. With every new breakthrough—whether in AI, robotics, or communications—we face new questions about privacy, sustainability, and inclusivity. Ensuring that progress serves all of humanity requires more than invention; it demands understanding, empathy, and dialogue. Different cultures and communities must work together, exchanging ideas and perspectives to guide development toward shared goals. Ethical frameworks, educational access, and thoughtful leadership become vital tools. Governments, developers, and individuals alike hold responsibility for shaping a future that is not just efficient, but fair and sustainable. When innovation grows unchecked by values, the consequences can be unintended and wide-reaching. But when creativity is matched with care, technology has the power to solve pressing issues, bring people closer, and uplift societies. The world of tomorrow is being built today—not just through code and machines, but through choices grounded in cooperation and compassion.",

	"Typing speed and accuracy improve dramatically with deliberate practice. Over time, repeated exposure to a wide range of vocabulary sharpens both the mind and the fingers. Complex phrases challenge the brain’s ability to process quickly while building muscle memory in the hands. Like learning an instrument, progress comes through consistency, rhythm, and focus. Exercises that combine familiar and new words increase agility and reinforce learning. Typing games, drills, and real-time feedback can make the process enjoyable and motivating. A fast typist not only impresses with speed but also displays strong attention to detail and mental organization. Beyond games, improved typing supports productivity in writing, coding, communication, and academic work. It reduces fatigue and frees up mental space for creativity. In today’s digital world, fluent typing is a fundamental skill. Even five to ten minutes of focused training each day can lead to significant growth over time, especially when paired with variety and challenge.",

	"Towering mountains rise above vast plains, their snow-draped peaks slicing through clouds and reaching toward the sky. Beneath them, rivers snake through rocky canyons, carving valleys over centuries. Forests blanket the lower slopes, alive with birdsong and movement, while meadows bloom with wildflowers in the warmer seasons. The landscape tells a story older than any civilization, where time seems slower and the natural world commands attention. Explorers trek through mist and stone, drawn by the quiet majesty of nature untouched. In the distance, waterfalls cascade down cliffs, feeding streams that nourish everything below. Each part of this ecosystem—every root, rock, and gust of wind—plays a role in a balance shaped by millennia. Whether seen from afar or felt underfoot, these places inspire awe and remind us of our small yet meaningful place within Earth’s rhythms. Protecting such wonders ensures they remain for future generations to explore, revere, and protect in turn.",

	"Programming languages like Python, JavaScript, and C++ empower developers to build the software systems that drive our digital world. Python’s simplicity and readability make it a favorite for beginners and professionals alike, especially in fields like data science and automation. JavaScript powers the interactivity of modern websites, allowing seamless user experiences across platforms. C++ offers low-level control ideal for games, embedded systems, and performance-heavy applications. Each language comes with its own logic, syntax, and design philosophy, challenging coders to adapt and problem-solve effectively. Learning multiple languages expands a developer’s mindset, exposing them to various paradigms such as object-oriented, functional, or procedural programming. Staying current requires constant learning, as frameworks, tools, and community standards evolve. Through trial, error, and collaboration, programmers shape the digital infrastructure we rely on—from apps and games to servers and simulations. Coding isn't just technical—it's creative, collaborative, and critical to shaping a smarter and more connected world.",

	"Throughout human history, great minds have explored questions about existence, thought, and the nature of the universe. From ancient philosophers in Greece and India to modern physicists like Einstein and Hawking, thinkers have sought to understand the fundamental truths of reality. What is consciousness? Do we have free will? Is the universe finite or infinite? These are not just academic questions—they influence ethics, science, religion, and our sense of self. Philosophy and science often intertwine, with one inspiring the other to ask deeper, better questions. Observations about time, matter, and energy lead to theories that reshape what we know about life and the cosmos. While many answers remain elusive, the pursuit itself enriches humanity. It teaches us to think critically, ask with curiosity, and accept uncertainty. This ongoing quest doesn’t just explain the universe—it reminds us of how much more there is to discover and how interconnected all knowledge truly is.",

	"Storytelling is one of the oldest and most powerful tools humans possess. Across generations, stories have preserved culture, shared lessons, and sparked imagination. From ancient cave paintings and oral traditions to printed books and streaming media, the way we tell stories has evolved—but the purpose remains. Stories entertain, teach, warn, and unite. They allow us to walk in someone else’s shoes, feel distant emotions, and understand complex issues. In every culture, storytelling shapes values, identity, and memory. A well-told tale lingers in the mind, inspiring thought and connection long after the final word. In today’s digital age, stories spread faster and farther than ever. Podcasts, games, films, and interactive media offer new ways to engage audiences. Whether it’s a personal anecdote or an epic saga, every story has the potential to move hearts and change minds. In the end, storytelling is more than communication—it’s the thread that binds people together."
]

# List of sample Python code paragraphs
var python_texts = [

"""print("Hello, world!") x = 5 y = 10 result = x + y print(result) name = "Alice" age = 12 print("Name:", name) print("Age:", age) for i in range(5): print(i) if x > y: print("x is greater") else: print("y is greater")""",

"""message = "Typing in Python" print(message) number = 42 answer = number * 2 print("Answer:", answer) username = "user123" print("Welcome", username) items = 5 price = 10 total = items * price print("Total:", total) print("Done!")""",

"""x = 1 y = 2 z = 3 total = x + y + z print("Total:", total) greeting = "Hi" print(greeting) if x < y: print("x is smaller") else: print("y is smaller") for i in range(3): print("Loop", i)""",

"""day = "Monday" print("Today is", day) temp = 25 print("Temperature:", temp) name = "Bob" print("Hello", name) age = 17 print("Age:", age) score = 90 print("Score:", score) print("Program ended.")""",

"""print("Python Practice") number = 100 print(number) a = 10 b = 20 print(a + b) word = "keyboard" print("Word:", word) print("Great job!") if a != b: print("Different values") print("Keep going!")""",

]


const MAX_CHARS_PER_CHUNK = 200 # Controls how many characters are shown at once

#Initialises all these varaibles to UI nodes once scene is opened
@onready var typing_text = $CanvasLayer/TypingText
@onready var time_label = $CanvasLayer/TimeRemaining
@onready var timer = $Timer
@onready var button15 = $CanvasLayer/Panel/TimerButtons/Button15
@onready var button30 = $CanvasLayer/Panel/TimerButtons/Button30
@onready var button60 = $CanvasLayer/Panel/TimerButtons/Button60
@onready var LanguageMenu = $CanvasLayer/Panel/LanguageMenu
# Stats Labels
@onready var last_score_label = $CanvasLayer/StatsPanel/LastScore
@onready var best_wpm_label = $CanvasLayer/StatsPanel/BestWPMLabel
@onready var score_label = $CanvasLayer/ScoreLabel

#Setting the variables
var full_text := "" # Entire paragraph selected
var current_index := 0 # Index of current char to type
var chunk_start_index := 0 # Where visible chunk starts
var correctness := [] # Tracks if typed chars are correct
var game_active := false # Set game to not running for now
var time_left := 30 #Defult time to start with
var has_started_typing := false #User has not started typing yet
var elapsed_time := 0.0 #No time has past yet
var typing_start_time := 0.0  # Time typing started
var selected_time := 30  # default starting time

# WPM Tracking
var correct_chars_typed := 0 #No correct chars typed for now
var total_chars_typed := 0 #No total chars typed for now
var best_wpm := 0.0 #Setting the highscore to 0 for now

const SAVE_FILE_PATH := "user://best_wpm.save" # Save file path for the best WPM

#Runs when the scene is opened
func _ready() -> void:
	randomize() #Generates a random number
# Disable focus highlight for buttons/menus so keyboard inputs dont controll them 
	button15.focus_mode = Control.FOCUS_NONE 
	button30.focus_mode = Control.FOCUS_NONE
	button60.focus_mode = Control.FOCUS_NONE
	LanguageMenu.focus_mode = Control.FOCUS_NONE
# Connect button presses to start_game with their respected time values
	button15.pressed.connect(func(): start_game(15))
	button30.pressed.connect(func(): start_game(30))
	button60.pressed.connect(func(): start_game(60))

	timer.timeout.connect(_on_timer_timeout) # Connect countdown
	timer.wait_time = 1 # 1-second countdown
	timer.autostart = false 
	timer.one_shot = false

	load_best_wpm() # Load saved best WPM
	update_best_wpm_label() #Updates the best WPM label 
	# Start default game
	LanguageMenu.item_selected.connect(func(index): start_game(selected_time)) #Gets the selected langauge from user
	start_game(30) #Starts the game with defult of 30 sec to start 

# Calles every frame
func _process(delta):
	# If the player has started typing and the game is still active
	if has_started_typing and game_active:
		elapsed_time += delta #add the time passed since the last frame to the total elapsed time.

# Starts the game with the given time limit
func start_game(seconds: int):
	selected_time = seconds
	time_left = seconds
	elapsed_time = 0.0
	game_active = true 
	has_started_typing = false
	correct_chars_typed = 0
	total_chars_typed = 0
	start_new_round() # Start a new round
	update_time_label() #Update the time label 
	update_current_stats() #Updates the live stats while the user types

#Loads the users best WPM 
func load_best_wpm():
	if FileAccess.file_exists(SAVE_FILE_PATH): #checks if the file exist
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ) #Reads the file
		if file:
			best_wpm = file.get_var() #Sets the best wpm to the one recorded in the file
			file.close() #closes the file

#saves the best WPM 
func save_best_wpm():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE) #Opnes a file 
	if file:
		file.store_var(best_wpm) #Stores the recorded wpm in the file
		file.close() #closes the file

#updates the best wpm label if one is achieved
func update_best_wpm_label():
	best_wpm_label.text = "Best WPM: " + str(round(best_wpm)) #changes the text to show the best wpm

# Starts a new typing round
func start_new_round():
	var selected_language = LanguageMenu.get_selected_id() #Sets the language to the one the user selects
	
	if selected_language == 0:  # English
		full_text = sample_texts[randi() % sample_texts.size()] #gets a randomised text from the English list
	else:  # Python
		full_text = python_texts[randi() % python_texts.size()] #gets a randomised text from the Python list
	
	# Reset typing state variables
	current_index = 0  
	chunk_start_index = 0 
	correctness = [] 
	# Fill correctness array with null for each character in text 
	for i in full_text.length():
		correctness.append(null)
	update_display() # Update on-screen text

#runs once the timer hits 0 
func _on_timer_timeout():
	if game_active:
		time_left -= 1 # Reduce time left by 1 second
		update_time_label() #Updates the time left label
		update_current_stats() #Updates the live stats of the user

		if time_left <= 0: #If the timer hits 0
			game_active = false  #End the game
			timer.stop() #stops the timer
			time_label.text = "Time's up!" #Display text on the time label
			calc_and_display_final_stats() #calculate the users stats and display them
			await get_tree().create_timer(5).timeout # Wait 5 seconds before restarting
			start_game(selected_time) #Restart game with the time the user selects

#Updates the time label 
func update_time_label():
	time_label.text = str(time_left) + "s"
#updates the text displayed on the screen
func update_display():
	var display_text := "" # Start with an empty string to build the display
	var chunk_end = min(chunk_start_index + MAX_CHARS_PER_CHUNK, full_text.length()) # Define how far into the text the visible chunk goes
	var visible_chunk = full_text.substr(chunk_start_index, chunk_end - chunk_start_index) # Get the visible portion of the full text

	for i in visible_chunk.length(): # Loop through each character in the visible chunk
		var global_i = chunk_start_index + i # Get global index in full_text
		var char = visible_chunk[i] # Get the current character
#Changes the backgrounds of the colours depending if the user did a correct/wrong input
		if correctness[global_i] == true:
			display_text += "[bgcolor=#ccffcc][color=black]" + char + "[/color][/bgcolor]" # If character is typed correctly, highlight green
		elif correctness[global_i] == false:
			display_text += "[bgcolor=#ffcccc][color=black]" + char + "[/color][/bgcolor]" # If character is typed incorrectly, highlight red
		elif global_i == current_index:
			display_text += "[u]" + char + "[/u]" # Otherwise, show normal character
		else:
			display_text += char

	typing_text.text = display_text # Update the UI label with the final constructed text
	
# Handles user input during the game
func _input(event: InputEvent) -> void:
	if not game_active:
		return # Ignore input if the game is not active

	if event is InputEventKey and event.pressed and not event.echo: # If the user presses a key and is not repeated
		if not has_started_typing: # Start timer on first key press
			has_started_typing = true
			typing_start_time = Time.get_ticks_msec()
			timer.start() 


		var key_char: String = char(event.unicode) # Get the typed character

		# Handle backspace
		if event.keycode == KEY_BACKSPACE: #if input was backspace 
			if current_index > 0: # Only backspace if not at start
				current_index -= 1 #Go back to the letter behind

				# Adjust stats when backspacing
				if correctness[current_index] == true: # If the removed character was correct, decrease correct counter
					correct_chars_typed = max(correct_chars_typed - 1, 0) 
				if correctness[current_index] != null: # If the removed character was already judged, reduce total count
					total_chars_typed = max(total_chars_typed - 1, 0)

				correctness[current_index] = null # Clear correctness at current position

				if current_index < chunk_start_index:
					chunk_start_index = max(chunk_start_index - MAX_CHARS_PER_CHUNK, 0) # Scroll text window left if we're at the start of the chunk

				update_display() #Update the display
			return #Exit the loop

		# Accept only printable characters
		if key_char.length() == 1 and current_index < full_text.length():
			var expected_char := full_text[current_index] # Get the correct expected character
# If correct, mark as correct and increase score
			if key_char == expected_char:
				correctness[current_index] = true
				correct_chars_typed += 1
# Otherwise, mark as incorrect
			else:
				correctness[current_index] = false

			total_chars_typed += 1 #Incrememnt the total characters typed

			current_index += 1 #increment to the next letter
# If the current index is bigger than the starting chunk of words
			if current_index >= chunk_start_index + MAX_CHARS_PER_CHUNK:
				chunk_start_index += MAX_CHARS_PER_CHUNK #Add the other set of words by the max char limit (70)

			if current_index >= full_text.length(): # If all characters have been typed
				game_active = false #End the game
				timer.stop() #Stop the timer
				time_label.text = "Text Complete!" #Display to user 
				calc_and_display_final_stats() #Calculate the users stats
				await get_tree().create_timer(1.5).timeout #Wait 1.5 sec
				start_game(time_left)
			else: #If the charatcers have not been typed 
				update_display() #update the display
				update_current_stats() #Update the live stats 

#Calculates the live stats of the user
func update_current_stats():
	if not has_started_typing or total_chars_typed == 0:
		score_label.text = "WPM: 0  Accuracy: 0%" # If user hasn’t started typing, show 0s
		return #Exit 
# Calculate how long user has been typing
	var elapsed_ms = Time.get_ticks_msec() - typing_start_time
	var minutes_passed = max(elapsed_ms / 60000.0, 1.0 / 60.0)  # Convert to minutes (prevent divide by zero)
	var wpm = (correct_chars_typed / 5.0) / minutes_passed # Calculate WPM 
	var accuracy = (correct_chars_typed / float(total_chars_typed)) * 100.0 # Calculate accuracy in percentage 

	score_label.text = "WPM: " + str(round(wpm)) + "  Accuracy: " + str(round(accuracy)) + "%" #Display the stats to the user

# Calculates and displays the final score after round ends
func calc_and_display_final_stats():
	if elapsed_time <= 0: # Prevent divide-by-zero if no time tracked
		elapsed_time = 1.0

	var minutes_passed = elapsed_time / 60.0 # Convert time to minutes
	var wpm = (correct_chars_typed / 5.0) / minutes_passed # Calculate WPM

	var accuracy = 0.0 # Default accuracy to 0
	if total_chars_typed > 0: # If the player typed something
		accuracy = (correct_chars_typed / total_chars_typed) * 100.0 #Calculate the accuracy in percentage
#Display the stats 
	var final_score_text = "WPM: " + str(round(wpm)) + "  Accuracy: " + str(round(accuracy)) + "%"
	score_label.text = final_score_text
	last_score_label.text = "Last Round: " + final_score_text
#Checheck if user got a high score
	if wpm > best_wpm:
		best_wpm = wpm
		update_best_wpm_label()
		save_best_wpm()

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn") #Redirect user to home page if clicked
