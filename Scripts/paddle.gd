extends KinematicBody2D

var new_ball = preload("res://Scenes/Ball.tscn")

onready var _view = get_viewport().get_visible_rect().size
onready var _shape = $Sprite.get_rect().size
onready var _collision_transform = $CollisionShape2D.get_transform().get_scale()

export var distort_x = 2.0
export var distort_y = 1.2

func _ready():
 set_process_input(true)
 position.y = -30
 $Tween.interpolate_property(self, "position", position, _target, 1.0, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
 $Tween.start()

var _target = position

func _physics_process(delta):
 var mouse_x = get_viewport().get_mouse_position().x
 position = Vector2(mouse_x, position.y)
 #if mouse_x != position.x:
 # var x = position.x + ((mouse_x - position.x)*0.2)
 # var w = 1 + (distort_x * (abs(mouse_x - position.x) / _view.x))
  #var h = 1 - (1/distort_y * (abs(mouse_x - position.x) / _view.y))
  #_change_size(w,h)
  #position = Vector2(mouse_x, position.y)
 #else:
  #_change_size(1,1)
func _input(event):
 if event is InputEventMouseButton and event.pressed:
  if not get_parent().has_node("Ball"):
   var ball = new_ball.instance()
   ball.position = position - Vector2(0, 32)
   ball.name = "Ball"
   ball.linear_velocity = Vector2(200, -200)
   get_parent().add_child(ball)

#func _change_size(w, h):
	#$Sprite.set_scale = Vector2(w, h)
	#$CollisionShape2D.set_scale(Vector2(_collision_transform.x*w,_collision_transform.y*h))
	
	#I tried to get this to work but because Im using a sprite and not a color rect I couldn't get it to work. Couldn't find anything on how to do it to a sprite