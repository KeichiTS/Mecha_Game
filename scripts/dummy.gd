extends StaticBody2D

var hp = 50 setget hp_change
var initial_hp = hp

func _ready():
	pass
	
func _process(delta):
	if hp <= 0:
		$anim.play("event")
		yield($anim,"animation_finished")
		queue_free()



func hp_change(val):
	hp -= val
	if hp != 0:
		$dummy_hp.rect_scale.x -= float(val)/float(initial_hp)
	else:
		$dummy_hp.rect_scale.x = 0
