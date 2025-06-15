class_name EquipableItemData extends ItemsData

enum Type { WEAPON, ARMOR, HELMET }
@export var type : Type = Type.WEAPON
@export var modifiers : Array[ EquipableItemModifier ]
@export var damage: int = 0  # Add this line
@export var defense: int = 0
