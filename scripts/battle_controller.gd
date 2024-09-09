extends Node

## The base battle controller script.

## This will serve as a template for any of the fights in the story. The goal
## of this template will allow us to enable multiple nodes within a level to
## communicate with one another while giving us the granular control of what
## events to trigger during gameplay.
##
## @tutorial: https://www.gdquest.com/tutorial/godot/design-patterns/mediator/

signal bc_battle_started(init: int)
signal bc_ui_presented()
signal bc_player_attacked()
signal bc_player_minigame_ended(rating: float)
signal bc_attack_bar_filled(atk_fill: int)
# TODO: Create a minigame class, or find a way to make templates for the 
# different battle minigames in the game code.
signal bc_enemy_attacked(minigame)
signal bc_enemy_minigame_ended(rating: float)
signal bc_battle_won(exp: int)
signal bc_battle_lost()
signal bc_concluded()

enum BattleInit {
  ENEMY,
  NEUTRAL,
  PLAYER
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match GlobalVariables.current_battle_init:
		BattleInit.ENEMY:
			print_debug("enemy start")
		BattleInit.NEUTRAL:
			print_debug("neutral start")
		BattleInit.PLAYER:
			print_debug("player start")
	bc_battle_started.emit(GlobalVariables.current_battle_init)
  
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
