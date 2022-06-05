extends StaticBody2D

enum {activated, not_activated}
var status = not_activated

func _on_area_body_entered(body):
	if body.name == "Player" and status == not_activated:
		status = activated
		$anim.play("event")
