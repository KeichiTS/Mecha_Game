extends Control

func _ready():
	$Transition/anim.play("event2")

func _open_upgrades():
	get_tree().change_scene("res://scenes/Upgrade_screen.tscn")


func _on_Bald_pressed():
	#get_tree().change_scene("res://scenes/Upgrade_screen.tscn")
	$AnimationPlayer.play("Options")


func _on_History_pressed():
	$Transition/anim.play("event")
	yield($Transition/anim,"animation_finished")
	get_tree().change_scene("res://scenes/Upgrade_screen.tscn")
	PLAYER.scene = "res://scenes/Level1.tscn"


func _on_Infinity_pressed():
	$Transition/anim.play("event")
	yield($Transition/anim,"animation_finished")
	get_tree().change_scene("res://scenes/Upgrade_screen.tscn")
	PLAYER.scene = "res://scenes/test_wave.tscn"
