extends Node2D

func transition_1():
	$anim.play("event")
	yield($anim,"animation_finished")
	
func transition_2():
	$anim.play("event2")
	yield($anim,"animation_finished")
	
