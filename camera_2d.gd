extends Camera2D


const DEAD_ZONE = 160


var is_mouse_panning := false


# Mouse panning
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var target = event.position - get_viewport().size * 0.5

		if target.length() < DEAD_ZONE:
			self.position = Vector2.ZERO
		else:
			is_mouse_panning = true

			self.position = target.normalized() * (target.length() - DEAD_ZONE) * 0.5


# Gamepad panning
func _process(_delta: float) -> void:
	var viewport_size = get_viewport().size
	var horizontal = Input.get_axis("pan_left", "pan_right")
	var vertical = Input.get_axis("pan_up", "pan_down")

	var target = Vector2(horizontal, vertical) * (viewport_size * 0.5)

	if target:
		is_mouse_panning = false
		self.position = target.normalized() * (target.length() - DEAD_ZONE) * 0.5
	elif not is_mouse_panning:
		self.position = Vector2.ZERO
