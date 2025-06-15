class_name ItemEffectHeal extends ItemEffect

@export var heal_amount : int = 1
@export var audio : AudioStream


func use() -> void:
	if PlayerManager and PlayerManager.player:
		PlayerManager.player.update_hp(heal_amount)
	if PauseMenu:
		PauseMenu.play_audio(audio)
	return 
