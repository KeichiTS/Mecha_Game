extends Area2D

export var vel = 400
var dir = Vector2()
export var max_distance = 300
var damage = 50

onready var initipos = self.global_position

func _ready():
	pass

func _physics_process(delta):
	translate(dir * vel * delta)
	
	if global_position.distance_to(initipos) > max_distance:
		vel = 0
		$anim.play("event")
		yield($anim,"animation_finished")
		queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("hp_change"):
		body.hp_change(damage)
	yield($anim,"animation_finished")
	queue_free()



func _on_rocket_body_entered(body):
	vel = 0 
	$anim.play("event")
	

