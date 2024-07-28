class_name Enemy
extends Node

@export var health: int = 10

func damage(amount: int) -> void:
	health -= amount
	print(amount, " vida de  ", health)
#pode desativar o objeto qnd chegar em 0 e levar para o position inicial de respawn 
#e ativar após alguns segundos
