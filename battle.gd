extends Node2D

var inflm = 0
var inflm_max = 500
@onready var enemy = preload("res://enemy.tscn")
var hand_scene = preload("res://hand.tscn")

#might not want to instnatiate this immediately
var hand = hand_scene.instantiate()

func _ready():
	spawnEnemies()
	add_child(hand)


func spawnEnemies():
	add_child(enemy.instantiate())

func adjustInflammation(amount):
	if (inflm + amount <= inflm_max):
		inflm += amount
	else:
		endBattle(-1)
		
		
func getEnemy():
	return enemy

#-1 state indicates death, 0/1 indicates win (0 for tie? not sure)
func endBattle(state):
	if (state == -1):
		print("You died!")
	else:
		print("You won!")
