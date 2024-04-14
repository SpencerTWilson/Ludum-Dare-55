extends Control

@export var texture1 : Sprite2D
@export var texture2 : Sprite2D

@export var Season = 0

@export var spring : Node
@export var summer : Node
@export var fall : Node
@export var winter : Node

@export var spring_tex : Texture2D
@export var summer_tex : Texture2D
@export var fall_tex : Texture2D
@export var winter_tex : Texture2D


func _process(delta):
	texture1.offset -= Vector2(0.1,0)
	texture2.offset -= Vector2(0.1,0)
	if texture1.offset.x < -1025:
		texture1.offset.x = 0
	if texture2.offset.x < -1025:
		texture2.offset.x = 0
	
	match Season:
		0:
			texture1.texture = spring_tex
			texture2.texture = spring_tex
			spring.visible = true
			summer.visible = false
			fall.visible = false
			winter.visible = false
		1:
			texture1.texture = summer_tex
			texture2.texture = summer_tex
			spring.visible = false
			summer.visible = true
			fall.visible = false
			winter.visible = false
		2:
			texture1.texture = fall_tex
			texture2.texture = fall_tex
			spring.visible = false
			summer.visible = false
			fall.visible = true
			winter.visible = false
		3:
			texture1.texture = winter_tex
			texture2.texture = winter_tex
			spring.visible = false
			summer.visible = false
			fall.visible = false
			winter.visible = true
