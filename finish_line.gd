extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var main = get_tree().current_scene
		main.win_game()

		if body.has_node("AnimatedSprite2D"):
			var sprite = body.get_node("AnimatedSprite2D")
			sprite.play("win")
