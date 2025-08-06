extends Sprite2D


@onready var grapple_controller := get_parent()


var angle: float
var is_aiming := false


func _process(_delta: float) -> void:
	if Input.is_action_pressed("grapple"):
		self.hide()
		is_aiming = false
		return

	var horizontal = Input.get_axis("aim_grapple_left", "aim_grapple_right")
	var vertical = Input.get_axis("aim_grapple_up", "aim_grapple_down")

	var target = Vector2(horizontal, vertical)

	if target:
		angle = target.angle()
		self.rotation = angle - Vector2.UP.angle()

		var point = grapple_controller.cast_ray()
		if point:
			self.texture = preload("res://art/grapple_aim_hint_l_good.ase_layer_tex")
		else:
			self.texture = preload("res://art/grapple_aim_hint_l_bad.ase_layer_tex")

		self.show()
		is_aiming = true
	else:
		self.hide()
		is_aiming = false
