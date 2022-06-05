extends Node

enum {to_left,to_right,stay, dead}
var status = to_left
var speed = 50

enum {idle, laser, bullet, cannon}
var ammo_status = idle

var count = 0

func _ready():
	$Player.trans2()
	
func _process(delta):
	if has_node("Boss"):
		$CanvasLayer/Boss_HP.text = "Boss HP: " + str($Boss.hp)
		if status == to_left:
			$Boss.global_position.x -= speed * delta
			if $Boss.global_position.x <= 0:
				status = to_right
				
		elif status == to_right:
			$Boss.global_position.x += speed * delta
			if $Boss.global_position.x >= 256:
				status = to_left


func _on_atack_timer_timeout():
	if ammo_status == idle:
		var ammo = randi()%3
		if ammo == 0: 
			ammo_status = laser
			$laser_timer.start()
		elif ammo == 1:
			ammo_status = bullet
			$bullet_timer.start()
		elif ammo == 2:
			ammo_status = cannon
			$cannon_timer.start()



func _on_laser_timer_timeout():
	if ammo_status == laser and count < 60 and has_node("Boss") and status != dead:
		count += 1
		$Boss.anim1()
		$laser_timer.start()
	elif count == 60 and ammo_status == laser and has_node("Boss") and status != dead:
		ammo_status = idle
		count = 0

func _on_bullet_timer_timeout():
	if ammo_status == bullet and count < 30 and has_node("Boss") and status != dead:
		count += 1
		$Boss.anim2()
		$bullet_timer.start()
	elif count == 30 and ammo_status == bullet and has_node("Boss") and status != dead :
		ammo_status = idle
		count == 0


func _on_cannon_timer_timeout():
	if ammo_status == cannon and count < 5 and has_node("Boss") and status != dead:
		count += 1
		$Boss.anim3()
		$cannon_timer.start()
	elif count == 5 and ammo_status == cannon and has_node("Boss") and status != dead:
		ammo_status = idle
		count == 0


func dead():
	status = dead 
	$CanvasLayer/Transition/anim.play("event")
	yield($CanvasLayer/Transition/anim,"animation_finished")
	get_tree().change_scene("res://scenes/End.tscn")
