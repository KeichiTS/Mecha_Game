extends StaticBody2D

enum {barrier_down,barrier_up}
var status = barrier_up

func _ready():
	pass # Replace with function body.


func _process(delta):
	if get_tree().get_nodes_in_group("enemy").size() == 0 and status == barrier_up:
		status = barrier_down
		$anim.play("event")
