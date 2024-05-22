extends CharacterBody2D

@onready var sprite: Sprite2D = $WarriorPurple

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var is_running: bool = false

@export var speed: float = 3.0
@export_range(0,1) var lerp_factor: float = 0.075 

func _physics_process(delta: float) -> void:
	#obter o input de movimento
	var input_vector2 = Input.get_vector("move_left","move_right","move_up","move_down") #zona morta em float
	var deadzone: float = 0.15
	
	if abs(input_vector2.x)< 0.15:
		input_vector2.x = 0.0
	if abs(input_vector2.y)< 0.15:
		input_vector2.y = 0.0
	
	#Modificar a Velocidade
	var target_velocity = input_vector2 * speed * 100.0
	velocity = lerp(velocity,target_velocity,lerp_factor)
	move_and_slide()
	
#Atualizar o is_running
	
	var was_running = is_running
	is_running = not input_vector2.is_zero_approx()
	
# Tocar Animação
	if was_running != is_running:
		if is_running:
			animation_player.play("Walking")
		else:
			animation_player.play("Iddle")
	if input_vector2.x < 0:
		sprite.flip_h = true
	elif input_vector2.x > 0:
		sprite.flip_h = false
