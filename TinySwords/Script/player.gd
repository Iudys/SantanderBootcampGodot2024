extends CharacterBody2D

@onready var sprite: Sprite2D = $WarriorPurple

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var is_running: bool = false
var was_running: bool = false
var is_attaking: bool = false
var attack_cooldown: float = 0.0
var input_vector2: Vector2 = Vector2(0,0)
@export var speed: float = 3.0
@export_range(0,1) var lerp_factor: float = 0.075 

func _process(delta:float) -> void:
	read_input()
	run_iddle_play_animation()
	rotate_sprite()
	update_attack_cooldown(delta)
	
	if Input.is_action_just_pressed("Attack"):
		Attack()
		
func read_input()-> void:
	input_vector2 = Input.get_vector("move_left","move_right","move_up","move_down") #zona morta em float
	
	var deadzone: float = 0.15
	
	if abs(input_vector2.x)< 0.15:
		input_vector2.x = 0.0
	if abs(input_vector2.y)< 0.15:
		input_vector2.y = 0.0

	was_running = is_running
	is_running = not input_vector2.is_zero_approx()
	
func update_attack_cooldown(delta:float)-> void:
	if is_attaking:
		attack_cooldown -= delta
		if attack_cooldown <= 0.0:
			is_attaking = false
			is_running = false
			animation_player.play("Iddle")
	
func _physics_process(delta: float) -> void:
#Modificar a Velocidade
	var target_velocity = input_vector2 * speed * 100.0
	if is_attaking:
		target_velocity *= 0.25
	velocity = lerp(velocity,target_velocity,lerp_factor)
	move_and_slide()
	
func run_iddle_play_animation() -> void:
	if not is_attaking:
		if was_running != is_running:
			if is_running:
				animation_player.play("Walking")
			else:
				animation_player.play("Iddle")
func rotate_sprite()-> void:
	if input_vector2.x < 0:
		sprite.flip_h = true
	elif input_vector2.x > 0:
		sprite.flip_h = false
				
func Attack() -> void:
	if is_attaking:
		return
	
	animation_player.play("AtkR1")
	attack_cooldown = 0.6
	is_attaking = true
