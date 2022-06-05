extends Node


func _ready():
	$music.play()
	$anim.play("event")
	yield($anim,"animation_finished")
	


func _on_play_pressed():
	$anim.play("event2")
	yield($anim,"animation_finished")
	get_tree().change_scene("res://scenes/Lobby.tscn")
