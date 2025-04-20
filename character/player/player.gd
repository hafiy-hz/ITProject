extends CharacterBody2D
<<<<<<< Updated upstream:player.gd

var enemy_inattack_range = false
=======
 
var enemy_in_attack_range = false
>>>>>>> Stashed changes:character/player/player.gd
var enemy_attack_cooldown = true
var health = 200
var player_alive = true

var attack_ip = false 

const speed = 100
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_player")

func _physics_process(delta):
	player_movement(delta)
<<<<<<< Updated upstream:player.gd
=======
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false # display respawn scne
		health = 0
		print("player has been kill")
		self.queue_free()
>>>>>>> Stashed changes:character/player/player.gd

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif  Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif  Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed 
		velocity.x = 0		
	elif  Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed 
		velocity.x = 0				
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()		
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_player")	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_player")
			
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_player")	
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
<<<<<<< Updated upstream:player.gd
			anim.play("back_player")		
			
=======
			if attack_ip == false:
				anim.play("back_player")			

# combat system

func player():
	pass

>>>>>>> Stashed changes:character/player/player.gd
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range =  true
		 
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
<<<<<<< Updated upstream:player.gd
		enemy_inattack_range =  false		
=======
		enemy_in_attack_range = false
	
func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 15
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack =  false
	attack_ip = false 
	
>>>>>>> Stashed changes:character/player/player.gd
