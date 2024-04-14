extends Control

@export var texture1 : Sprite2D
@export var texture2 : Sprite2D
@export var Season = 0
@export var spring : Texture2D
@export var summer : Texture2D
@export var fall : Texture2D
@export var winter : Texture2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	texture1.offset -= Vector2(0.1,0)
	texture2.offset -= Vector2(0.1,0)
	if texture1.offset.x < -1025:
		texture1.offset.x = 0
	if texture2.offset.x < -1025:
		texture2.offset.x = 0
	
	match Season:
		0:
			texture1.texture = spring
			texture2.texture = spring
		1:
			texture1.texture = summer
			texture2.texture = summer
		2:
			texture1.texture = fall
			texture2.texture = fall
		3:
			texture1.texture = winter
			texture2.texture = winter
