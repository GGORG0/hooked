class_name NoGrappleArea
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.grapple_controller.no_grapple_areas.append(self)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.grapple_controller.no_grapple_areas.erase(self)
