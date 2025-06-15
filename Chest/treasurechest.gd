@tool
class_name TreasureChest extends Node

@export var item_data : ItemsData : set = _set_item_data
@export var quantity : int = 1 : set = _set_quantity

var is_open : bool = false

var dropped_item: ItemsData = null

@onready var sprite: Sprite2D = $ItemSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $Area2D


# Item drop pool
var item_pool = [
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s1.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s2.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s3.tres"), "weight": 30},
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s4.tres"), "weight": 30},
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s5.tres"), "weight": 20},
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s6.tres"), "weight": 20},
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s7.tres"), "weight": 10},
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s8.tres"), "weight": 10},
    {"item": preload("res://items/sprites/Weapon_tres/Sword/w_s9.tres"), "weight": 1},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r1.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r2.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r3.tres"), "weight": 30},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r4.tres"), "weight": 30},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r5.tres"), "weight": 20},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r6.tres"), "weight": 20},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r7.tres"), "weight": 10},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r8.tres"), "weight": 10},
    {"item": preload("res://items/sprites/Weapon_tres/Rapier/w_r9.tres"), "weight": 1},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g1.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g2.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g3.tres"), "weight": 30},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g4.tres"), "weight": 30},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g5.tres"), "weight": 20},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g6.tres"), "weight": 20},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g7.tres"), "weight": 10},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g8.tres"), "weight": 10},
    {"item": preload("res://items/sprites/Weapon_tres/Greatsword/w_g9.tres"), "weight": 1},
    {"item": preload("res://items/sprites/Armor_tres/a_a1.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Armor_tres/a_a2.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Armor_tres/a_a3.tres"), "weight": 40},
    {"item": preload("res://items/sprites/Armor_tres/a_a4.tres"), "weight": 30},
    {"item": preload("res://items/sprites/Armor_tres/a_a5.tres"), "weight": 20},
    {"item": preload("res://items/sprites/Armor_tres/a_a6.tres"), "weight": 1},
    {"item": preload("res://items/sprites/Armor_tres/a_h1.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Armor_tres/a_h2.tres"), "weight": 50},
    {"item": preload("res://items/sprites/Armor_tres/a_h3.tres"), "weight": 40},
    {"item": preload("res://items/sprites/Armor_tres/a_h4.tres"), "weight": 30},
    {"item": preload("res://items/sprites/Armor_tres/a_h5.tres"), "weight": 20},
    {"item": preload("res://items/sprites/Armor_tres/a_h6.tres"), "weight": 1},
]

func _ready() -> void:
    _update_texture()

    if Engine.is_editor_hint():
        return

    interact_area.area_entered.connect(_on_area_enter)
    interact_area.area_exited.connect(_on_area_exit)

    randomize()
    dropped_item = get_weighted_random_item()

func _update_texture() -> void:
    if dropped_item and sprite:
        sprite.texture = dropped_item.texture
    elif item_data and sprite:
        sprite.texture = item_data.texture

func get_weighted_random_item() -> ItemsData:
    var total = 0
    for entry in item_pool:
        total += entry["weight"]

    var roll = randi() % total
    var current = 0

    for entry in item_pool:
        current += entry["weight"]
        if roll < current:
            return entry["item"]

    return null


func player_interact() -> void:
    if is_open:
        return

    is_open = true
    animation_player.play("opened_chest")

    if dropped_item:
        PlayerManager.INVENTORY_DATA.add_item(dropped_item, quantity)
        print("You received: %s" % dropped_item.name)
    elif item_data:
        PlayerManager.INVENTORY_DATA.add_item(item_data, quantity)
        print("You received: %s" % item_data.name)
    else:
        printerr("No items in chest!")
        push_error("No Items in Chest! Chest Name: %s" % name)


func _on_area_enter(_a: Area2D) -> void:
    PlayerManager.interact_pressed.connect(player_interact)

func _on_area_exit(_a: Area2D) -> void:
    PlayerManager.interact_pressed.disconnect(player_interact)

func _set_item_data(value: ItemsData) -> void:
    item_data = value

func _set_quantity(value: int) -> void:
    quantity = value
