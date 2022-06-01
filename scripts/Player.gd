#A code by: KeichiTS - 05/2022

extends KinematicBody2D

const ROT_VEL = PI

var life = 100 setget damage

var max_speed = PLAYER.max_speed
var speed = 100
var acell = 0 
var timer_left


var pre_bullet = preload("res://scenes/bullet.tscn")
var pre_laser = preload("res://scenes/laser.tscn")
var pre_rocket = preload("res://scenes/rocket.tscn")

enum { laser , bullet, rocket }
var left_gun = rocket
var left_gun_ready = true
var right_gun = bullet
var right_gun_ready = true

enum { auto_shoot, manual }
var left_mode = auto_shoot
var right_mode = auto_shoot

enum {dead,alive}
var status = alive

var left_muzzle
var right_muzzle

var gun_change = false

func _ready():
	life += PLAYER.life_addiction
	
	if PLAYER.auto_left == false:
		left_mode = manual
	else:
		left_mode = auto_shoot

	if PLAYER.auto_right == false:
		right_mode = manual
	else:
		right_mode = auto_shoot
		
	guns_choose()


func _process(delta):
	if status == alive:
		move(delta)
		shoot_left()
		shoot_right()
		change_gun()

	die()
	change_life()
	
func move(val):
	var rot = 0 

	var dir = 0
	
	if Input.is_action_pressed("ui_right"):
		rot += 1
	
	elif Input.is_action_pressed("ui_left"):
		rot -= 1 
		
	if Input.is_action_pressed("ui_up"):
		dir -= 1
	
	elif Input.is_action_pressed("ui_down"):
		dir += 1

	
	if dir != 0:
		acell = lerp(acell, max_speed * dir , .1 )
		$feets.playing = true
		
	else:
		acell = lerp(acell, 0 , .15)
		$feets.playing = false
		
	move_and_slide(Vector2(cos(rotation),sin(rotation))  * acell)
	rotate(ROT_VEL * val * rot)


func shoot_left():
	if left_gun_ready == true:
		if (Input.is_action_just_pressed("shoot_l") and left_mode == manual) or left_mode == auto_shoot: 
			var ammo
			if left_gun == laser:
				ammo = pre_laser.instance()
			elif left_gun == bullet:
				ammo = pre_bullet.instance()
			elif left_gun == rocket:
				ammo = pre_rocket.instance()
			
			ammo.global_position = left_muzzle.global_position
			ammo.global_rotation = global_rotation
			ammo.dir = - Vector2(cos(global_rotation),sin(global_rotation)).normalized()
			get_parent().add_child(ammo)
			left_gun_ready = false
			$shoot_anim_left.play("event")
			$timer_left.start()

func shoot_right():
	if right_gun_ready == true:
		if (Input.is_action_just_pressed("shoot_r") and right_mode == manual) or right_mode == auto_shoot: 
			var ammo
			if right_gun == laser:
				ammo = pre_laser.instance()
			elif right_gun == bullet:
				ammo = pre_bullet.instance()
			elif right_gun == rocket:
				ammo = pre_rocket.instance()
			
			ammo.global_position = right_muzzle.global_position
			ammo.global_rotation = global_rotation
			ammo.dir = - Vector2(cos(global_rotation),sin(global_rotation)).normalized()
			get_parent().add_child(ammo)
			right_gun_ready = false
			$shoot_anim_right.play("event")
			$timer_right.start()

func guns_choose():
	if left_gun == laser:
		left_muzzle = $muzzles/left_muzzle_laser
		$left_guns/laser.show()
		$left_guns/gun.hide()
		$left_guns/missile.hide()
		$timer_left.wait_time = .4
	elif left_gun == bullet:
		left_muzzle = $muzzles/left_muzzle_gun
		$left_guns/laser.hide()
		$left_guns/gun.show()
		$left_guns/missile.hide()
		$timer_left.wait_time = .2
	elif left_gun == rocket:
		left_muzzle = $muzzles/left_muzzle_missile
		$left_guns/laser.hide()
		$left_guns/gun.hide()
		$left_guns/missile.show()
		$timer_left.wait_time = 2

	if right_gun == laser:
		right_muzzle = $muzzles/right_muzzle_laser
		$right_guns/laser.show()
		$right_guns/gun.hide()
		$right_guns/missile.hide()
		$timer_right.wait_time = .4
	elif right_gun == bullet:
		right_muzzle = $muzzles/right_muzzle_gun
		$right_guns/laser.hide()
		$right_guns/gun.show()
		$right_guns/missile.hide()
		$timer_right.wait_time = .2
	elif right_gun == rocket:
		right_muzzle = $muzzles/right_muzzle_missile
		$right_guns/laser.hide()
		$right_guns/gun.hide()
		$right_guns/missile.show()
		$timer_right.wait_time = 2

func change_gun():
	if Input.is_action_just_pressed("change_l"):
		left_gun += 1
		if left_gun >= 3:
			left_gun = 0
		gun_change = true
	if Input.is_action_just_pressed("change_r"):
		right_gun += 1
		if right_gun >= 3:
			right_gun = 0
			
		gun_change = true
		
		
	if gun_change == true:
		guns_choose()
		gun_change = false
	
func die():
	if life <= 0:
		life = 0 
		if status == alive:
			status = dead
			$dead_animation.play("event")
			yield($dead_animation,"animation_finished")
			get_tree().change_scene("res://scenes/Upgrade_screen.tscn")
		
func damage(val):
	life -= val
	
func change_life():
	$HUD/HP_Label.text = "HP: " + str(life)


func _on_timer_left_timeout():
	left_gun_ready = true

func _on_timer_right_timeout():
	right_gun_ready = true


##########

###################################################
#     ~ It ain't much, but it's honest work ~     #
###################################################
##        #####################################   #
##          #############################         #
####            ######################            #
#####            #####           #                #
#######                                         ###
#########  #                                   ####
###########                              ## #######
#########      ###               ###       ########
#########     # ###             #####       #######
########      #####             ####         ######
########       ##                ##          ######
#######               ##                    #######
#######  ##           ####            ##      #####
####### #####        ########       #######    ####
########               #####                    ###
#########                                       ###
##########                                       ##
#########                                         #
###################################################
#               ~ KeichiTS - 2022 ~               #
###################################################
