extends Node2D

var cards : Array[Button] = []
@onready var card_scene = preload("res://card.tscn")
@onready var enemy_scene = preload("res://enemy.tscn")

func _ready():
	position = Vector2(200, 600)
	for i in 7:
		drawCard(i)

func drawCard(index):
	var addCard = card_scene.instantiate()
	cards.append(addCard)
	addCard.position.x = position.x + 50 * index
	add_child(addCard)
	
	
func spawnEnemy():
	var addEnemy = enemy_scene.instantiate()
	addEnemy.global_position.x = 700
	addEnemy.global_position.y = -700
	add_child(addEnemy)
	
