extends KinematicBody2D

# =========================
# PLAYER MOVEMENT
# =========================

var velocity = Vector2.ZERO

const SPEED = 200
const UP_JERK = -500
const GRAVITY = 20


# =========================
# PLAYER HEALTH
# =========================

var hp = 100


# =========================
# SPRITE
# =========================

onready var sprite = $AnimatedSprite

var def_offset_x


# =========================
# READY
# =========================

func _ready():

	add_to_group("player")

	def_offset_x = sprite.offset.x

	play_animation("statonary", false)


# =========================
# PHYSICS
# =========================

func _physics_process(delta):

	# LEFT / RIGHT

	if Input.is_key_pressed(KEY_D):

		velocity.x = SPEED
		play_animation("walk", false)

	elif Input.is_key_pressed(KEY_A):

		velocity.x = -SPEED
		play_animation("walk", true)

	else:

		velocity.x = 0
		play_animation("statonary", false)


	# GRAVITY

	if not is_on_floor():

		velocity.y += GRAVITY

	else:

		velocity.y = 0


	# JUMP

	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():

		velocity.y = UP_JERK


	# MOVE

	velocity = move_and_slide(velocity, Vector2.UP)


# =========================
# ANIMATION
# =========================

func play_animation(anim_name, flip):

	if sprite.animation != anim_name:

		sprite.animation = anim_name
		sprite.play()

	sprite.flip_h = flip

	if flip:

		sprite.offset.x = -def_offset_x

	else:

		sprite.offset.x = def_offset_x


# =========================
# DAMAGE
# =========================

func damage(dmg):

	hp -= dmg

	print("PLAYER HP:", hp)

	if hp <= 0:

		die()


# =========================
# DEATH
# =========================

func die():

	print("PLAYER DIED")

	queue_free()

