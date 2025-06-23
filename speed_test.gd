extends Node2D


	
# Sample texts you want to randomly display
var sample_texts = [
	"The quick brown fox jumps over the lazy dog near the shimmering riverbank, where morning light gleams across the water’s surface. Birds sing melodious tunes from the treetops, filling the air with a soft, comforting rhythm. A gentle breeze moves through the branches, rustling the leaves and carrying the scent of fresh earth and wildflowers. The sky above glows with soft shades of orange and blue, while squirrels scurry playfully across the ground. Nature awakens slowly, calmly, with grace. As the day begins, this peaceful environment offers quiet reflection and a moment of stillness. The fox stops briefly, listening to the river’s hum before continuing its journey across the mossy stones. Everything moves with purpose but without hurry, as if the world itself breathes slowly. In this perfect moment, the connection between living things and their surroundings is clear, reminding us to pause, to look, and to appreciate the beauty of the present.",

	"As technology accelerates, it becomes increasingly important to balance innovation with ethical responsibility. With every new breakthrough—whether in AI, robotics, or communications—we face new questions about privacy, sustainability, and inclusivity. Ensuring that progress serves all of humanity requires more than invention; it demands understanding, empathy, and dialogue. Different cultures and communities must work together, exchanging ideas and perspectives to guide development toward shared goals. Ethical frameworks, educational access, and thoughtful leadership become vital tools. Governments, developers, and individuals alike hold responsibility for shaping a future that is not just efficient, but fair and sustainable. When innovation grows unchecked by values, the consequences can be unintended and wide-reaching. But when creativity is matched with care, technology has the power to solve pressing issues, bring people closer, and uplift societies. The world of tomorrow is being built today—not just through code and machines, but through choices grounded in cooperation and compassion.",

	"Typing speed and accuracy improve dramatically with deliberate practice. Over time, repeated exposure to a wide range of vocabulary sharpens both the mind and the fingers. Complex phrases challenge the brain’s ability to process quickly while building muscle memory in the hands. Like learning an instrument, progress comes through consistency, rhythm, and focus. Exercises that combine familiar and new words increase agility and reinforce learning. Typing games, drills, and real-time feedback can make the process enjoyable and motivating. A fast typist not only impresses with speed but also displays strong attention to detail and mental organization. Beyond games, improved typing supports productivity in writing, coding, communication, and academic work. It reduces fatigue and frees up mental space for creativity. In today’s digital world, fluent typing is a fundamental skill. Even five to ten minutes of focused training each day can lead to significant growth over time, especially when paired with variety and challenge.",

	"Towering mountains rise above vast plains, their snow-draped peaks slicing through clouds and reaching toward the sky. Beneath them, rivers snake through rocky canyons, carving valleys over centuries. Forests blanket the lower slopes, alive with birdsong and movement, while meadows bloom with wildflowers in the warmer seasons. The landscape tells a story older than any civilization, where time seems slower and the natural world commands attention. Explorers trek through mist and stone, drawn by the quiet majesty of nature untouched. In the distance, waterfalls cascade down cliffs, feeding streams that nourish everything below. Each part of this ecosystem—every root, rock, and gust of wind—plays a role in a balance shaped by millennia. Whether seen from afar or felt underfoot, these places inspire awe and remind us of our small yet meaningful place within Earth’s rhythms. Protecting such wonders ensures they remain for future generations to explore, revere, and protect in turn.",

	"Programming languages like Python, JavaScript, and C++ empower developers to build the software systems that drive our digital world. Python’s simplicity and readability make it a favorite for beginners and professionals alike, especially in fields like data science and automation. JavaScript powers the interactivity of modern websites, allowing seamless user experiences across platforms. C++ offers low-level control ideal for games, embedded systems, and performance-heavy applications. Each language comes with its own logic, syntax, and design philosophy, challenging coders to adapt and problem-solve effectively. Learning multiple languages expands a developer’s mindset, exposing them to various paradigms such as object-oriented, functional, or procedural programming. Staying current requires constant learning, as frameworks, tools, and community standards evolve. Through trial, error, and collaboration, programmers shape the digital infrastructure we rely on—from apps and games to servers and simulations. Coding isn't just technical—it's creative, collaborative, and critical to shaping a smarter and more connected world.",

	"Throughout human history, great minds have explored questions about existence, thought, and the nature of the universe. From ancient philosophers in Greece and India to modern physicists like Einstein and Hawking, thinkers have sought to understand the fundamental truths of reality. What is consciousness? Do we have free will? Is the universe finite or infinite? These are not just academic questions—they influence ethics, science, religion, and our sense of self. Philosophy and science often intertwine, with one inspiring the other to ask deeper, better questions. Observations about time, matter, and energy lead to theories that reshape what we know about life and the cosmos. While many answers remain elusive, the pursuit itself enriches humanity. It teaches us to think critically, ask with curiosity, and accept uncertainty. This ongoing quest doesn’t just explain the universe—it reminds us of how much more there is to discover and how interconnected all knowledge truly is.",

	"Storytelling is one of the oldest and most powerful tools humans possess. Across generations, stories have preserved culture, shared lessons, and sparked imagination. From ancient cave paintings and oral traditions to printed books and streaming media, the way we tell stories has evolved—but the purpose remains. Stories entertain, teach, warn, and unite. They allow us to walk in someone else’s shoes, feel distant emotions, and understand complex issues. In every culture, storytelling shapes values, identity, and memory. A well-told tale lingers in the mind, inspiring thought and connection long after the final word. In today’s digital age, stories spread faster and farther than ever. Podcasts, games, films, and interactive media offer new ways to engage audiences. Whether it’s a personal anecdote or an epic saga, every story has the potential to move hearts and change minds. In the end, storytelling is more than communication—it’s the thread that binds people together."
]

