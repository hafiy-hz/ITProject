class_name DarkWizardBoss extends Node2D

const ENERGY_EXPLOSION_SCENE : PackedScene = preload( "res://stage/dark_wizard/energy_explosion.tscn" )
const ENERGY_BALL_SCENE : PackedScene = preload( "res://stage/dark_wizard/energy_orb.tscn" )

@export var max_hp : int = 10
var hp : int = 10



var audio_hurt : AudioStream = preload( "res://stage/dark_wizard/audio/boss_hurt.wav" )
var audio_shoot : AudioStream = preload( "res://stage/dark_wizard/audio/boss_fireball.wav" )

var current_position : int = 0
var positions : Array[ Vector2 ]
var beam_attacks : Array[ BeamAttack ]

var damage_count : int = 0

@onready var animation_player: AnimationPlayer = $BossNode/AnimationPlayer
@onready var animation_player_damage: AnimationPlayer = $BossNode/AnimationPlayer_damage
@onready var cloak_animation_player: AnimationPlayer = $BossNode/CloakSprite/AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $BossNode/AudioStreamPlayer2D
@onready var boss_node: Node2D = $BossNode
@onready var hurt_box: HurtBox = $BossNode/HurtBox
@onready var hit_box: HitBox = $BossNode/HitBox

@onready var hand_01: Sprite2D = $BossNode/CloakSprite/Hand01
@onready var hand_02: Sprite2D = $BossNode/CloakSprite/Hand02
@onready var hand_01_up: Sprite2D = $BossNode/CloakSprite/Hand01_UP
@onready var hand_02_up: Sprite2D = $BossNode/CloakSprite/Hand02_UP
@onready var hand_01_side: Sprite2D = $BossNode/CloakSprite/Hand01_SIDE
@onready var hand_02_side: Sprite2D = $BossNode/CloakSprite/Hand02_SIDE
@onready var door_block: TileMapLayer = $"../DoorBlock"



func _ready() -> void:
    
    hp = max_hp
    PlayerHud.show_boss_health( "Dark Wizard (Sir Willie)" )
    
    
    # Connect the HitBox's 'damaged' signal to the damage_taken function
    
    hit_box.damaged.connect(damage_taken)
    
    # Disable boss's HurtBox monitoring so it doesn't damage player on contact
    hurt_box.monitoring = false
    
    for c in $PositionTargets.get_children():
        positions.append( c.global_position )
    $PositionTargets.visible = false
    
    for b in $BeamAttack.get_children():
        beam_attacks.append( b )
    
    # Give player time to get ready before boss starts attacking
    await get_tree().create_timer( 2.0 ).timeout
    teleport( 0 )
    pass



func _process( delta: float ) -> void:
    hand_01_up.position = hand_01.position
    hand_01_up.frame = hand_01.frame + 4
    
    hand_02_up.position = hand_02.position
    hand_02_up.frame = hand_02.frame + 4
    
    hand_01_side.position = hand_01.position
    hand_01_side.frame = hand_01.frame + 8 
    
    hand_02_side.position = hand_02.position
    hand_02_side.frame = hand_02.frame + 12
    pass


func teleport( _location : int ) -> void:

    animation_player.play("disappear")
    # Only disable hit boxes during the teleport animation
    enable_hit_boxes(false)
    damage_count = 0
    
    #shoot fireball
    if hp < max_hp:
        shoot_orb()
    
    await get_tree().create_timer( 5 ).timeout
    
    boss_node.global_position = positions[ _location ]
    current_position = _location
    update_animations()
    animation_player.play( "appear" )
    await animation_player.animation_finished
    # Re-enable hit boxes after appearing
    enable_hit_boxes(true)
    idle()
    
    pass


func idle() -> void:
    # Keep hit boxes enabled during idle state
    enable_hit_boxes(true)
    
    if randf() <= float(hp) / float(max_hp):
        animation_player.play( "idle" )
        await animation_player.animation_finished
    
    if damage_count < 1:
        energy_beam_attack()
        animation_player.play( "cast_spell" )
        await animation_player.animation_finished
    
    var _t : int = current_position
    while _t == current_position:
        _t = randi_range( 0, 3)
    teleport( _t )
    
    pass



