class_name Player extends CharacterBody2D



signal direction_changed(new_direction : Vector2)
signal interact_pressed

const speed = 100
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)

#function to control player
func player_movement(delta):
	var previous_dir = current_dir
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	
	move_and_slide()
	
	if current_dir != previous_dir:
		var direction_vector = Vector2.ZERO
		match current_dir:
			"right":
				direction_vector = Vector2.RIGHT
			"left":
				direction_vector = Vector2.LEFT
			"up":
				direction_vector = Vector2.UP
			"down":
				direction_vector = Vector2.DOWN
		emit_signal("direction_changed", direction_vector)


# function to play animation for movement
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
