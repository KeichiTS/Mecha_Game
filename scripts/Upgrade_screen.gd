extends Control

enum{ready,not_ready}
var status = ready 

func _ready():
	$Transition.transition_2()

func _process(delta):
	$Money.text = "Evo Points: " + str(PLAYER.money)
	sold()


func sold():
	if PLAYER.auto_left:
		$BG2/CenterContainer/HBoxContainer/VBoxContainer/Auto_Left.disabled = true
	if PLAYER.auto_right:
		$BG2/CenterContainer/HBoxContainer/VBoxContainer/Auto_right.disabled = true
	

func _on_HP_pressed():
	if PLAYER.money >= 50 and status == ready:
		PLAYER.money -= 50
		PLAYER.life_addiction += 10


func _on_Bullet_pressed():
	if PLAYER.money >= 50 and status == ready:
		PLAYER.bullet_multiplier += 0.2
		PLAYER.money -= 50


func _on_Laser_pressed():
	if PLAYER.money >= 50 and status == ready:
		PLAYER.laser_multiplier += 0.2
		PLAYER.money -= 50 


func _on_Cannon_pressed():
	if PLAYER.money >= 50 and status == ready:
		PLAYER.rocket_multiplier += 0.2
		PLAYER.money -= 50


func _on_Auto_Left_pressed():
	if PLAYER.money >= 500 and status == ready:
		PLAYER.auto_left = true
		PLAYER.money -= 500
		$BG2/CenterContainer/HBoxContainer/VBoxContainer/Auto_Left.disabled = true

func _on_Auto_right_pressed():
	if PLAYER.money >= 500 and status == ready:
		PLAYER.auto_right = true
		PLAYER.money -= 500
		$BG2/CenterContainer/HBoxContainer/VBoxContainer/Auto_right.disabled = true


func _on_Start_pressed():
	#get_tree().change_scene("res://scenes/test.tscn")
	if status == ready:
		status = not_ready
		$Transition/anim.play("event")
		yield($Transition/anim,"animation_finished")
		get_tree().change_scene(PLAYER.scene)

func _on_Speed_pressed():
	if PLAYER.money >= 100:
		PLAYER.max_speed+= 5
		PLAYER.money -= 100


func _on_Back_pressed():
	if status == ready:
		status = not_ready
		$Transition/anim.play("event")
		yield($Transition/anim,"animation_finished")
		get_tree().change_scene("res://scenes/Lobby.tscn")
