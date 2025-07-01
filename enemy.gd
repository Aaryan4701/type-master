#extends Sprite2D
extends CharacterBody2D

# Define color values for text formatting
@export var blue: Color = Color("#4682b4") # Color for correctly typed letters
@export var green: Color = Color("#639765")  # Color for the next letter to type
@export var red: Color = Color("#a65455") # Color for remaining untyped letters

# Movement speed of the enemy
@export var speed: float = 0.5

# Get references to nodes and properties
@onready var prompt = $RichTextLabel
@onready var prompt_text = prompt.text

# Called when the enemy is added to the scene
func _ready() -> void:
	prompt_text = PromptList.get_prompt()  # Get a new prompt from the list
	prompt.parse_bbcode(set_center_tags(prompt_text)) # Center and display the word
	GlobalSignals.difficulty_increased.connect(handle_difficulty_increased) # Listen for difficulty changes

# Called every physics frame
func _physics_process(delta: float) -> void:
	global_position.x -= speed # Move the enemy left based on speed
	
# Sets difficulty manually if called
func set_difficulty(difficulty: int):
	handle_difficulty_increased(difficulty) # Update speed using difficulty

# Adjust speed based on new difficulty
func handle_difficulty_increased(new_difficulty: int):
	var new_speed = speed + 0.125 * new_difficulty # Increase speed by 0.125
	speed = clamp(new_speed, speed , 3) # Limit max speed to 3

# Returns the current prompt string
func get_prompt() -> String:
	return prompt_text

# Highlights typed letters (blue), current letter (green), and remaining (red)
func set_next_character(next_character_index: int):
	var blue_text = get_bbcode_color_tag(blue) + prompt_text.substr(0, next_character_index) + get_bbcode_end_color_tag()
	var green_text = get_bbcode_color_tag(green) + prompt_text.substr(next_character_index, 1) + get_bbcode_end_color_tag()
	var red_text = ""
	
	if next_character_index != prompt_text.length(): # If not finished
		red_text = get_bbcode_color_tag(red) + prompt_text.substr(next_character_index + 1 , prompt_text.length() - next_character_index + 1 ) + get_bbcode_end_color_tag() # Remaining letters
		
	prompt.parse_bbcode(set_center_tags(blue_text + green_text + red_text)) # Show coloured word
	
# Adds center tags around the word
func set_center_tags(string_to_center: String):
	return "[center]" + string_to_center + "[/center]"
	
# Returns a BBCode tag to start coloring text
func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"
	
# Returns the BBCode end tag for color	
func get_bbcode_end_color_tag() -> String:
	return "[/color]"
	
