extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var win = ModalWindowManager.create('Stay tuned for more levels.', 'You won!')
		await win.wait_to_close()
		get_tree().quit()
