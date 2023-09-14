extends KinematicBody2D

export(int) var player = 1
var speed = 800
var velocity = Vector2()
var collider

func _physics_process(_delta):
	handle_input()

func handle_input():
	velocity = Vector2()
	if Input.is_action_pressed("p%d_up" % player):
		velocity.y -= speed
	if Input.is_action_pressed("p%d_down" % player):
		velocity.y += speed
	var _res = move_and_slide(velocity)
