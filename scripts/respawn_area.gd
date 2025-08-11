class_name RespawnArea
extends Area2D


@export var target := Vector2.ZERO


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.grapple_controller.retract()
		body.velocity = Vector2.ZERO
		body.position = target
