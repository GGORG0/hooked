extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var time = Time.get_ticks_msec()
		var minutes = int(time / 60000)
		var seconds = int((time % 60000) / 1000)
		var milliseconds = int((time % 1000) / 10)
		var time_str = '%02d:%02d.%02d' % [minutes, seconds, milliseconds]
		var win = ModalWindowManager.create('It took you %s!\nStay tuned for more levels.' % time_str, 'You won!')
		await win.wait_to_close()
		get_tree().quit()