const MAX_CHARS_PER_CHUNK = 200

# === Node Refs ===
@onready var typing_text = $CanvasLayer/TypingText
@onready var time_label = $CanvasLayer/TimeRemaining
@onready var timer = $Timer
@onready var button15 = $CanvasLayer/Panel/TimerButtons/Button15
@onready var button30 = $CanvasLayer/Panel/TimerButtons/Button30
@onready var button60 = $CanvasLayer/Panel/TimerButtons/Button60

# Stats Labels
@onready var last_score_label = $CanvasLayer/StatsPanel/LastScore
@onready var best_wpm_label = $CanvasLayer/StatsPanel/BestWPMLabel
@onready var score_label = $CanvasLayer/ScoreLabel

# === Typing Game State ===
var full_text := ""
var current_index := 0
var chunk_start_index := 0
var correctness := []
var game_active := false
var time_left := 30
var has_started_typing := false
var elapsed_time := 0.0
var typing_start_time := 0.0
var selected_time := 30  # default starting time



# WPM Tracking
var correct_chars_typed := 0
var total_chars_typed := 0
var best_wpm := 0.0

const SAVE_FILE_PATH := "user://best_wpm.save"

func _ready() -> void:
	randomize()

	button15.focus_mode = Control.FOCUS_NONE
	button30.focus_mode = Control.FOCUS_NONE
	button60.focus_mode = Control.FOCUS_NONE

	button15.pressed.connect(func(): start_game(15))
	button30.pressed.connect(func(): start_game(30))
	button60.pressed.connect(func(): start_game(60))

	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = 1
	timer.autostart = false
	timer.one_shot = false

	load_best_wpm()
	update_best_wpm_label()

	start_game(30)

func _process(delta):
	if has_started_typing and game_active:
		elapsed_time += delta

func start_game(seconds: int):
	selected_time = seconds
	time_left = seconds
	elapsed_time = 0.0
	game_active = true
	has_started_typing = false
	correct_chars_typed = 0
	total_chars_typed = 0
	start_new_round()
	update_time_label()
	update_current_stats()

func load_best_wpm():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			best_wpm = file.get_var()
			file.close()

func save_best_wpm():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(best_wpm)
		file.close()

func update_best_wpm_label():
	best_wpm_label.text = "Best WPM: " + str(round(best_wpm))

func start_new_round():
	full_text = sample_texts[randi() % sample_texts.size()]
	current_index = 0
	chunk_start_index = 0
	correctness = []
	for i in full_text.length():
		correctness.append(null)
	update_display()

