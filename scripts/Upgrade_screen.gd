extends Control

func _ready():
	pass 

func _process(delta):
	$Money.text = "Money: " + str(PLAYER.money)
	sold()


func sold():
	if PLAYER.auto_left:
		$BG2/CenterContainer/HBoxContainer/VBoxContainer/Auto_Left.disabled = true
	if PLAYER.auto_right:
		$BG2/CenterContainer/HBoxContainer/VBoxContainer/Auto_right.disabled = true
	

func _on_HP_pressed():
	if PLAYER.money >= 50:
		PLAYER.money -= 50
		PLAYER.life_addiction += 10


func _on_Bullet_pressed():
	if PLAYER.money >= 50:
		PLAYER.bullet_multiplier += 0.2
		PLAYER.money -= 50


func _on_Laser_pressed():
	if PLAYER.money >= 50:
		PLAYER.laser_multiplier += 0.2
		PLAYER.money -= 50 


func _on_Cannon_pressed():
	if PLAYER.money >= 50:
		PLAYER.rocket_multiplier += 0.2
		PLAYER.money -= 50


func _on_Auto_Left_pressed():
	if PLAYER.money >= 100:
		PLAYER.auto_left = true
		PLAYER.money -= 100
		$BG2/CenterContainer/HBoxContainer/VBoxContainer/Auto_Left.disabled = true

func _on_Auto_right_pressed():
	if PLAYER.money >= 100:
		PLAYER.auto_right = true
		PLAYER.money -= 100
		$BG2/CenterContainer/HBoxContainer/VBoxContainer/Auto_right.disabled = true


func _on_Start_pressed():
	#get_tree().change_scene("res://scenes/test.tscn")
	get_tree().change_scene(PLAYER.scene)

func _on_Speed_pressed():
	if PLAYER.money >= 500:
		PLAYER.max_speed+= 5
		PLAYER.money -= 500
