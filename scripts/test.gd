extends Node2D


var wave_number := 5
var total_robots := 0
var pw_wave = 2
var enemy = preload("res://scenes/enemy_mecha.tscn")

signal wave 

func _ready():
	randomize()
	
	total_robots = wave_number
	

	

func _on_Timer_timeout():
	if wave_number > 0:
		var new_enemy = enemy.instance()
		new_enemy.connect("died",self,"on_robot_death")
		new_enemy.left_gun = randi() % 3
		add_child(new_enemy)
		new_enemy.global_position = $MobSpawner.global_position
		wave_number-=1
		emit_signal("wave")
		
func on_robot_death():
	if total_robots > 0:
		total_robots-=1
		print(total_robots)
	if total_robots <= 0:
		PLAYER.money += 5*100
		get_tree().change_scene("res://scenes/Upgrade_screen.tscn")
	

#### for nom permanent power up. We can move all bellow to a scene
### for obvious reasons, money is permanent
var powerups = ["life","speed","money"]


func _on_test_wave():
	if wave_number%pw_wave == 0:
		get_tree().paused = true
		powerups.shuffle()
		$PW/PowerUp/ColorRect/CenterContainer/VBoxContainer/HBoxContainer/Pw1.text = powerups[0]
		$PW/PowerUp/ColorRect/CenterContainer/VBoxContainer/HBoxContainer/Pw2.text = powerups[1]
		$PW/PowerUp.popup_centered()

func apply_pw(powerup):
	match powerup:
		"life":
			$Player.damage(-20)
		"speed":
			$Player.max_speed += 100
		"money":
			PLAYER.money+= 10000	

func _on_Pw1_pressed():
	apply_pw(powerups[0])
	get_tree().paused = false
	$PW/PowerUp.hide()


func _on_Pw2_pressed():
	apply_pw(powerups[1])
	get_tree().paused = false
	$PW/PowerUp.hide()
