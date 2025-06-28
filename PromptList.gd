extends Node

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


var special_characters = [
	".",
	",",
	"?",
]

func get_prompt() -> String:
	var word_index = randi() % words.size()
	var special_index = randi() % special_characters.size()

	var word = words[word_index]
	var special_character = special_characters[special_index]
	var actual_word = word.substr(0,1).to_upper() + word.substr(1).to_lower()
	
	return word + special_character
	
