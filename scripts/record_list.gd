extends VBoxContainer


func add_record(name, rarity):

	var row = HBoxContainer.new()

	var name_label = Label.new()
	name_label.text = name

	var rarity_label = Label.new()
	rarity_label.text = str(rarity) + "星"

	match rarity:
		3:
			rarity_label.modulate = Color("4dd285ff")
		4:
			rarity_label.modulate = Color("a970ff")
		5:
			rarity_label.modulate = Color("ffd166")

	var spacer = Control.new()
	var spacer2 = Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	spacer2.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var time_label = Label.new()
	var time = Time.get_time_dict_from_system()
	time = str(time.hour) + ":" + str(time.minute) + ":" + str(time.second)
	time_label.text = time
	row.add_child(name_label)
	row.add_child(spacer)
	row.add_child(rarity_label)
	row.add_child(spacer2)
	row.add_child(time_label)
	
	# 在创建name_label后
	name_label.custom_minimum_size.x = 100   # 名字列宽120像素
	rarity_label.custom_minimum_size.x = 50  # 星级列宽60
	time_label.custom_minimum_size.x = 100   # 时间列宽100
	# 并设置标签文字的对齐方式
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	rarity_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	time_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	
	add_child(row,)
	move_child(row, 0) 
