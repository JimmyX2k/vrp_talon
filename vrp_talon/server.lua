MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_dmvschool")


AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
  if user_id then
    local numar = vRP.getInventoryItemAmount({user_id,"car_doc"})
    if tonumber(numar) > 0 then
      TriggerClientEvent('jimmyxdamuielasclavi',source,0)
    end
  end
end)

local oferapermis = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Oferi Permis De Conducere"})
      vRP.request({nplayer,"Vrei sa platesti : 25000 Lei pentru a primi Permis De Conducere ?",15,function(nplayer,ok)
        if ok then
          local numar = vRP.getInventoryItemAmount({nuser_id,"car_doc"}) 
          if tonumber(numar) < 1 then
            if vRP.tryPayment({nuser_id,25000}) then
              vRPclient.notify(player,{"Jucator-ul : ~g~"..nuser_id.." ~w~a platit ~g~25000 Lei ~w~pentru talon"})
              vRPclient.notify(nplayer,{"Ai platit ~g~25000 Lei ~w~pentru talon"})
              vRP.giveInventoryItem({nuser_id,"car_doc",1,false})
              TriggerClientEvent('jimmyxdamuielasclavi',nplayer,0)
            else
              vRPclient.notify(player,{"~r~Jucator-ul : ~g~"..nuser_id.." ~w~nu are suficienti bani pentru a semna contract-ul de talon"})
              vRPclient.notify(nplayer,{"~r~Nu ai ~g~25000 Lei ~w~pentru pentru a semna contract-ul de talon"})
            end
          else
            vRPclient.notify(player,{"~r~Jucator-ul : ~g~"..nuser_id.." ~w~are deja talon"})
          end
        else
          vRPclient.notify(player,{"~r~Jucator-ul : ~g~"..nuser_id.." ~w~a refuzat talon-ul"})
          vRPclient.notify(nplayer,{"~r~Ai refuzat talonul"})
        end
      end})
    else
      vRPclient.notify(player,{"~r~Nici un jucator in preajma"})
    end
  end)
end, "Ofera permis-ul"}

if GetCurrentResourceName() ~= "vrp_permis" then
  print("                                             #")
  print("                                             ###")
  print("###### ###### ###### ###### ######  ##############")
  print("#      #    # #    # #    # #    #  ################    Schimba-i numele '" .. GetCurrentResourceName() .. "' inapoi la 'vrp_arma' ghertoiule")
  print("###    ###### ###### #    # ######  ##################  altfel scriptu` asta blana nu va funtiona ratatule!")
  print("#      # ##   # ##   #    # # ##    ################    lasa asa numele cum a fost retardule!!!")
  print("###### #   ## #   ## ###### #   ##  ##############")
  print("                                             ###")
  print("                                             #")
end

local cere = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Ceri talon..."})
      vRP.request({nplayer,"Vrei sa ii arati talon-ul  ?",15,function(nplayer,ok)
        if ok then
          local numar = vRP.getInventoryItemAmount({nuser_id,"talon"})
          if numar > 0 then
            vRPclient.notify(player,{"Talon : ~g~Da"})
          else
            vRPclient.notify(player,{"Talon : ~r~Nu"})
          end
        else
          vRPclient.notify(player,{"~r~A refuzat cererea"})
        end
      end})
    else
      vRPclient.notify(player,{"~r~Nici un jucator in preajma"})
    end
  end)
end, "Cere permis-ul de conducere celui mai apropriat jucator."}


local confisca = {function(player, choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      local numar = vRP.getInventoryItemAmount({nuser_id,"car_doc"})
      if numar > 0 then
        vRPclient.notify(player,{"~r~I-ai confiscat talon-ul  jucatorului : ~g~"..nuser_id.." !"})
        vRPclient.notify(nplayer,{"~r~Garda ti-a fost confiscat talon-ul"})
        vRP.tryGetInventoryItem({nuser_id,"car_doc",1,false})
        TriggerClientEvent('jimmyxdamuielasclavi',nplayer,1)
      end
    else
      vRPclient.notify(player,{"~r~Nici un jucator in preajma"})
    end
  end)
end, "Confisca talon"}

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}


    if vRP.isUserInFaction({user_id, "cop"}) then --Permisia
       choices["Verifica Talon"] = cere
       choices["Confisca Talon"] = confisca
       choices["Ofera Talon"] = oferapermis
    end
	
    add(choices)
  end
end})

