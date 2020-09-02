extends KinematicBody2D

var SPEED = 300
var ACCELERATION = .25
var gravity = 1300
var jump_speed = -800
var friction = 0.1
var velocity = Vector2.ZERO
var isonfloor = true
var side = true  # true for right side
var run = 1
var temp = 0

func get_input(delta):
	velocity.x = 0
	velocity.y += gravity * delta
	if Input.is_action_pressed("ui_up"):
		if is_on_floor():
			play_animation(false,false,true)
			$jump.play()
			isonfloor = false
			velocity.y = jump_speed
	if Input.is_action_just_pressed("run"):
		temp = 2
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		temp = 1
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("run"):
			run = 2.5
		velocity.x += SPEED * run
		play_animation(true,true,false)
		side = true
	elif Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("run"):
			run = 2.5
		velocity.x -= SPEED * run 
		play_animation(true,false,false)
		side = false
	else:
		if isonfloor:
			play_animation()
	if temp == 1:
		$step.play()
	elif temp == 2:
		$land.play()
	temp = 0
		

func play_animation(moving = false,right= false,jump = false):
	if moving:
		if right:
			$AnimatedSprite.flip_h = false
		else:
			#$AnimatedSprite.flip_h = true
			
			pass
		if isonfloor:
			if run > 1:
				$AnimatedSprite.play("run")
			else:
				$AnimatedSprite.play("walk")
	elif jump:
		if isonfloor:
			$AnimatedSprite.play("jump")
	else:
		$AnimatedSprite.play("idle")
		if side:
			$AnimatedSprite.flip_h = false
		else:
			#$AnimatedSprite.flip_h = true
			pass
	
	
func _ready():
	pass


func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity,Vector2.UP)
	run = 1
	if is_on_floor():
		isonfloor = true
