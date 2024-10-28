class_name BattleController
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
## ("bc_player/enemy_acted"), and a signal to signify the end of the minigame
## ("bc_player/enemy_minigame_ended"). This will send back the results of the
## minigame in terms of damage done and rating bar fill.
##
##
## @tutorial: https://www.gdquest.com/tutorial/godot/design-patterns/mediator/

# NOTE: In case we need to generate new signals within the battle controller,
# keep the naming of them as "bc_(entity)_(action)"
#
# TODO: Define how to handle the fixed attack timer for enemies (Signal?)
# TODO: Status effect system
# TODO: Do we need to bring in the scene that invoked the battle to do a proper
# 	callback?
# TODO: Evaluate and list eventually all callbacks after a minigame event
# concludes.
# TODO: Add fixed time interval to enemy attacks.

signal bc_scene_battle_started(init: int)
signal bc_scene_ui_presented()
signal bc_scene_won(exp: int)
signal bc_scene_lost()
signal bc_scene_concluded()

# NOTE: Player action? or move? Check naming later.
signal bc_player_gear_switched()
signal bc_player_item_used()
signal bc_player_char_switched()
signal bc_player_fled()
# TODO: Some actions will not necessarily involve a minigame (ie: Healing spell)
# it might be a better idea to have an inventory of all actions to reference
# from a file, load them as needed and have the code play out accordingly
# (mainly if there is the need for a minigame or not).
signal bc_player_acted()

signal bc_enemy_acted()


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
func _process(_delta: float) -> void:
	pass


func _on_battle_options_items_pressed() -> void:
	print("items!!")


func _on_battle_options_flee_pressed() -> void:
	print("flee!!")


func _on_battle_options_attacks_pressed() -> void:
	print("attack!!")


func _on_battle_options_gear_pressed() -> void:
	print("gear!!")


