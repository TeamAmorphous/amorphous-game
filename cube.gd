extends MeshInstance3D

var speed  = 10

func _process(delta):
	if Input.is_action_pressed("up"):
		position.x += delta * speed
	if Input.is_action_pressed("down"):
		position.x -= delta * speed
	if Input.is_action_pressed("left"):
		position.z -= delta * speed
	if Input.is_action_pressed("right"):
		position.z += delta * speed
