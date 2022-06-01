extends Node

func _ready():
	pass 

func _process(delta):
	$Money.text = "Money: " + str(PLAYER.money)
	sold()


func sold():
	if PLAYER.auto_left:
		$Auto_Left.disabled = true
	if PLAYER.auto_right:
		$Auto_right.disabled = true
	

func _on_HP_pressed():
	PLAYER.life_addiction += 10
	PLAYER.money -= 50


func _on_Bullet_pressed():
	PLAYER.bullet_multiplier += 0.2
	PLAYER.money -= 50


func _on_Laser_pressed():
	PLAYER.laser_multiplier += 0.2
	PLAYER.money -= 50 


func _on_Cannon_pressed():
	PLAYER.rocket_multiplier += 0.2
	PLAYER.money -= 50


func _on_Auto_Left_pressed():
	PLAYER.auto_left = true
	PLAYER.money -= 100
	$Auto_Left.disabled = true

func _on_Auto_right_pressed():
	PLAYER.auto_right = true
	PLAYER.money -= 100
	$Auto_right.disabled = true


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/test.tscn")


func _on_Speed_pressed():
	PLAYER.max_speed+= 5
	PLAYER.money -= 500
