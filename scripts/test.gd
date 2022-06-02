extends Node2D


var wave_number := 5
var total_robots := 0
var enemy = preload("res://scenes/enemy_mecha.tscn")


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
		
func on_robot_death():
	if total_robots > 0:
		total_robots-=1
		print(total_robots)
	if total_robots <= 0:
		PLAYER.money += 5*100
		get_tree().change_scene("res://scenes/Upgrade_screen.tscn")
	
