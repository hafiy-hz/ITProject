extends Node

const EquipableType = EquipableItemData.Type

var equipped_items := {
    EquipableType.WEAPON: null,
    EquipableType.ARMOR: null,
    EquipableType.HELMET: null
}

func equip(item: EquipableItemData) -> void:
    if item.type in equipped_items:
        equipped_items[item.type] = item
        print("Equipped %s in slot %s" % [item.name, item.type])
        
        match item.type:
            EquipableItemData.Type.WEAPON:
                PlayerManager.set_weapon_damage(item.damage)

            EquipableItemData.Type.ARMOR, EquipableItemData.Type.HELMET:
                var armor_defense = 0
                var helmet_defense = 0

                var armor = equipped_items[EquipableItemData.Type.ARMOR]
                var helmet = equipped_items[EquipableItemData.Type.HELMET]

                if armor:
                    armor_defense = armor.defense
                if helmet:
                    helmet_defense = helmet.defense

                PlayerManager.set_defense(armor_defense, helmet_defense)
    else:
        printerr("Cannot equip item of unknown type")

func unequip(slot_type: int) -> void:
    if slot_type in equipped_items:
        equipped_items[slot_type] = null

func get_equipped(slot_type: int) -> EquipableItemData:
    return equipped_items.get(slot_type)

func get_equipped_items() -> Dictionary:
    return equipped_items
