extends StaticBody2D

var rot_vel = PI
export var vel = 50
onready var target = get_parent().get_node("Player")
var hp = 50 setget hp_change
var initial_hp = hp


var pre_missile = preload("res://scenes/missile.tscn")

var left_gun_ready = true


func _ready():
	pass

func _process(delta):
	move(delta)
	die()
	shoot_left()

func move(delta):
	if target:
		var angle = get_angle_to(target.global_position)
		if abs(angle) > .03 :
			rotation += rot_vel * delta * sign(angle)
		

func die():
	if hp <= 0:
		$anim.play("event")
		yield($anim,"animation_finished")
		queue_free()

func shoot_left():
	if left_gun_ready == true and target:
		if (target.global_position - global_position).length() < 300:
			var ammo = pre_missile.instance()
			ammo.global_position = $muzzle.global_position
			ammo.global_rotation = global_rotation
			get_parent().add_child(ammo)
			left_gun_ready = false
			$shoot_anim.play("event")
			$timer_shoot.start()


func hp_change(val):
	hp -= val
	
	


func _on_timer_shoot_timeout():
	left_gun_ready = true
