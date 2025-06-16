extends Button
@export var hover_scale := Vector2(1.2, 1.2)  # Scale when hovered
@export var animation_speed := 6.0            # How fast to animate

var target_scale := Vector2.ONE

func _ready():
	# Connect signals in code
	self.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	self.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _process(delta):
	# Smoothly interpolate rect_scale towards target_scale
	scale = scale.lerp(target_scale, animation_speed * delta)

func _on_mouse_entered():
	target_scale = hover_scale

func _on_mouse_exited():
	target_scale = Vector2.ONE
