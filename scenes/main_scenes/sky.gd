extends Control

@export var texture1 : Sprite2D
@export var texture2 : Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	texture1.offset -= Vector2(0.1,0)
	texture2.offset -= Vector2(0.1,0)
	if texture1.offset.x < -1025:
		texture1.offset.x = 0
	if texture2.offset.x < -1025:
		texture2.offset.x = 0
