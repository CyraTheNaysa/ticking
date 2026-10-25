extends Area2D

@export var time_bonus: float = 6.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var main = get_tree().current_scene
		main.time_left += time_bonus
		queue_free()
