extends AnimatableBody2D

@export var move_distance: float = 200.0
@export var move_speed: float = 100.0

var start_position: Vector2
var target_position: Vector2
var moving_forward: bool = true

func _ready() -> void:
	start_position = global_position
	target_position = start_position + Vector2(move_distance, 0)

func _physics_process(delta: float) -> void:
	var target = target_position if moving_forward else start_position

	global_position = global_position.move_toward(
		target,
		move_speed * delta
	)

	if global_position.distance_to(target) < 1.0:
		moving_forward = not moving_forward
