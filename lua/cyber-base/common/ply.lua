CW.Ply = CW.Ply or {}

function CW.Ply:GetByNick(nick)
	for _, ply in pairs(player.GetHumans()) do
		if (string.find(string.lower(ply:Nick()), string.lower(nick), 1, true) ~= nil) then return ply end
	end
end

function CW.Ply:GetRPNickName(steamid64)
	local data = sql.Query("SELECT * FROM darkrp_player WHERE uid = '" .. steamid64 .. "';")
	if not data or not istable(data) then return end

	return data[1].rpname
end

local PLY = FindMetaTable('Player')

function PLY:StID()
	if not IsValid(self) then return end
	return CWStr:ToSID(self:SteamID())
end

function PLY:CID()
	if not IsValid(self) then return end
	local char = self:GetCharacter()
	if !char then return end
	return char:GetID()
end

function PLY:IsModerator()
	return self:GetRights('Модератор')
end

function PLY:IsDeveloper()
	return self:GetRights('Разработчик')
end

function PLY:IsVehicleDriver()
	if !self:InVehicle() then return false end
	local veh = self:GetVehicle()
	if !IsValid(veh) then return false end
	return !veh.VC_ExtraSeat
end

function PLY:IsShootsFromCarWindow()
	return tobool(self:InVehicle() and !self:IsVehicleDriver() and self:GetNWBool('ShootsFromCarWindow'))
end

hook.Add('KeyPress','VC Compatible Shoot From Window',function(ply,key)
	if key == IN_JUMP then
		timer.Simple(.15,function()
			if !IsValid(ply) then return end
			ply:SetNWBool('ShootsFromCarWindow',ply.VC_EnteredDriveByMode)
		end)
	end
end)

function PLY:GetOrderPrice()
	return self:GetInfoNum('nl_order_price',5000)
end


function PLY:NUse(ent)
-- 	return NAbils.Killer:OpenRequestMenu()
	-- if IsValid(ent) then
	-- 	if ent:IsPlayer() then
	-- 		if ent:IsKiller() then
	-- 			if ent:HasOrder() then
	-- 				LocalPlayer():Notify('Этот гражданин уже имеет заказ!')
	-- 			else
	-- 				return NAbils.Killer:OpenRequestMenu()
	-- 			end
	-- 		end
	-- 	end
	-- end
end

function PLY:GetClaimedZone()
	for _,v in pairs(RPZones:getList()) do
		if v:getOwnerCID() == self:CID() then
			return v
		end
	end
end

-- np(N:GetOwner():IsShootsFromCarWindow())

-- -- ИСКАТЬ В ХУКАХ НУЖНЫЙ ВЫЗОВ ХУКА
--
-- OriginalCall = OriginalCall or hook.Call
--
-- hook.Call = function(eventName,gamemodeTable,args)
-- 	if !table.HasValue({'DrawShield','ShouldPlayerDrowned','DrawOverlay','PreDrawHalos','ShouldBarDraw','PostDrawInventory','ShouldHideBars','ShouldDrawCrosshair','ShouldPopulateEntityInfo','HUDShouldDraw','VC_CD_canRenderInfo','HUDDrawTargetID','HUDDrawPickupHistory','DrawDeathNotice','AdjustBlurAmount','VC_RM_canRenderInfo','VC_CD_CanRenderInfo','CanDrawAmmoHUD'},eventName) then
-- 		np(eventName)
-- 	end
-- 	OriginalCall(eventName,gamemodeTable,args)
-- end