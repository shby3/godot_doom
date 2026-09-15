extends CharacterBody3D

@export var speed: float = 1.5
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration: float = 75
# Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse: float = 20
var look_dir: Vector2

@onready var camera: Camera3D = $Camera3D
var camera_sens: float = 50.0

func sit_down(seat_position: Vector3) -> void:
	global_position = seat_position
	set_physics_process(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func sit_up() -> void:
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.x, 0, speed)

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		velocity.y = velocity.y - (fall_acceleration * delta)

	# Jumping.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_impulse

	_rotate_camera(delta)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.01

func _rotate_camera(delta: float, sens_mod: float = 1.0) -> void:
	rotation.y -= look_dir.x * camera_sens * delta
	camera.rotation.x = clamp(
			camera.rotation.x - look_dir.y * camera_sens * sens_mod * delta,
			-1.5, 1.5)
	look_dir = Vector2.ZERO
