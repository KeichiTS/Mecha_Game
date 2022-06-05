extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$music.play()
	$anim.play("event")
	yield($anim,"animation_finished")
	


func _on_play_pressed():
	get_tree().change_scene("res://scenes/Instruction_screen.tscn")
