extends Area2D

var multiplier = PLAYER.bullet_multiplier

export var vel = 400
var dir = Vector2()
export var max_distance = 300
var damage = 10 * multiplier
onready var initipos = self.global_position

	
func _physics_process(delta):
	translate(dir * vel * delta)
	
	if global_position.distance_to(initipos) > max_distance:
		queue_free()


func _on_laser_body_entered(body):
	do_damage(body)


func _on_bullet_body_entered(body):
	do_damage(body)


func do_damage(val):
	if val.has_method("hp_change"):
		val.hp_change(damage)
	elif val.has_method("damage"):
		val.damage(damage)
	queue_free()

