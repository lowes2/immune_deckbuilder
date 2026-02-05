extends Node2D


var damage = 10
var damage_modifier = 1
var inflame = 10
#all cells start deactivated, and take one turn to activate (?)
#NK cells can start active bc they don't need an activation signal
var active = false
