extends Node2D


var health = 50




func hurt(damage):
	health -= damage
	if health < 0:
		health = 0;
	print("I died :(")
	queue_free()
