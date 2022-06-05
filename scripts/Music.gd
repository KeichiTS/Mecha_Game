extends AudioStreamPlayer2D

#there has to be an easier way
onready var bg1 = preload("res://music/Mars.wav")
onready var bg2 = preload("res://music/Mercury.wav")
onready var bg3 = preload("res://music/Venus.wav")



func _ready():
	var music = [bg1, bg2, bg3]
	randomize()
	music.shuffle()
	stream = music[0]
	play()
	print(music)
