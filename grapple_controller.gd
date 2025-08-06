extends Node2D


const REST_LENGTH = 1.5
const STIFFNESS = 12.5
const DAMPING = 1.5


@onready var rays := $RayCasts
@onready var player := get_parent()
@onready var rope := $Rope
@onready var aim_hint := $AimHint


var launched := false
var target: Vector2


func _process(delta: float) -> void:
	if aim_hint.is_aiming:
		rays.rotation = aim_hint.angle
	else:
		rays.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("grapple"):
		launch()
	elif Input.is_action_just_released("grapple"):
		retract()

	if launched:
		handle_grapple(delta)


func cast_ray():
	for ray: RayCast2D in rays.get_children():
		ray.enabled = true
		ray.force_raycast_update()

		var striped_target = ray.get_collision_point()
		if not ray.is_colliding():
			ray.enabled = false
			continue

		ray.set_collision_mask_value(1, true)
		ray.force_raycast_update()

		var ground_target = ray.get_collision_point()
		if striped_target != ground_target:
			ray.set_collision_mask_value(1, false)
			ray.enabled = false
			continue

		var point = ray.get_collision_point()

		ray.set_collision_mask_value(1, false)
		ray.enabled = false

		return point

	return null


func launch() -> void:
	var point = cast_ray()
	if point == null:
		return

	launched = true
	target = point
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
