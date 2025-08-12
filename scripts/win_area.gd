extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var time = Time.get_ticks_msec() / 1000.0
		var time_int = Time.get_time_string_from_unix_time(time)
		var win = ModalWindowManager.create('It took you %s!\nStay tuned for more levels.' % time_int, 'You won!')
		await win.wait_to_close()
		get_tree().quit()
