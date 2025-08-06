extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -600.0
const ACCELERATION = 2.0
const DECELERATION = 6.0


@onready var grapple_controller := $GrappleController


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and (is_on_floor() or grapple_controller.launched):
		if not is_on_floor():
			grapple_controller.retract()

		velocity.y += JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = lerpf(velocity.x, direction * SPEED, ACCELERATION * delta)

		$AnimatedSprite2D.flip_h = direction < 0
		$AnimatedSprite2D.play("walk")
	else:
		velocity.x = lerpf(velocity.x, 0, DECELERATION * delta)

		$AnimatedSprite2D.play("idle")

	move_and_slide()
