extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -700.0
const GRAVITY = 980.0
var game_over = false
var start_position: Vector2
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	start_position = global_position
	
func _physics_process(delta: float) -> void:
	if game_over:
		velocity = Vector2.ZERO
		move_and_slide()
		animated_sprite.stop()
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	if direction != 0:
		animated_sprite.flip_h = direction < 0
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

	move_and_slide()
	
func die() -> void:
	if game_over:
		return

	game_over = true
	velocity = Vector2.ZERO
	set_physics_process(false)

	var main = get_tree().current_scene
	main.time_left = 7.0
	main.timer_label.text = "60s"

	await get_tree().create_timer(1.0).timeout

	global_position = start_position
	game_over = false
	set_physics_process(true)
