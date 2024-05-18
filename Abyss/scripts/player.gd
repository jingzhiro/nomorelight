extends CharacterBody2D

var speed = 80
var click_position = Vector2()
var target_position = Vector2()
const VECTOR_ERROR_MARGIN = 3

var dashing = false
const DASH_TIME = 1
var dash_acc = 0

var health_points = 100

@onready var player_sprite = $player_sprite

func _ready():
	click_position = global_position

func _physics_process(delta):
	if Input.is_action_just_pressed("right_click"):
		click_position = get_global_mouse_position()
		player_sprite.play("run")
	
	if Input.is_action_just_pressed("s"):
		# stops player movement
		click_position = global_position
	
	if Input.is_action_just_pressed("d"):
		print("d is pressed!")
		click_position = get_global_mouse_position()
		target_position = position.direction_to(click_position)
		velocity = 600 * target_position
		player_sprite.play("roll")
		move_and_slide()

	# click-to-move movement
	if position.distance_to(click_position) > 3:
		# direction that player moves in
		target_position = position.direction_to(click_position).normalized()

		if target_position.x < 0:
			player_sprite.flip_h = true
		else:
			player_sprite.flip_h = false
			
		velocity = target_position * speed
		move_and_slide()
	
	# resets to idle animation when destination is reached
	if (global_position - click_position).length() < VECTOR_ERROR_MARGIN:
		player_sprite.play("idle")
		

