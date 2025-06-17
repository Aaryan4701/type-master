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



@onready var line1 = $CanvasLayer/line_labels/Line1
@onready var line2 = $CanvasLayer/line_labels/Line2
@onready var line3 = $CanvasLayer/line_labels/Line3

func _ready() -> void:
	randomize()
	display_random_text()


# Helper function to join an Array of strings with a separator
func join_strings(arr: Array, separator: String = " ") -> String:
	var result = ""
	for i in range(arr.size()):
		result += arr[i]
		if i < arr.size() - 1:
			result += separator
	return result
	

const MAX_CHARS_PER_LINE = 70  # tweak this based on your label width/font size

func display_random_text():
	var text = sample_texts[randi() % sample_texts.size()]
	var words = text.split(" ")

	var lines = []
	var current_line = ""

	for word in words:
		# Check if adding the new word exceeds the max char limit
		if current_line.length() + word.length() + 1 <= MAX_CHARS_PER_LINE:
			if current_line == "":
				current_line = word
			else:
				current_line += " " + word
		else:
			lines.append(current_line)
			current_line = word

		# Stop if we've already filled 3 lines
		if lines.size() == 3:
			break

	# Add last line if it fits and we still have room
	if lines.size() < 3 and current_line != "":
		lines.append(current_line)

	# Pad with empty lines if less than 3
	while lines.size() < 3:
		lines.append("")

	# Set the line labels
	line1.text = lines[0]
	line2.text = lines[1]
	line3.text = lines[2]
