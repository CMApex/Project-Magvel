
extends MeshInstance3D

# Map Size in tiles. Editable in the inspector
@export var map_width: int = 15
@export var map_height: int = 10

# Which tile the cursor is on. Starts near the middle.
var tile = Vector2i(7, 5)


func _ready() -> void:
	#Runs once at the start: put the cursor on the starting title.
	position = tile_to_world(tile)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Runs every frame: work out which way (if any) to move.
	var step := Vector2i.ZERO

	if Input.is_action_just_pressed("move_up"):
		step.y -= 1
	if Input.is_action_just_pressed("move_down"):
		step.y += 1
	if Input.is_action_just_pressed("move_left"):
		step.x -= 1
	if Input.is_action_just_pressed("move_right"):
		step.x += 1

	#Only do work if a direction was actually pressed.
	if step != Vector2i.ZERO:
		tile += step
		# Keep the cursor on the map.
		tile.x = clampi(tile.x, 0, map_width - 1)
		tile.y = clampi(tile.y, 0, map_height -1)
		position = tile_to_world(tile)

# Converts a tile coordinate into a 3D position at that tile's center
func tile_to_world(t: Vector2i) -> Vector3:
	var x := t.x - map_width / 2.0 + 0.5
	var z := t.y - map_height / 2.0 + 0.5
	return Vector3(x, 0.02, z)
