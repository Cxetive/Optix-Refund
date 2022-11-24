ESX = nil
local Cooldown = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand({"claimrefund"}, "admin", function(xPlayer, args)
    if args.key ~= nil then
    if not Cooldown[xPlayer] then 
        MySQL.Async.fetchAll('SELECT * FROM refund WHERE `test2` = @key ', {
            ['@key'] = args.key
        }, function (results)
            
            for i=1, #results, 1 do
                if results[i].test2 then

                if results[i].type == 'money' then 
                    local player = ESX.GetPlayerFromIdentifier(xPlayer.identifier)
                    TriggerEvent('optix-logging:createlog', "https://discord.com/api/webhooks/1043286185834987540/3RJyawTHU-5Ya6uTtBgrTGi2l2qdxhyCaBNroBOPlDvXyrx5I3HDV2A-1xR9Fx38tjl6","\n **Identifier:** "..xPlayer.identifier.."\n **Key:** "..results[i].test2.."\n **Soort**: "..results[i].type.."\n**Aantal**: "..results[i].amount, false, "Refund Logs")
                    player.addMoney(results[i].amount)
                elseif results[i].type == 'item' then 
                    local player = ESX.GetPlayerFromIdentifier(xPlayer.identifier)
                    TriggerEvent('optix-logging:createlog', "https://discord.com/api/webhooks/1043286185834987540/3RJyawTHU-5Ya6uTtBgrTGi2l2qdxhyCaBNroBOPlDvXyrx5I3HDV2A-1xR9Fx38tjl6","\n **Identifier:** "..xPlayer.identifier.."\n **Key:** "..results[i].test2.."\n **Item **"..results[i].product.."\n **Soort**: "..results[i].type.."\n**Aantal**: "..results[i].amount, false, "Refund Logs")
                    player.addInventoryItem(results[i].product, results[i].amount)
                elseif results[i].type == 'weapon' then 
                    local player = ESX.GetPlayerFromIdentifier(xPlayer.identifier)
                    TriggerEvent('optix-logging:createlog', "https://discord.com/api/webhooks/1043286185834987540/3RJyawTHU-5Ya6uTtBgrTGi2l2qdxhyCaBNroBOPlDvXyrx5I3HDV2A-1xR9Fx38tjl6","\n **Identifier:** "..xPlayer.identifier.."\n **Key:** "..results[i].test2.."\n **Item **"..results[i].product.."\n **Soort**: "..results[i].type.."\n**Aantal**: "..results[i].amount, false, "Refund Logs")
                    player.addWeapon(results[i].product, results[i].amount)
                end
                MySQL.Async.execute('DELETE FROM refund WHERE `test2` = @key', {
                    ['@key'] = results[i].test2
                })
                local player = ESX.GetPlayerFromIdentifier(xPlayer.identifier)
                
                
            end
        end

            Cooldown[xPlayer] = 'KK'
            Citizen.Wait(30000)
            Cooldown[xPlayer] = nil
        end)
    else 
       
    end
end


end, false , {help = ('Optix Refund Systeem'), arguments = {{name = 'key', help = ('De refund key die je hebt gekregen in de ticket.'), type = 'any'}}
})

function chatMessage(target, author, msg)
    TriggerClientEvent('chat:addMessage', target, { --148, 0, 211
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(148, 0, 211, 0.9); border-radius: 3px;"><i class="fas fa-skull-crossbones"></i> '..author..':<br> {1}<br></div>',
        args = { author, msg }
    })
end