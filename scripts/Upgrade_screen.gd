extends Node

func _ready():
	pass 

func _process(delta):
	$Money.text = "Money: " + str(PLAYER.money)


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

func _on_Auto_right_pressed():
	PLAYER.auto_right = true
	PLAYER.money -= 100


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/test.tscn")
