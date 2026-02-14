extends Button

#in each specific card, we will set the values by inheriting the IVs then modifying them
var damage = 0
var damage_modifier = 1
var inflame = 0
#all cells start deactivated, and take one turn to activate (?)
#NK cells can start active bc they don't need an activation signal
var active = false
var battle: Node2D
#this may have to change to accomodate it being a control nodde


#for hover
@export var scaleCurve: Curve
@onready var timer = $hoverTimer
var saveScale = scale
var isHovering = false
var grow = true

#placement
var selected = false

func _ready():
	battle = get_parent()
	pivot_offset = size / 2
	saveScale = scale

func use(enemy):
	enemy.hurt(damage)
	battle.adjustInflammation(inflame)
	
func _process(delta: float) -> void:
	if isHovering:
		var percent = timer.time_left / timer.wait_time
		if grow:
			scale += Vector2(scaleCurve.sample(1-percent),scaleCurve.sample(1-percent)) / Vector2(10,10)
		else:
			scale -= Vector2(scaleCurve.sample(1-percent),scaleCurve.sample(1-percent)) / Vector2(10,10)
	if scale < saveScale:
		scale = saveScale
		
		
		

func hover():
	if not timer.is_stopped():
		timer.stop()
	timer.start()
	isHovering = true

func _on_hover_timer_timeout() -> void:
	isHovering = false
	
func _on_mouse_entered() -> void:
	if not selected:
		hover()
		z_index += 1
		grow = true
	
func _on_mouse_exited() -> void:
	if not selected:
		hover()
		z_index -= 1
		grow = false
	
func _input(event):
	if event.is_action_pressed("CANCEL"):
		selected = false
		hover()
		z_index -= 1
		grow = false
	if event.is_action_pressed("USE"):
		use(battle.getEnemy())

func _on_pressed() -> void:
	selected = true
