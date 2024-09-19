extends Node

## The base battle controller script.

## This will serve as a template for any of the fights in the story. The goal
## of this template will allow us to enable multiple nodes within a level to
## communicate with one another while giving us the granular control of what
## events to trigger during gameplay.
##
## The main loop of the battle breaks down into multiple signals that follow 
## the main actions of the player, NPCs and enemies.
## 
## Consider that the process to follow is:
## Battle Starts -> Show UI -> Player Action -> Enemy Action -> Battle Concludes
##
## Signals will be classified by the entity executing it, classified by the 
## following:
## - Player
## - Enemy
## - Scene
##
## Consider as well that when an attack happens (either from the player or an 
## enemy). There is a two-step process, a signal to initiate the attack event
## ("bc_player/enemy_attacked"), and a signal to signify the end of the minigame
## ("bc_player/enemy_minigame_ended"). This will send back the results of the 
## minigame in terms of damage done and rating bar fill.
##
## NOTE: In case we need to generate new signals within the battle controller,
## keep the naming of them as "bc_(entity)_(action)"
##
## TODO: Define how to handle the fixed attack timer for enemies (Signal?)
## TODO: Status effect system
##
## @tutorial: https://www.gdquest.com/tutorial/godot/design-patterns/mediator/

signal bc_scene_battle_started(init: int)
signal bc_scene_ui_presented()
signal bc_scene_won(exp: int)
signal bc_scene_lost()
signal bc_concluded()

# NOTE: Player action? or attack? Check naming later.
signal bc_player_gear_switched()
signal bc_player_item_used()
signal bc_player_char_switched()
signal bc_player_fled()
signal bc_player_attacked()

signal bc_player_minigame_ended(rating: int)

# TODO: Create a minigame class, or find a way to make templates for the 
# different battle minigames in the game code.
signal bc_enemy_attacked()
signal bc_enemy_minigame_ended(rating: float)


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
	bc_scene_battle_started.emit(GlobalVariables.current_battle_init)
  
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
