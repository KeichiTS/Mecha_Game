extends CanvasLayer


func _unhandled_input(event):
	if event.is_action_pressed("pause") and !$Popup.visible:
		get_tree().paused = true
		$Popup.popup_centered()

func exit_popup():
	get_tree().paused = false
	$Popup.hide()

func _on_Return_pressed():
	exit_popup()

func _on_Restart_pressed():
	exit_popup()
	get_tree().reload_current_scene()


func _on_Lobby_pressed():
	exit_popup()
	get_tree().change_scene("res://scenes/Lobby.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Save_pressed():
	exit_popup()
