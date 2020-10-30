--[[
        --FiveM Scripts--
    *Official script by JimmyX#1337*
      *Discord: JimmyX#1337*
        *Don't upload the resource without my permission*
          *All rights reserved ©*]]
    
--[[$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$]]--
--[[$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$> Official Scripts by Shefu <$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$]]--
--[[$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$]]--

sonysclavu = false

RegisterNetEvent('jimmyxdamuielasclavi')
AddEventHandler('jimmyxdamuielasclavi', function(are)
	if are == 0 then
		sonysclavu = true
	elseif are == 1 then
		sonysclavu = false
	end
end)

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and not sonysclavu then		
		end
	end
end)