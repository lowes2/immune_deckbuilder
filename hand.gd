extends Node2D

var cards : Array[Node2D] = []
@onready var card_scene = preload("res://card.tscn")

func _ready():
	for i in 7:
		drawCard(i)

func drawCard(index):
	var addCard = card_scene.instantiate()
	cards.append(addCard)
	addCard.position.x = position.x + 50 * index
	add_child(addCard)
	
	
