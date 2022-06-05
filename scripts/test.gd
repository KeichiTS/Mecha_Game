extends Node2D


var wave_number := 1
var total_robots := 0
var pw_wave = 5
var enemy = preload("res://scenes/enemy_mecha.tscn")
var turret = preload("res://scenes/turret_enemy.tscn")

signal wave 

func _ready():
	randomize()
	$Player.trans2()
	total_robots = wave_number
	

	

func _on_Timer_timeout():
	var new_enemy = enemy.instance()
	new_enemy.connect("died",self,"on_robot_death")
	new_enemy.left_gun = randi() % 3
	new_enemy.hp_change(-100*(wave_number%5))
	new_enemy.vel+=wave_number/10
	add_child(new_enemy)
	new_enemy.global_position = $MobSpawner.global_position - Vector2(150,150) + Vector2(300,300)*(randf())
	
	if wave_number%5 == 0:
		var new_turret = turret.instance()
		add_child(new_turret)
		new_turret.hp_change(-10*(wave_number%10))
		new_turret.global_position = $MobSpawner.global_position - Vector2(150,150) + Vector2(300,300)*(randf())
	
	wave_number+=1
	total_robots+=1
	emit_signal("wave")
		
func on_robot_death():
	if total_robots > 0:
		total_robots-=1
		PLAYER.money+=50
	
#### for nom permanent power up. We can move all bellow to a scene
### for obvious reasons, money is permanent
var powerups = ["life","speed","evo points"]


func _on_test_wave():
	if wave_number%pw_wave == 0:
		get_tree().paused = true
		powerups.shuffle()
		$PW/PowerUp/ColorRect/CenterContainer/VBoxContainer/HBoxContainer/Pw1.text = powerups[0]
		$PW/PowerUp/ColorRect/CenterContainer/VBoxContainer/HBoxContainer/Pw2.text = powerups[1]
		$PW/PowerUp.popup_centered()
	if wave_number%10 == 0 and $Timer.wait_time > 1 and wave_number > 1:
		$Timer.wait_time*=.9
		
	

func apply_pw(powerup):
	match powerup:
		"life":
			$Player.damage(-20*(1 + wave_number%5))
		"speed":
			$Player.max_speed += 100
		"evo points":
			PLAYER.money+= 100*wave_number	

func _on_Pw1_pressed():
	apply_pw(powerups[0])
	get_tree().paused = false
	$PW/PowerUp.hide()


func _on_Pw2_pressed():
	apply_pw(powerups[1])
	get_tree().paused = false
	$PW/PowerUp.hide()
