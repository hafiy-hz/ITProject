class_name EquipableItemData extends ItemsData

enum Type { WEAPON, ARMOR }
@export var type : Type = Type.WEAPON
@export var modifiers : Array[ EquipableItemModifier ]
