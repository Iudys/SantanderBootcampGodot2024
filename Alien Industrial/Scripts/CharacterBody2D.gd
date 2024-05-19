extends CharacterBody2D


@export_range(3,5) var speed = 3.0
var deltaSpeed = 100.0
@export_range(0,1) var lerp_factor = 0.5
@onready var ship_yellow_manned = $ShipYellowManned


func _physics_process(delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	var target_velocity = direction * speed * deltaSpeed
	velocity = lerp(velocity,target_velocity, lerp_factor)
	move_and_slide()
	
	var target_rotation = direction.x  * 45.0
	ship_yellow_manned.rotation_degrees = lerp(ship_yellow_manned.rotation_degrees, target_rotation,lerp_factor)
