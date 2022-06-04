tool
extends Node2D


export (float,10,1000) var radius = 10 setget set_radius
export (float,10,3000) var sensor_radius = 500
export (Color) var color = Color(0,6,0,.5) setget set_color
export (Color) var Mecha_Color = Color(0,6,0,.5)
export (Color) var enemy_Color = Color(0,6,0,.5)
onready var tank = get_tree().get_root().find_node("Player",true,false)

onready var rate = radius / sensor_radius



func _draw():
	#draw_circle(Vector2(), radius, color)
	draw_rect(Rect2(Vector2(0, 0), Vector2(radius, radius)), color)
	
	if !Engine.editor_hint:
	#	draw_circle(Vector2(), 3, Color(1,1,0,1))
		draw_circle(Vector2(radius,radius)/2, 1, Mecha_Color)
		for re in get_tree().get_nodes_in_group("radar"):
			var angle = (tank.global_position - re.global_position).angle()
			var distance = tank.global_position.distance_to(re.global_position)
			if distance < sensor_radius:
				#draw_circle((Vector2(cos(angle),sin(angle)))* distance * rate * -1, 2, Color(1,1,1,1))
				draw_circle(Vector2(radius,radius)/2 - Vector2(cos(angle),sin(angle))*distance*rate/2 , 1, enemy_Color)
	
	else:	
		print("tank not defined")
	 


func set_radius(val):
	radius = val
	if Engine.editor_hint:
		update()

func set_color(val):
	color = val
	if Engine.editor_hint:
		update()

func _on_Timer_timeout():
	update()# Replace with function body.
	
