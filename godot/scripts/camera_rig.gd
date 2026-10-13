extends Node3D


# What the camera follows. Drag the Cursor node here in the Inspector.
@export var target: Node3D
# How quickly the camera catches up. Bigger = snappier
@export var follow_speed := 8.0


func _ready() -> void:
	# Start already on the target, instead of gliding in from the origin.
	global_position = _goal()



func _process(delta: float) -> void:
	# How far to move this frame, the same at any frame rate.
	var weight := 1.0 - exp(-follow_speed * delta)
	global_position = global_position.lerp(_goal(), weight)

# Where the rig wants to be: right under the target, on the ground.
func _goal() -> Vector3:
	var goal := target.global_position
	goal.y = 0.0
	return goal
