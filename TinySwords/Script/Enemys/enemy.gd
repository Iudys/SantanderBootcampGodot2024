class_name Enemy
extends Node

@export var health: int = 10

func damage(amount: int) -> void:
	health -= amount