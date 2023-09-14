extends KinematicBody2D

export var particles_default_timeout = 0.1
export var default_speed = 500
export var speed_increment = 40
export var audio_pitch_multiplier = 0.005  # Adjust this to control pitch change

var game
var particles
var particles_timeout = 0
var speed = default_speed
var y_velocity = 1
var x_velocity = 1
var audio_player: AudioStreamPlayer2D

func _physics_process(delta):
	move_ball(delta)
	handle_particles(delta)

func _reset_ball():
	position.x = 512
	position.y = 303
	speed = default_speed
	audio_player.pitch_scale = speed * audio_pitch_multiplier

func trigger_particles():
	particles_timeout = particles_default_timeout

func handle_particles(delta):
	if particles_timeout > 0:
		particles.emitting = true
	elif particles.emitting:
		particles.emitting = false
	particles_timeout -= delta

func move_ball(delta):
	var velocity = Vector2()
	velocity.x = x_velocity
	velocity.y = y_velocity

	var collision_info = move_and_collide(velocity.normalized() * speed * delta)
	
	if collision_info:
		var collider_name = collision_info.collider.name
		
		if collider_name == "Top" || collider_name == "Bottom":
			y_velocity *= -1
		elif collision_info.normal.y == 0 || collision_info.normal.x == 0:
			x_velocity *= -1
			speed += speed_increment
			trigger_particles()
			play_collision_sound()  # Play the collision sound
		else:
			y_velocity *= -1
			play_collision_sound()

func play_collision_sound():
	if audio_player:
		audio_player.pitch_scale = speed * audio_pitch_multiplier / 1.5
		audio_player.play()

func _on_Left_body_entered(_body):
	_reset_ball()

func _on_Right_body_entered(_body):
	_reset_ball()

func _ready():
	particles = get_node("CPUParticles2D")
	audio_player = $AudioStreamPlayer2D
	_reset_ball()
