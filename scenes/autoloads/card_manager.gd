extends Node

var card_types: Dictionary = {
	"april_bird": {
		"texture": preload("res://assets/textures/hanafuda/april_bird.png"),
		"tags": ["april","bird","animal"],
	},
	"april_plain": {
		"texture": preload("res://assets/textures/hanafuda/april_plain.png"),
		"tags": ["april","plain"],
	},
	"april_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/april_ribbon.png"),
		"tags": ["april","ribbon","red_ribbon"],
	},
	"august_birds": {
		"texture": preload("res://assets/textures/hanafuda/august_birds.png"),
		"tags": ["august","bird","animal"],
	},
	"august_gold": {
		"texture": preload("res://assets/textures/hanafuda/august_gold.png"),
		"tags": ["august","gold"],
	},
	"august_plain": {
		"texture": preload("res://assets/textures/hanafuda/august_plain.png"),
		"tags": ["august","plain"],
	},
	"december_gold": {
		"texture": preload("res://assets/textures/hanafuda/december_gold.png"),
		"tags": ["december","gold"],
	},
	"december_plain": {
		"texture": preload("res://assets/textures/hanafuda/december_plain.png"),
		"tags": ["december","plain"],
	},
	"december_special": {
		"texture": preload("res://assets/textures/hanafuda/december_special.png"),
		"tags": ["december","plain","special"],
	},
	"february_bird": {
		"texture": preload("res://assets/textures/hanafuda/february_bird.png"),
		"tags": ["february","bird"],
	},
	"february_plain": {
		"texture": preload("res://assets/textures/hanafuda/february_plain.png"),
		"tags": ["february","plain"],
	},
	"february_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/february_ribbon.png"),
		"tags": ["february","ribbon","text_ribbon"],
	},
	"january_gold": {
		"texture": preload("res://assets/textures/hanafuda/january_gold.png"),
		"tags": ["january","gold"],
	},
	"january_plain": {
		"texture": preload("res://assets/textures/hanafuda/january_plain.png"),
		"tags": ["january","plain"],
	},
	"january_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/january_ribbon.png"),
		"tags": ["january","ribbon","text_ribbon"],
	},
	"july_animal": {
		"texture": preload("res://assets/textures/hanafuda/july_animal.png"),
		"tags": ["july","animal","boar"],
	},
	"july_plain": {
		"texture": preload("res://assets/textures/hanafuda/july_plain.png"),
		"tags": ["july","plain"],
	},
	"july_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/july_ribbon.png"),
		"tags": ["july","ribbon","red_ribbon"],
	},
	"june_animal": {
		"texture": preload("res://assets/textures/hanafuda/june_animal.png"),
		"tags": ["june","animal","butterfly"],
	},
	"june_plain": {
		"texture": preload("res://assets/textures/hanafuda/june_plain.png"),
		"tags": ["june","plain"],
	},
	"june_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/june_ribbon.png"),
		"tags": ["june","ribbon","blue_ribbon"],
	},
	"march_gold": {
		"texture": preload("res://assets/textures/hanafuda/march_gold.png"),
		"tags": ["march","gold"],
	},
	"march_plain": {
		"texture": preload("res://assets/textures/hanafuda/march_plain.png"),
		"tags": ["march","plain"],
	},
	"march_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/march_ribbon.png"),
		"tags": ["march","ribbon","text_ribbon"],
	},
	"may_animal": {
		"texture": preload("res://assets/textures/hanafuda/may_animal.png"),
		"tags": ["may","animal","frog"],
	},
	"may_plain": {
		"texture": preload("res://assets/textures/hanafuda/may_plain.png"),
		"tags": ["may","plain"],
	},
	"may_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/may_ribbon.png"),
		"tags": ["may","ribbon","red_ribbon"],
	},
	"november_bird": {
		"texture": preload("res://assets/textures/hanafuda/november_bird.png"),
		"tags": ["november","bird","animal"],
	},
	"november_gold": {
		"texture": preload("res://assets/textures/hanafuda/november_gold.png"),
		"tags": ["november","gold"],
	},
	"november_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/november_ribbon.png"),
		"tags": ["november","ribbon","red_ribbon"],
	},
	"november_special": {
		"texture": preload("res://assets/textures/hanafuda/november_special.png"),
		"tags": ["november","plain","special"],
	},
	"october_animal": {
		"texture": preload("res://assets/textures/hanafuda/october_animal.png"),
		"tags": ["october","animal","deer"],
	},
	"october_plain": {
		"texture": preload("res://assets/textures/hanafuda/october_plain.png"),
		"tags": ["october","plain"],
	},
	"october_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/october_ribbon.png"),
		"tags": ["november","ribbon","blue_ribbon"],
	},
	"september_animal": {
		"texture": preload("res://assets/textures/hanafuda/september_animal.png"),
		"tags": ["september","animal","fox"],
	},
	"september_plain": {
		"texture": preload("res://assets/textures/hanafuda/september_plain.png"),
		"tags": ["september","plain"],
	},
	"september_ribbon": {
		"texture": preload("res://assets/textures/hanafuda/september_ribbon.png"),
		"tags": ["september","ribbon","blue_ribbon"],
	},
}

func get_month(card: Card):
	for tag in card.tags:
		match tag:
			"january":
				return "january"
			"february":
				return "february"
			"march":
				return "march"
			"april":
				return "april"
			"may":
				return "may"
			"june":
				return "june"
			"july":
				return "july"
			"august":
				return "august"
			"september":
				return "september"
			"october":
				return "october"
			"november":
				return "november"
			"december":
				return "december"
			_:
				continue
