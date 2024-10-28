extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Test case

		var testCompanion = PlayerCompanion.new()

		testCompanion.curr_hp = 12
		testCompanion.max_hp = 12
		testCompanion.curr_mp = 12
		testCompanion.max_mp = 12
		testCompanion.curr_pp = 12
		testCompanion.max_pp = 12
		testCompanion.defense = 12
		testCompanion.speed = 12
		testCompanion.luck = 12
		testCompanion.curr_exp = 12
		testCompanion.lvl = 12

		# Attacks & Gear
		testCompanion.actions.append_array(["power ring", "fizz", "buzz"])
		testCompanion.equipped.append_array(["power ring", "fizz", "buzz"])

		var testPlayer = PlayerSave.new()
		# Stats
		testPlayer.curr_hp = 1
		testPlayer.max_hp = 1
		testPlayer.curr_mp = 1
		testPlayer.max_mp = 1
		testPlayer.curr_pp = 1
		testPlayer.max_pp = 1
		testPlayer.defense = 1
		testPlayer.speed = 1
		testPlayer.luck = 1
		testPlayer.curr_exp = 1
		testPlayer.lvl = 1

		# Companion
		testPlayer.active_companion = testCompanion
		testPlayer.companions_list.append(testCompanion)

		# Inventory
		testPlayer.gold_coins = 1
		testPlayer.actions.append_array(["punch", "kick", "hello"])
		testPlayer.gear_equipped.append_array(["1", "2", "3"])
		testPlayer.gear_inventory = {
		"1" : 1,
		"charm" : 2,
		"helment" : 1,
		}
		testPlayer.item_inventory = {
		"potion" : 3,
		"bomb" : 12,
		}
		testPlayer.key_items = {}
		var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
		var data = JSON.stringify(testPlayer)
		save_file.store_var(data)
		print(testPlayer.to_string())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
