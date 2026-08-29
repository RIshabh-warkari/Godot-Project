extends Area2D

# =========================
# SAW SETTINGS
# =========================

const ROTATION_SPEED = 300
const ATTACK = 20


# =========================
# READY
# =========================

func _ready():

	# Connect body entered signal
	if not is_connected("body_entered", self, "_on_saw_body_entered"):

		connect(
			"body_entered",
			self,
			"_on_saw_body_entered"
		)


# =========================
# CONSTANT ROTATION
# =========================

func _physics_process(delta):

	rotation_degrees += ROTATION_SPEED * delta


# =========================
# PLAYER HIT
# =========================

func _on_saw_body_entered(body):

	if body.is_in_group("player"):

		print("SAW HIT PLAYER!")

		if body.has_method("damage"):

			body.damage(ATTACK)

