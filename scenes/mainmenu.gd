extends Control


func _on_quit_button_up():
	print("bye bye")
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()


func _on_lvl_select_button_up():
	pass # Replace with function body.
