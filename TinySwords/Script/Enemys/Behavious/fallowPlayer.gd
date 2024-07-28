extends Node
var enemy = Enemy

@onready var sprite: Sprite2D
@export var speed: float = 0.5
var inputVector: Vector2

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("PawnBlue")
	enemy.health
func _process(delta: float) -> void:
	rotate_sprite()
	
	
func _physics_process(delta: float) -> void:
	var playerPosition = GameManager.playerPosition
	var difference = playerPosition - enemy.position
	inputVector = difference.normalized()
	enemy.velocity = inputVector * speed * 100.0
	enemy.move_and_slide()

func rotate_sprite()-> void:
	if inputVector.x < 0:
		sprite.flip_h = true
	elif inputVector.x > 0:
		sprite.flip_h = false
