extends Node

# Guardian Manager - Handles sequential spawning of guardians at random boss positions
var guardians: Array[Guardian] = []
var current_guardian_index: int = 0
var all_guardians_spawned: bool = false
var boss: DarkWizardBoss = null

# Boss position targets from the DarkWizardBoss PositionTargets
var boss_positions: Array[Vector2] = [
	Vector2(416, 614),  # Bottom center
	Vector2(575, 524),  # Right center  
	Vector2(416, 442),  # Top center
	Vector2(258, 524)   # Left center
]

func _ready():
	# Wait a frame to ensure all children are ready
	await get_tree().process_frame
	
	# Get reference to the boss
	boss = get_node("../DarkWizardBoss")
	
	# Collect all guardian nodes
	for child in get_children():
		if child is Guardian:
			guardians.append(child)
			# Connect to each guardian's destroyed signal
			child.guardian_destroyed.connect(_on_guardian_destroyed)
			# Hide all guardians initially
			child.visible = false
	
	# Start with the first guardian and spawn the boss
	if guardians.size() > 0:
		spawn_boss_and_first_guardian()

func spawn_next_guardian():
	if current_guardian_index >= guardians.size():
		all_guardians_spawned = true
		print("All guardians have been spawned!")
		return
	
	var guardian = guardians[current_guardian_index]
	
	# Set guardian to a random boss position
	var random_position = boss_positions[randi() % boss_positions.size()]
	guardian.global_position = random_position
	
	# Make guardian visible and active
	guardian.visible = true
	guardian.set_process(true)
	guardian.set_physics_process(true)
	
	# Enable collision detection
	if guardian.has_method("set_collision_layer"):
		guardian.collision_layer = 1
		guardian.collision_mask = 1
	
	print("Guardian ", current_guardian_index + 1, " spawned at position: ", random_position)

func _on_guardian_destroyed(hurt_box: HurtBox):
	print("Guardian ", current_guardian_index + 1, " destroyed!")
	
	# Damage the boss by 2 HP for each guardian killed
	if boss and boss.has_method("take_guardian_damage"):
		boss.take_guardian_damage(2)
		print("Boss health reduced by 2!")
	
	# Move to next guardian
	current_guardian_index += 1
	
	# Spawn the next guardian after a short delay
	if current_guardian_index < guardians.size():
		await get_tree().create_timer(1.0).timeout  # 1 second delay
		spawn_next_guardian()
	else:
		print("All guardians defeated!")
		all_guardians_spawned = true
		# Kill the boss when all guardians are dead
		kill_boss()

func spawn_boss_and_first_guardian():
	if boss:
		print("Spawning Dark Wizard Boss and first Guardian!")
		# Make the boss visible and active
		boss.visible = true
		boss.set_process(true)
		boss.set_physics_process(true)
		
		# Wait a moment then spawn first guardian
		await get_tree().create_timer(1.0).timeout
		spawn_next_guardian()
	else:
		print("Error: Could not find Dark Wizard Boss!")

func kill_boss():
	if boss and boss.has_method("die_from_guardians"):
		print("Boss dies as all guardians are defeated!")
		boss.die_from_guardians()
	else:
		print("Error: Could not kill boss!") 