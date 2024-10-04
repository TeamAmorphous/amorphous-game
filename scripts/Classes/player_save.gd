class_name PlayerSave

extends Resource

# TODO: Consider that Resources allow code injection to happen, discuss with
# Tetracold this possibility

## The PlayerSave class will be in charge of storing the main information for
## the player. This will focus on their main stats for battle, experience level
## inventory, companions, attacks, gear, and inventory.
##
## This class will be used as a singleton to reference whenever the player
## transitions into a battle scene. Additionally, it will also be referenced
## whenever there is the need for a stat check or modification in the game.
##

# Stats
@export var curr_hp : int
@export var max_hp : int
@export var curr_mp : int
@export var max_mp : int
@export var curr_pp : int
@export var max_pp : int
@export var defense : int
@export var speed : int
@export var luck : int
@export var curr_exp : int
@export var lvl : int

# Companion
@export var active_companion : PlayerCompanion
@export var companions_list : Array[PlayerCompanion] = []

# Inventory
@export var gold_coins : int
@export var actions : Array[String] = []
@export var gear_equipped : Array[String] = []
@export var gear_inventory : Dictionary
@export var item_inventory : Dictionary
@export var key_items : Dictionary
