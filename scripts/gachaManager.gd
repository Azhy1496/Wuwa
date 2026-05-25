extends CanvasLayer

# =========================
# Banner 数据
# =========================

var current_banner = "character"

# 角色池 UP
var up_character = "仇远"

var weapon_list = [
	"千古洑流",
	"浩境粼光",
	"停驻之烟",
	"擎渊怒涛",
	"漪澜浮录"
]
var up_weapon = "千古洑流"
@onready var banner_image = $MainUI/Background
@onready var banner_name = $MainUI/BannerName
@onready var title_label = $MainUI/TitleLabel
@onready var weaponBox = get_node("MainUI/weaponBox")
func switch_to_character_banner():
	current_banner = "character"
	up_character = "仇远"
	banner_name.text = "仇远"
	title_label.text = "UP角色唤取"
	banner_image.texture = load("res://assets/characters/CY.png")
	weaponBox.visible = false
	update_guarantee_text(guarantee_character)
	update_pity_ui()
func switch_to_weapon_banner():
	current_banner = "weapon"
	banner_name.text = ""
	title_label.text = "常驻武器唤取"
	banner_image.texture = load("res://assets/characters/WQ.png")
	weaponBox.visible = true
	update_pity_ui()
	update_guarantee_text(true)
func switch_to_standard_banner():
	current_banner = "standard"
	banner_name.text = "常驻角色"
	title_label.text = "常驻角色唤取"
	banner_image.texture = load("res://assets/characters/KKL.png")
	weaponBox.visible = false
	update_guarantee_text(guarantee_standard)
	update_pity_ui()
func weaponSelect():
	for weapon in weapon_list:
		weapon_selector.add_item(weapon)   # 显示名字
	weapon_selector.select(0)   # 默认选中第一个
	up_weapon = weapon_list[0]
	if !weapon_selector.item_selected.is_connected(_on_weapon_selected):
		weapon_selector.item_selected.connect(_on_weapon_selected)
func _on_weapon_selected(index: int):
	up_weapon = weapon_list[index]
func update_pity_ui():
	if current_banner == "character":
		Five_label.text = str(pityup_5)
		Four_label.text = str(pityup_4)
	elif current_banner == "weapon":
		Five_label.text = str(pityweapon_5)
		Four_label.text = str(pityweapon_4)
	else:
		Five_label.text = str(pitystandard_5)
		Four_label.text = str(pitystandard_4)
# 常驻五星
var standard_five = [
	"卡卡罗",
	"维里奈",
	"安可",
	"鉴心"
]

# 四星
var four_star = [
	"炽霞",
	"白芷",
	"丹瑾",
	"散华"
]
# 三星
var three_star = [
	"三星迅刀",
	"三星佩枪",
	"三星长刃",
	"三星臂铠",
	"三星音感仪"
]
# =========================
# 保底系统
# =========================

# 五星保底计数
var pityup_5 = 0
var pitystandard_5 = 0
var pityweapon_5 = 0

# 四星保底计数
var pityup_4 = 0
var pitystandard_4 = 0
var pityweapon_4 = 0

# 大保底
var guarantee_character = false
var guarantee_standard = false

# =========================
# 获取节点
# =========================

@onready var recordList = get_node("MainUI/RightPanel/MainVBox/RecentPanel/MarginContainer/RecentVBox/RecordScroll/RecordList")
@onready var guarantee_label = $MainUI/RightPanel/MainVBox/PityPanel/MarginContainer/PityVbox/BigPityRow/guarantee_label
@onready var Five_label = $MainUI/RightPanel/MainVBox/PityPanel/MarginContainer/PityVbox/FiveStarRow/ValueLabel
@onready var Four_label = $MainUI/RightPanel/MainVBox/PityPanel/MarginContainer/PityVbox/FourStarRow/ValueLabel
@onready var weapon_selector = $MainUI/weaponBox/WeaponSelector

# =========================
# 初始化
# =========================

