extends Area2D

var rot_vel = PI
export var vel = 60
onready var target = get_parent().get_node("Player")

func _ready():
	pass # Replace with function body.

func _process(delta):
	if target:
		var angle = get_angle_to(target.global_position)
		if abs(angle) > .01 :
			rotation += rot_vel * delta * sign(angle)
		translate(Vector2(cos(rotation), sin(rotation)).normalized() * vel * delta)


func explode():
		$anim.play("event")
		yield($anim, "animation_finished")
		queue_free()

func _on_missile_body_entered(body):
	if body.name == "Player":
		explode()

func _on_explode_time_timeout():
	explode()
