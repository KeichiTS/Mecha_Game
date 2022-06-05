extends Area2D

export(int,"Level1", "Level2", "Level3", "Boss_battle") var level = 0
var status = 0

func _on_Portal_body_entered(body):
	if body.name == "Player":
		get_parent().get_node("Player").trans1()
		$timer.start()

func _on_timer_timeout():
	if status == 0: 
		status = 100
		if level == 0:
			get_tree().change_scene("res://scenes/Level1.tscn")
		elif level == 1:
			get_tree().change_scene("res://scenes/Level2.tscn")
		elif level == 2:
			get_tree().change_scene("res://scenes/Level3.tscn")
		elif level == 3:
			get_tree().change_scene("res://scenes/Boss_battle.tscn")
