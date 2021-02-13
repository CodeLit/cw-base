-- [do not obfuscate]

function CWGUI:Variant(tblVariants, action)
	local CBox = vgui.Create('DComboBox')
	CBox:SetSize(100, 20)
	tblVariants = tblVariants or {}

	if #tblVariants > 0 then
		CBox:SetValue(tblVariants[math.random(1, #tblVariants)] or '')

		for _, v in SortedPairs(tblVariants) do
			CBox:AddChoice(v)
		end
	elseif table.Count(tblVariants) > 0 then
		CBox.outKeyValues = tblVariants
		local _, randKey = table.Random(tblVariants)
		CBox:SetValue(randKey)

		for k, v in SortedPairs(tblVariants) do
			CBox:AddChoice(k)
		end
	end

	if action then
		CBox.OnSelect = function(pnl, index, value)
			action(pnl, index, value)
		end
	end

	return CBox
end

function CWGUI:VariantsFrame(title, tblVariants, action)
	local fr = CWGUI:Frame(title)
	fr:SetSize(500, 85)
	fr:Center()
	local var = fr:Add(CWGUI:Variant(tblVariants))
	var:Dock(FILL)
	local btn = fr:Add(CWGUI:AcceptButton())
	btn:Dock(BOTTOM)

	btn.DoClick = function()
		if var.outKeyValues then
			action(var.outKeyValues[var:GetValue()])
		else
			action(var:GetValue())
		end

		fr:Close()
	end

	fr.OnKeyCodePressed = function(pnl, key)
		if key == KEY_ENTER then
			btn.DoClick()
		end
	end

	return fr
end

function CWGUI:ListVariant(tblVariants)

	local list = vgui.Create('DListView')
	list:SetSize(300, 600)
	list:SetMultiSelect(false)
	list:AddColumn(l('Sort'))

	tblVariants = tblVariants or {}

	if #tblVariants > 0 then
		for _, v in pairs(tblVariants) do
			list:AddLine(v)
		end
	elseif table.Count(tblVariants) > 0 then
		list.outKeyValues = tblVariants

		for k, _ in pairs(tblVariants) do
			list:AddLine(k)
		end
	end

	return list
end

function CWGUI:EditableTable(tblData)
	local pnl = self:Panel()
	pnl:SetSize(300,500)
	if isstring(tblData) then tblData = CWStr:FromJson(tblData) or {} end
	pnl.tbl = tblData or {}

	local variant = pnl:Add(self:ListVariant(tblData))
	variant:Dock(FILL)
	pnl.remBtn = pnl:Add(self:DeclineButton(l('Remove')))
	pnl.remBtn:Dock(BOTTOM)
	pnl.remBtn.DoClick = function()
		local line,pnlLine = variant:GetSelectedLine()
		if line then
			variant:RemoveLine(line)
			table.RemoveByValue(pnl.tbl, pnlLine:GetColumnText(1))
		end
	end
	pnl.addBtn = pnl:Add(self:AcceptButton(l('Add')))
	pnl.addBtn:Dock(BOTTOM)
	pnl.addBtn.DoClick = function()
		CWGUI:InputFrame(l('Insert new value'), function(v)
			table.insert(pnl.tbl,v)
			variant:AddLine(v)
		end)
	end
	variant.DoDoubleClick = function(variantPnl,index,line)
		local oldText = line:GetColumnText(1)
		local inFr = CWGUI:InputFrame(l('Insert new value'), function(v)
			table.RemoveByValue(pnl.tbl, oldText)
			table.insert(pnl.tbl,v)
			variant:RemoveLine(index)
			variant:AddLine(v)
		end)
		inFr.mainPanel.editPanel:SetValue(oldText)
	end

	return pnl
end

function CWGUI:ListVariantsFrame(title, tblVariants, action)
	local fr = CWGUI:Frame(title)
	fr:SetSize(500, 500)
	fr:Center()
	local var = fr:Add(CWGUI:ListVariant(tblVariants))
	var:Dock(FILL)
	local btn = fr:Add(CWGUI:AcceptButton())
	btn:Dock(BOTTOM)

	btn.DoClick = function()
		local selected = var:GetSelected()[1]
		if not selected then return end
		local value = selected:GetValue(1)

		if var.outKeyValues then
			action(selected and var.outKeyValues[value] or nil)
		else
			action(selected and value or nil)
		end

		fr:Close()
	end

	fr.OnKeyCodePressed = function(pnl, key)
		if key == KEY_ENTER then
			btn.DoClick()
		end
	end

	return fr
end

function CWGUI:List()
	local list = vgui.Create('DListLayout')

	return list
end

function CWGUI:Tile()
	local list = vgui.Create('DTileLayout')

	return list
end