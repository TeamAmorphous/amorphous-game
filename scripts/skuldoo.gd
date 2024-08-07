extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var skuldoo_sprite: SpriteBase3D = $Sprite3D
@export var in_dialogue := false


func _physics_process(delta: float) -> void:
  # Add the gravity.
  if not is_on_floor():
    velocity += get_gravity() * delta

  # Handle jump.
  if Input.is_action_just_pressed("jump") and is_on_floor():
    velocity.y = JUMP_VELOCITY

  # Get the input direction and handle the movement/deceleration.
  # As good practice, you should replace UI actions with custom gameplay actions.
  var input_dir := Input.get_vector("up", "down", "right", "left")
  var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

  #Check and validate sprite orientation with the current direction
  if not in_dialogue:
    if direction.x < 0:
      skuldoo_sprite.flip_h = false
    elif direction.x > 0:
      skuldoo_sprite.flip_h = true

  if direction:
    velocity.x = direction.x * SPEED
    velocity.z = direction.z * SPEED
  else:
    velocity.x = move_toward(velocity.x, 0, SPEED)
    velocity.z = move_toward(velocity.z, 0, SPEED)

  if not in_dialogue:
    move_and_slide()
