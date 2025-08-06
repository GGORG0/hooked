extends Node2D


const REST_LENGTH = 2.0
const STIFFNESS = 10.0
const DAMPING = 1.5


@onready var ray := $RayCast2D
@onready var player := get_parent()
@onready var rope := $Rope


var launched := false
var target: Vector2


func _process(delta: float) -> void:
	ray.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("grapple"):
		launch()
	elif Input.is_action_just_released("grapple"):
		retract()

	if launched:
		handle_grapple(delta)


func launch() -> void:
	if ray.is_colliding():
		launched = true
		target = ray.get_collision_point()
		rope.show()


func retract() -> void:
	launched = false
	rope.hide()


func handle_grapple(delta: float) -> void:
	var player_pos = player.global_position
	var target_dir = player_pos.direction_to(target)
	var target_dist = player_pos.distance_to(target)

	var displacement = target_dist - REST_LENGTH

	if displacement:
		var spring_force_magnitude = displacement * STIFFNESS
		var spring_force = target_dir * spring_force_magnitude

		var vel_dot = player.velocity.dot(target_dir)
		var damping_force = target_dir * vel_dot * -DAMPING

		var force = spring_force + damping_force

		player.velocity += force * delta

	update_rope()


func update_rope() -> void:
	rope.set_point_position(1, to_local(target))
