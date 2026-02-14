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
@onready var particles = $CPUParticles2D
@onready var particlesFloor = $CPUParticles2D/CPUParticles2D
@onready var texture = $TextureRect
var moveParticles = false

func _ready():
	battle = get_parent()
	pivot_offset = size / 2
	saveScale = scale

func use():
	move(Vector2(300, -300))
	
	#enemy.hurt(damage)
	#battle.adjustInflammation(inflame)
	
func _process(delta: float) -> void:
	if isHovering:
		var percent = timer.time_left / timer.wait_time
		if grow:
			scale += Vector2(scaleCurve.sample(1-percent),scaleCurve.sample(1-percent)) / Vector2(10,10)
		else:
			scale -= Vector2(scaleCurve.sample(1-percent),scaleCurve.sample(1-percent)) / Vector2(10,10)
	if scale < saveScale:
		scale = saveScale
	if moveParticles:
		particles.global_position.y += 5
		print(particles.global_position.y)
		if particles.global_position.y > global_position.y + size.y + size.y + size.y:
			moveParticles = false
			particles.emitting = false 
			particlesFloor.emitting = false
			queue_free()
		


func move(targetPos):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", targetPos, 0.3)
	tween.tween_callback(Callable(self, "destroy"))
	
func destroy():
	texture.modulate = Color(0.0, 0.0, 0.0, 1.0)
	particles.emitting = true
	particlesFloor.emitting = true
	moveParticles = true

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
	if event.is_action_pressed("USE") and selected:
		use()

func _on_pressed() -> void:
	selected = true
