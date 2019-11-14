extends RigidBody2D

export var maxspeed = 300
#Not using Color Rects so most of the video doesnt help me, tried to do it to the sprite but couldnt get anyrhing to work, even what I googled
signal lives
signal score

var _decay_rate = 0.0
var _start_size
var _start_position
var _trauma = 0.0
var _rotation = 0
var _rotation_speed = 0.05
var _color = 0.0
var _color_delay = 1
var _normal_color

func _ready():
 contact_monitor = true
 set_max_contacts_reported(4)
 var WorldNode = get_node("/root/World")
 connect("score", WorldNode, "increase_score")
 connect("lives", WorldNode, "decrease_lives") 

func _physics_process(delta):
 var bodies = get_colliding_bodies()
 for body in bodies:
  if body.is_in_group("Tiles"):
   emit_signal("score",body.score)
   body.queue_free()
  if body.get_name() == "Paddle":
   pass
  
 if position.y > get_viewport_rect().end.y:
  emit_signal("lives")
  queue_free()

#func add_trauma(amount):
#	_trauma = min(_trauma + amount, 1)

#func _decay_trauma(delta):
#	var change = _decay_rate * delta
#	_trauma = max(_trauma - change, 0)
	
#func _apply_shake():
#	var shake = _trauma * _trauma
#	var o_x = _max_offset * shake * _get_neg_or_pos_scalar()
#	var o_y = _max_offset * shake * _get_neg_or_pos_scalar()
#	$ColorRect