extends Node2D

@export var time_left: float = 7.0

var game_over: bool = false

@onready var timer_label: Label = $CanvasLayer/TimerLabel
@onready var player: Node2D = $Player
@onready var death_screen: Panel = $CanvasLayer/DeathScreen

func _process(delta: float) -> void:
	if game_over:
		return

	time_left -= delta
	timer_label.text = str(ceil(maxf(0.0, time_left))) + "s"

	if time_left <= 0:
		game_over = true
		time_left = 0
		timer_label.text = "Click anywhere to restart"
		death_screen.show()

		if is_instance_valid(player):
			var character = player as CharacterBody2D

			if character:
				character.velocity = Vector2.ZERO
				character.game_over = true
				character.get_node("AnimatedSprite2D").play("die")
				character.set_physics_process(false)
				
func win_game() -> void:
	if game_over:
		return

	game_over = true

	if is_instance_valid(player):
		player.set_physics_process(false)

	$CanvasLayer/DeathScreen/Message.text = "YOU SURVIVED!\nTime left: " + str(ceil(maxf(0.0, time_left))) + " seconds\n Click anywhere to restart"
	$CanvasLayer/DeathScreen.show()
	
func _input(event: InputEvent) -> void:
	if game_over and event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().reload_current_scene()
