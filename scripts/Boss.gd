extends KinematicBody2D

var pre_bullet = preload("res://scenes/enemy_bullet.tscn")
var pre_laser = preload("res://scenes/enemy_laser.tscn")
var pre_missile = preload("res://scenes/missile.tscn")

var hp = 400 setget hp_change

enum {alive,dead}
var status = alive

func _process(delta):
	die()

func anim1():
	$anim.play("event1")
	yield($anim,"animation_finished")

func anim2():
	$anim.play("event2")
	yield($anim,"animation_finished")

func anim3():
	$anim.play("event3")
	yield($anim,"animation_finished")

func gun1():
	var ammo 
	ammo = pre_laser.instance()
	ammo.global_position = $gun1/gm1.global_position
	ammo.global_rotation = + PI/2
	ammo.dir = Vector2(cos(global_rotation + PI/2 ),sin(global_rotation - PI/4)).normalized()
	get_parent().add_child(ammo)
	
func gun2():
	var ammo 
	ammo = pre_laser.instance()
	ammo.global_position = $gun1/gm2.global_position
	ammo.global_rotation = + PI/2
	ammo.dir = Vector2(cos(global_rotation + PI/2 ),sin(global_rotation - PI/4)).normalized()
	get_parent().add_child(ammo)

func mg1():
	var ammo 
	ammo = pre_bullet.instance()
	ammo.global_position = $mgs/mm1.global_position
	ammo.global_rotation = + PI/2
	ammo.dir = Vector2(cos(global_rotation + PI/2 ),sin(global_rotation - PI/4)).normalized()
	get_parent().add_child(ammo)
	
func mg2():
	var ammo 
	ammo = pre_bullet.instance()
	ammo.global_position = $mgs/mm2.global_position
	ammo.global_rotation = + PI/2
	ammo.dir = Vector2(cos(global_rotation + PI/2 ),sin(global_rotation - PI/4)).normalized()
	get_parent().add_child(ammo)

func cannon():
	var ammo 
	ammo = pre_missile.instance()
	ammo.global_position = $cannon/cm1.global_position
	ammo.global_rotation = + PI/2
	get_parent().add_child(ammo)


func hp_change(val):
	hp -= val


func die():
	if hp <= 0 and status == alive:
		PLAYER.money += 100
		hp = 0
		status = dead
		if get_parent().has_method("dead"):
			get_parent().dead()
		$anim2.play("event")
		yield($anim2,"animation_finished")
		queue_free()
