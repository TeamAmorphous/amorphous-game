extends Node

enum BattleInitState{
  ENEMY,
  NEUTRAL,
  PLAYER
}

var current_battle_init = BattleInitState.NEUTRAL