func update_animations() -> void:
    boss_node.scale = Vector2( 1,1 )
    
    hand_01.visible = false
    hand_02.visible = false
    hand_01_up.visible = false
    hand_02_up.visible = false
    hand_01_side.visible = false
    hand_02_side.visible = false
    
    if current_position == 0:
        cloak_animation_player.play( "up" )
        hand_01_up.visible = true
        hand_02_up .visible = true
        
    elif current_position == 2:
        cloak_animation_player.play( "down" )
        hand_01.visible = true
        hand_02.visible = true
        
    else:
        cloak_animation_player.play( "side" )
        hand_01_side.visible = true
        hand_02_side.visible = true
        
        if current_position == 1:
            boss_node.scale = Vector2( -1,1 )
    pass


func energy_beam_attack() -> void:
    var _b : Array[ int ]
    match current_position:
        0, 2:
            if current_position == 0:
                _b.append( 0 )
                _b.append( randi_range( 1, 2 ) )
            else:
                _b.append( 2 )
                _b.append( randi_range( 0, 1 ) )
            #scale w dificulty
            if hp < 5:
                _b.append( randi_range( 3, 4 ) )
            
        1, 3:
            if current_position == 3:
                _b.append( 5 )
                _b.append( randi_range( 3, 4 ) )
            else:
                _b.append( 3 )
                _b.append( randi_range( 4, 5 ) )
            if hp < 5:
                _b.append( randi_range( 0, 2 ) )
    for b in _b:
        beam_attacks[ b ].attack()

func shoot_orb() -> void:
    var eb : Node2D = ENERGY_BALL_SCENE.instantiate()
    eb.global_position = boss_node.global_position + Vector2( 0, -34 )
    get_parent().add_child.call_deferred( eb )
    play_audio( audio_shoot )



func damage_taken( _hit_box : HitBox ) -> void:
    # Only allow damage from player
    if not _hit_box.get_parent().is_in_group("Player"):
        return
    
    # Prevent damage if already playing damage animation or no damage
    if animation_player_damage.current_animation == "damaged" or _hit_box.damage == 0:
        return
    
    # Play hurt audio
    play_audio( audio_hurt )
    
    # Use player's actual damage value instead of fixed 1 damage
    var damage_amount = _hit_box.damage
    hp = clampi( hp - damage_amount, 0, max_hp )
    damage_count += 1
    
    #update boss health bar
    PlayerHud.update_boss_health( hp, max_hp )
    
    # Play damage animation
    animation_player_damage.play( "damaged" )
    animation_player_damage.seek( 0 )
    animation_player_damage.queue( "default" )
    
    # Check if boss is defeated
    if hp < 1:
        defeat()
    
    pass


func play_audio( _a : AudioStream ) -> void:
    audio.stream = _a
    audio.play()


func defeat() -> void:
    animation_player.play("destroy")
    enable_hit_boxes(false)
    await animation_player.animation_finished

    # Save time to leaderboard
    LeaderboardManager.add_entry(Global.username, Global.speedrun_time)

    # Optionally stop player control, stop time etc.
    get_tree().paused = true

    # Transition to leaderboard screen after short delay
    await get_tree().create_timer(1.5).timeout
    get_tree().change_scene_to_file("res://path_to/LeaderboardUI.tscn")


func enable_hit_boxes( _v : bool = true ) -> void:
    hit_box.set_deferred("monitorable", _v)
    # Don't enable hurt_box monitoring - boss shouldn't damage player on contact
    # hurt_box.set_deferred("monitoring", _v)

func explosion( _p : Vector2 = Vector2.ZERO ) -> void:
    var e : Node2D = ENERGY_EXPLOSION_SCENE. instantiate()
    e.global_position = boss_node.global_position + _p
    get_parent().add_child.call_deferred( e )
    pass
