extends Node2D

#in each specific card, we will set the values by inheriting the IVs then modifying them
var damage = 0
var damage_modifier = 1
var inflame = 0
#all cells start deactivated, and take one turn to activate (?)
#NK cells can start active bc they don't need an activation signal
var active = false
var battle: PackedScene

	


func use(enemy):
	enemy.hurt(damage)
	battle.adjustInflammation(inflame)
