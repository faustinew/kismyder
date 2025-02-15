extends Node

# le launchpad est organisé ainsi
# 13-20
# 29-36
# 49-56
# 77-84
# | 41 | 42 | 43 | 44 | 57 | 58 | 59 | 60 |
# | 73 | 74 | 75 | 76 | 89 | 90 | 91 | 92 |

const CC_CHAOS = 20
const CC_HEAD_ROTATION = 13
const CC_HEAD_TILT = 29

const CC_CAMERA_ZOOM = 14
const CC_CAMERA_DOLLY = 30

const CC_LIGHT1_INTENSITY = 15
const CC_LIGHT2_INTENSITY = 16
const CC_LIGHT3_INTENSITY = 17
const CC_LIGHT1_SAT = 31
const CC_LIGHT2_SAT = 32
const CC_LIGHT3_SAT = 33
const CC_LIGHTS_ROT = 18
const CC_LIGHTS_ROT_MULT = 34
const CC_LIGHTS_HUE = 19


const KEY_RESET = 41
const KEY_EXPLODE = 42
const KEY_EXPLODE_PROG = 43
const KEY_CAM_DEFAULT = 73
const KEY_CAM_FISHEYE = 74
const KEY_CAM_FLATTEN = 75
const KEY_LIGHTS_RESET = 76

const KEY_VOMI = {
	"TETE" = 60,
	"LOGO" = 59,
	"BEZO" = 58,
	"BLOD" = 91,
	"TOFF" = 92,
	"ZUCK" = 90
}


# dictionnaire des "Blend shape" = [0: numéro de CC main, 1: numéro de CC du multiplieur, 2: valeur minimum (0 ou -1)]
const SHAPE_DICTIONARY = {
	"Chialz" = [82, 54, -1],
	"Gros nez" = [84, 56, -0.1],
	"Grozieux" = [80, 52, -0.2],
	"Jock" = [-1, 36, -1], # nombre négatif pour garbage CC, je controlerai pas manuellement
	"Joue droite" = [-2, 36, -1],
	"Joue gauche" = [-3, 36, -1],
	"Joues" = [81, 53, -0.5],
	"Lower" = [-4, 36, -0.2],
	"Oneille droite" = [-105, 36, -1], # on gerera les oneilles battantes ailleurs
	"Oneille gauche" = [-106, 36, -1], # donc j'assigne à en dessous de -100
	"Oneilles" = [83, 55, -0.1],
	"Open" = [77, 49, -0.2],
	"Sourcil droit" = [-7, 36, -1],
	"Sourcil gauche" = [-8, 36, -1],
	"Sourcils" = [79, 51, -0.1],
	"Sourire" = [78, 50, -1.0],
	"Upper" = [-9, 36, -0.2]
}
