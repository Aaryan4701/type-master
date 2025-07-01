extends Node

# List of all the words the enemies could obtain
var words = [
	"apple", "train", "print", "house", "light",
	"debug", "chair", "mouse", "input", "water",
	"sky", "tree", "class", "game", "clock",
	"music", "float", "book", "plant", "code",
	"glass", "while", "milk", "pen", "cloud",
	"sun", "file", "list", "note", "rain",
	"lamp", "rope", "loop", "hat", "index",
	"bag", "map", "juice", "range", "door",
	"Aaryan"
]

#List of the possible special characters 
var special_characters = [
	".",
	",",
	"?",
]

# Returns a chosen word + a random special character
func get_prompt() -> String:
	var word_index = randi() % words.size() # Pick random word index
	var special_index = randi() % special_characters.size()  # Pick random special char index

	var word = words[word_index]  # Get word from list
	var special_character = special_characters[special_index] # Get special character
	var actual_word = word.substr(0,1).to_upper() + word.substr(1).to_lower() # Capitalize first letter (not used)
	
	return word + special_character # Return word with special character
	
