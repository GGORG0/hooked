extends Sprite2D


var angle: float
var is_aiming := false


func _process(_delta: float) -> void:
	var horizontal = Input.get_axis("aim_grapple_left", "aim_grapple_right")
	var vertical = Input.get_axis("aim_grapple_up", "aim_grapple_down")

	var target = Vector2(horizontal, vertical)

	if target:
		angle = target.angle()

		self.rotation = angle - Vector2.UP.angle()
		self.show()
		is_aiming = true
	else:
		self.hide()
		is_aiming = false