func _ready():

	randomize()

	# 绑定按钮
	$MainUI/DrawButtons/Draw.pressed.connect(draw_one)
	$MainUI/DrawButtons/Draw10.pressed.connect(draw_ten)
	$MainUI/LeftMenu/CharacterBannerBtn.pressed.connect(switch_to_character_banner)
	$MainUI/LeftMenu/WeaponBannerBtn.pressed.connect(switch_to_weapon_banner)
	$MainUI/LeftMenu/StandardBannerBtn.pressed.connect(switch_to_standard_banner)
	update_guarantee_text(guarantee_character)
	weaponBox.visible = false
	weaponSelect()
# =========================
# 单抽
# =========================


func draw_one():
	do_gacha()
	if current_banner == "character":
		Five_label.text = str(pityup_5)
		Four_label.text = str(pityup_4)
	elif current_banner == "weapon":
		Five_label.text = str(pityweapon_5)
		Four_label.text = str(pityweapon_4)
	else:
		Five_label.text = str(pitystandard_5)
		Four_label.text = str(pitystandard_4)
# =========================
# 十连
# =========================

func draw_ten():


	for i in range(10):

		do_gacha()

	if current_banner == "character":
		Five_label.text = str(pityup_5)
		Four_label.text = str(pityup_4)
	elif current_banner == "weapon":
		Five_label.text = str(pityweapon_5)
		Four_label.text = str(pityweapon_4)
	else:
		Five_label.text = str(pitystandard_5)
		Four_label.text = str(pitystandard_4)

# =========================
# 核心抽卡逻辑
# =========================

func do_gacha():

	var current_pity_5 = 0
	var current_pity_4 = 0

	# 根据当前池子增加对应保底
	if current_banner == "character":
		pityup_5 += 1
		pityup_4 += 1
		current_pity_5 = pityup_5
		current_pity_4 = pityup_4

	elif current_banner == "weapon":
		pityweapon_5 += 1
		pityweapon_4 += 1
		current_pity_5 = pityweapon_5
		current_pity_4 = pityweapon_4

	else:
		pitystandard_5 += 1
		pitystandard_4 += 1
		current_pity_5 = pitystandard_5
		current_pity_4 = pitystandard_4

	var rand_5 = randf()
	var rand_4 = randf()
	# =====================
	# 五星 0.8%
	if current_pity_5 >= 80 or rand_5 < 0.008:
		if current_banner == "character":
			pityup_5 = 0

		elif current_banner == "weapon":
			pityweapon_5 = 0

		else:
			pitystandard_5 = 0
		# =====================
		# 角色池
		# =====================
		if current_banner == "character":
			#大保底
			if guarantee_character:
				guarantee_character = false
				update_guarantee_text(guarantee_character)
				recordList.add_record(up_character,5)
				return "★★★★★ " + up_character
			#判断是否歪
			if randf() < 0.5:
				update_guarantee_text(guarantee_character)
				recordList.add_record(up_character,5)
				return "★★★★★ " + up_character
			else:
				guarantee_character = true
				update_guarantee_text(guarantee_character)
				var standard = standard_five.pick_random()
				recordList.add_record(standard,5)
				return "★★★★★ " + standard
		# =====================
		# 武器池
		# =====================

		elif current_banner == "weapon":
			recordList.add_record(up_weapon,5)
			return "★★★★★ " + up_weapon
		# =====================
		# 常驻池
		# =====================	
		elif current_banner == "standard":
			var standard = standard_five.pick_random()
			recordList.add_record(standard,5)
			return "★★★★★ " + standard

	# 四星 6%
	# =====================
	if current_pity_4 >= 10 or rand_4 < 0.06:

		if current_banner == "character":
			pityup_4 = 0
		elif current_banner == "weapon":
			pityweapon_4 = 0
		else:
			pitystandard_4 = 0

		var four = four_star.pick_random()
		recordList.add_record(four,4)
		return "★★★★ " + four

	# =====================
	# 三星 93.2%
	# =====================
	var three = three_star.pick_random()
	recordList.add_record(three,3)
	return "★★★ " + three

# =========================
# 更新保底文字
# =========================

func update_guarantee_text(guarantee_up):

	var text = ""

	if current_banner == "weapon":
		text = "当前状态：不会歪"
	elif current_banner == "standard":
		text = "当前状态：常驻"
	elif guarantee_up:
		text = "当前状态：已触发"
	else:
		text = "当前状态：未歪"

	guarantee_label.text = text
