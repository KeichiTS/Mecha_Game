extends KinematicBody2D

var rot_vel = PI
export var vel = 50
onready var target = get_parent().get_node("Player")
enum {chasing , waiting}
var move_status = false
var hp = 50 setget hp_change
var initial_hp = hp

var pre_bullet = preload("res://scenes/enemy_bullet.tscn")
var pre_laser = preload("res://scenes/enemy_laser.tscn")
var pre_missile = preload("res://scenes/missile.tscn")

export(int, "laser", "bullet", "missile") var left_gun = 0 
var left_gun_ready = true


func _ready():
	if left_gun == 0:
		$guns_sprites/laser.show()
	
	elif left_gun == 1:
		$guns_sprites/gun.show()
	
	elif left_gun == 2:
		$guns_sprites/missile.show()
		$muzzle_l.position.x = 34

func _process(delta):
	move(delta)
	die()
	shoot_left()

func move(delta):
	if target:
		var angle = get_angle_to(target.global_position)
		if abs(angle) > .03 :
			rotation += rot_vel * delta * sign(angle)
		if (target.global_position - global_position).length() < 1000:
			move_status = true
			move_and_slide(Vector2(cos(rotation), sin(rotation)).normalized() * vel )
			#translate(Vector2(cos(rotation), sin(rotation)).normalized() * vel * delta)
		
		else:
			move_status = false
			
		if move_status == true:
			$feet.hide()
			$feet_walking.show()
		
		elif move_status == false:
			$feet.show()
			$feet_walking.hide()


func die():
	if hp <= 0:
		$anim.play("event")
		yield($anim,"animation_finished")
		queue_free()

func shoot_left():
	if left_gun_ready == true and target:
		if (target.global_position - global_position).length() < 100:
			var ammo
			if left_gun == 0:
				ammo = pre_laser.instance()
			elif left_gun == 1:
				ammo = pre_bullet.instance()
			elif left_gun == 2:
				ammo = pre_missile.instance()
			
			ammo.global_position = $muzzle_l.global_position
			ammo.global_rotation = global_rotation
			if left_gun != 2:
				ammo.dir = Vector2(cos(global_rotation),sin(global_rotation)).normalized()
			get_parent().add_child(ammo)
			left_gun_ready = false
			$shoot_anim.play("event")
			$timer_left.start()


func hp_change(val):
	hp -= val
	
func _on_timer_left_timeout():
	left_gun_ready = true