func _on_timer_timeout():
	if game_active:
		time_left -= 1
		update_time_label()
		update_current_stats()

		if time_left <= 0:
			game_active = false
			timer.stop()
			time_label.text = "Time's up!"
			calc_and_display_final_stats()
			await get_tree().create_timer(5).timeout
			start_game(selected_time)

func update_time_label():
	time_label.text = str(time_left) + "s"

func update_display():
	var display_text := ""
	var chunk_end = min(chunk_start_index + MAX_CHARS_PER_CHUNK, full_text.length())
	var visible_chunk = full_text.substr(chunk_start_index, chunk_end - chunk_start_index)

	for i in visible_chunk.length():
		var global_i = chunk_start_index + i
		var char = visible_chunk[i]

		if correctness[global_i] == true:
			display_text += "[bgcolor=#ccffcc][color=black]" + char + "[/color][/bgcolor]"
		elif correctness[global_i] == false:
			display_text += "[bgcolor=#ffcccc][color=black]" + char + "[/color][/bgcolor]"
		elif global_i == current_index:
			display_text += "[u]" + char + "[/u]"
		else:
			display_text += char

	typing_text.text = display_text
	
func _input(event: InputEvent) -> void:
	if not game_active:
		return

	if event is InputEventKey and event.pressed and not event.echo:
		if not has_started_typing:
			has_started_typing = true
			typing_start_time = Time.get_ticks_msec()
			timer.start()


		var key_char: String = char(event.unicode)

		# Handle backspace
		if event.keycode == KEY_BACKSPACE:
			if current_index > 0:
				current_index -= 1

				# Adjust stats when correcting
				if correctness[current_index] == true:
					correct_chars_typed = max(correct_chars_typed - 1, 0)
				if correctness[current_index] != null:
					total_chars_typed = max(total_chars_typed - 1, 0)

				correctness[current_index] = null

				if current_index < chunk_start_index:
					chunk_start_index = max(chunk_start_index - MAX_CHARS_PER_CHUNK, 0)

				update_display()
			return

		# Accept only printable characters
		if key_char.length() == 1 and current_index < full_text.length():
			var expected_char := full_text[current_index]

			if key_char == expected_char:
				correctness[current_index] = true
				correct_chars_typed += 1
			else:
				correctness[current_index] = false

			total_chars_typed += 1

			current_index += 1

			if current_index >= chunk_start_index + MAX_CHARS_PER_CHUNK:
				chunk_start_index += MAX_CHARS_PER_CHUNK

			if current_index >= full_text.length():
				game_active = false
				timer.stop()
				time_label.text = "Text Complete!"
				calc_and_display_final_stats()
				await get_tree().create_timer(1.5).timeout
				start_game(time_left)
			else:
				update_display()
				update_current_stats()


func update_current_stats():
	if not has_started_typing or total_chars_typed == 0:
		score_label.text = "WPM: 0  Accuracy: 0%"
		return

	var elapsed_ms = Time.get_ticks_msec() - typing_start_time
	var minutes_passed = max(elapsed_ms / 60000.0, 1.0 / 60.0)  # Avoid div by 0

	var wpm = (correct_chars_typed / 5.0) / minutes_passed
	var accuracy = (correct_chars_typed / float(total_chars_typed)) * 100.0

	score_label.text = "WPM: " + str(round(wpm)) + "  Accuracy: " + str(round(accuracy)) + "%"


func calc_and_display_final_stats():
	if elapsed_time <= 0:
		elapsed_time = 1.0

	var minutes_passed = elapsed_time / 60.0
	var wpm = (correct_chars_typed / 5.0) / minutes_passed

	var accuracy = 0.0
	if total_chars_typed > 0:
		accuracy = (correct_chars_typed / total_chars_typed) * 100.0

	var final_score_text = "WPM: " + str(round(wpm)) + "  Accuracy: " + str(round(accuracy)) + "%"
	score_label.text = final_score_text
	last_score_label.text = "Last WPM: " + str(round(wpm))

	if wpm > best_wpm:
		best_wpm = wpm
		update_best_wpm_label()
		save_best_wpm()

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
