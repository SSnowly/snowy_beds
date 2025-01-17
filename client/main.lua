local config = require 'config.client'
local bedSide, isOnBed = nil, false

local animations = {
    enter = {
        ["left"] = {
            dict = "anim@mp_bedmid@left_var_02",
            anim = "f_getin_l_bighouse"
        },
        ["right"] = {
            dict = "anim@mp_bedmid@right_var_02",
            anim = "f_getin_r_bighouse"
        }
    },
    loop = {
        ["left"] = {
            dict = "anim@mp_bedmid@left_var_02",
            anim = "f_sleep_l_loop_bighouse"
        },
        ["right"] = {
            dict = "anim@mp_bedmid@right_var_02",
            anim = "f_sleep_r_loop_bighouse"
        }
    },
    exit = {
        ["right"] = {
            dict = "anim@mp_bedmid@left_var_02",
            anim = "f_getout_l_bighouse"
        },
        ["left"] = {
            dict = "anim@mp_bedmid@right_var_02",
            anim = "f_getout_r_bighouse"
        }
    }
}

local function calculateCornerPosition(boxCoords, boxSize, referenceCorner, heading)
    local heading = heading or 0.0
    RequestModel(`prop_mp_barrier_01`)
    while not HasModelLoaded(`prop_mp_barrier_01`) do
        Wait(0)
    end
    local tempEntity = CreateObject(`prop_mp_barrier_01`, boxCoords.x, boxCoords.y, boxCoords.z, false, false, false)
    if not DoesEntityExist(tempEntity) then
        print("Failed to create temp entity for corner calculation")
        return nil
    end
    FreezeEntityPosition(tempEntity, true)
    SetEntityVisible(tempEntity, false, false)
    SetEntityHeading(tempEntity, heading)
    SetModelAsNoLongerNeeded(`prop_mp_barrier_01`)
    local halfX = boxSize.x / 2
    local halfY = boxSize.y / 2

    local cornerOffsets = {
        bottomleft = {x = -halfX, y = -halfY},
        bottomright = {x = halfX, y = -halfY},
        topleft = {x = -halfX, y = halfY}, 
        topright = {x = halfX, y = halfY}
    }

    local offset = cornerOffsets[referenceCorner or "bottomleft"]
    local cornerPos = GetOffsetFromEntityInWorldCoords(tempEntity, offset.x, offset.y, 0.0)

    if config.debug then
        lib.zones.sphere({
            coords = cornerPos,
            radius = 0.3,
            debug = true
        })
    end

    DeleteEntity(tempEntity)
    return cornerPos
end

local function useBed(side, bedId)
    local ped = PlayerPedId()
    local bedData = config.beds[bedId]
    local boxCoords = bedData[side].box.coords
    local boxSize = bedData[side].box.size
    local targetHeading = bedData[side].box.rotation + bedData[side].offsets.heading
    local bottomLeftCorner = calculateCornerPosition(boxCoords, boxSize, bedData[side].box.referenceCorner, bedData[side].box.rotation)
    local entryPos = vector3(
        bottomLeftCorner.x + bedData[side].offsets.entry.x,
        bottomLeftCorner.y + bedData[side].offsets.entry.y,
        bottomLeftCorner.z + bedData[side].ped.bedOffset.z
    )
    print(entryPos)
    TaskGoStraightToCoord(ped, entryPos.x, entryPos.y, entryPos.z, 1.4, 1000, 180, 0.5)
    while GetScriptTaskStatus(ped, "SCRIPT_TASK_GO_STRAIGHT_TO_COORD") ~= 7 do
        Wait(100)
    end
    print(GetEntityCoords(ped))
    TaskAchieveHeading(ped, targetHeading, 1000)
    Wait(1000)
    RequestAnimDict(animations.enter[side].dict)
    while not HasAnimDictLoaded(animations.enter[side].dict) do
        Wait(0)
    end
    
    
    local scene = NetworkCreateSynchronisedScene(
        bottomLeftCorner.x + bedData[side].offsets.scene.x,
        bottomLeftCorner.y + bedData[side].offsets.scene.y,
        bottomLeftCorner.z + bedData[side].ped.bedOffset.z,
        0.0, 0.0, targetHeading,
        2,
        true,
        true,
        1.0,
        0,
        1.0
    )
    
    
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, bottomLeftCorner.x, bottomLeftCorner.y, bottomLeftCorner.z + 2.5)
    
    CreateThread(function()
        while DoesCamExist(cam) do
            local pedPos = GetEntityCoords(ped)
            PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z)
            Wait(0)
        end
    end)
    
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    NetworkAddPedToSynchronisedScene(
        ped,
        scene,
        animations.enter[side].dict,
        animations.enter[side].anim,
        8.0,
        -8.0,
        0,
        0,
        1000.0,
        0
    )
    SetEntityCollision(ped, false, false)
    NetworkStartSynchronisedScene(scene)    
    local enterDuration = GetAnimDuration(animations.enter[side].dict, animations.enter[side].anim)
    Wait((enterDuration * 1000) - 100)
    local camRot = GetCamRot(cam, 2)
    local camFov = GetCamFov(cam)

    SetGameplayCamRelativeRotation(camRot.x, camRot.y, camRot.z)
    SetGameplayCamRelativePitch(camRot.x, 1.0)

    RenderScriptCams(false, true, 500, true, true)
    DestroyCam(cam, false)
    SendNuiMessage(json.encode({
        action = "show",
        data = {
          { key = "E", text = "Get Up" },
          { key = "R", text = "Quit" },
          { key = "Q", text = "Logout" }
        }
    }))

    RequestAnimDict(animations.loop[side].dict)
    while not HasAnimDictLoaded(animations.loop[side].dict) do
        Wait(0)
    end

    TaskPlayAnim(ped, animations.loop[side].dict, animations.loop[side].anim, 
        8.0, -8.0, -1, 2, 0, false, false, false)

    bedSide = side
end

local function CreateBedInteractions()
    if config.useTarget then
        for bedId, bedData in pairs(config.beds) do
        
            if bedData.left and bedData.left.box then
                exports.ox_target:addBoxZone({
                    coords = bedData.left.box.coords,
                    size = bedData.left.box.size,
                    rotation = bedData.left.box.rotation,
                    debug = config.debug,
                    options = {
                        {
                            name = 'lay_left_' .. bedId,
                            label = 'Lay Down (Sleep)',
                            canInteract = function()
                                return not isOnBed
                            end,
                            onSelect = function()
                                isOnBed = true
                                useBed('left', bedId)
                            end
                        },
                    }
                })
            end
    
            
            if bedData.right and bedData.right.box then
                exports.ox_target:addBoxZone({
                    coords = bedData.right.box.coords,
                    size = bedData.right.box.size,
                    rotation = bedData.right.box.rotation,
                    debug = config.debug,
                    options = {
                        {
                            name = 'lay_right_' .. bedId,
                            label = 'Lay Down (Sleep)',
                            canInteract = function()
                                return not isOnBed
                            end,
                            onSelect = function()
                                isOnBed = true
                                useBed('right', bedId)
                            end
                        },
                    }
                })
            end
        end
    else
        local duiHandlers = {}
        
        for bedId, bedData in pairs(config.beds) do
            if bedData.left and bedData.left.box then
                local point = lib.points.new({
                    coords = bedData.left.box.coords,
                    distance = 3,
                    id = "bed_hold_left_" .. bedId
                })
                
                function point:onEnter()
                    print(self.id)
                    duiHandlers[self.id] = exports.LGF_SpriteTextUi:HandleHoldTextUI(self.id, {
                        Visible = true,
                        Message = 'Lay Down (Sleep)',
                        Bind = "E",
                        CircleColor = "teal",
                        UseOnlyBind = false,
                        BindToHold = 38,
                        TimeToHold = 2,
                        DistanceHold = 2,
                        Coords = self.coords,
                        canInteract = function()
                            return not isOnBed
                        end,
                        onCallback = function()
                            isOnBed = true
                            useBed('left', bedId)
                        end
                    })
                    self.duiHandler = duiHandlers[self.id]
                end

                function point:onExit()
                    exports.LGF_SpriteTextUi:CloseHoldTextUI(self.id)
                    self.duiHandler = nil
                end

                function point:nearby()
                    exports.LGF_SpriteTextUi:Draw3DSprite({
                        duiHandler = self.duiHandler,
                        coords = self.coords,
                        maxDistance = self.distance,
                    })
                end
            end

            if bedData.right and bedData.right.box then
                local point = lib.points.new({
                    coords = bedData.right.box.coords,
                    distance = 3,
                    id = "bed_hold_right_" .. bedId
                })

                function point:onEnter()
                    print(self.id)
                    duiHandlers[self.id] = exports.LGF_SpriteTextUi:HandleHoldTextUI(self.id, {
                        Visible = true,
                        Message = 'Lay Down (Sleep)',
                        Bind = "E",
                        CircleColor = "teal",
                        UseOnlyBind = false,
                        BindToHold = 38,
                        TimeToHold = 2,
                        DistanceHold = 2,
                        Coords = self.coords,
                        canInteract = function()
                            return not isOnBed
                        end,
                        onCallback = function()
                            isOnBed = true
                            useBed('right', bedId)
                        end
                    })
                    self.duiHandler = duiHandlers[self.id]
                end

                function point:onExit()
                    exports.LGF_SpriteTextUi:CloseHoldTextUI(self.id)
                    self.duiHandler = nil
                end

                function point:nearby()
                    exports.LGF_SpriteTextUi:Draw3DSprite({
                        duiHandler = self.duiHandler,
                        coords = self.coords,
                        maxDistance = self.distance,
                    })
                end
            end
        end
    end
end


CreateBedInteractions()


RegisterCommand('fixme', function()
    if IsScreenFadedOut() then
        DoScreenFadeIn(1000)
    end
    SetEntityCollision(PlayerPedId(), true, true)
    SetPedGravity(PlayerPedId(), true)
end)

lib.addKeybind({
    name = 'getoutofbed',
    description = 'Get out of bed (Don\'t Change)',
    defaultKey = 'E',
    onPressed = function()
        if isOnBed and bedSide then
            local side = bedSide == 'left' and 'right' or 'left'
            bedSide = nil
            isOnBed = false
            SendNuiMessage(json.encode({
                action = "hide"
              }))
            local ped = PlayerPedId()
            SetEntityCollision(ped, false, false)
            
            RequestAnimDict(animations.exit[side].dict)
            while not HasAnimDictLoaded(animations.exit[side].dict) do
                Wait(0)
            end
            
            
            TaskPlayAnim(ped, animations.exit[side].dict, animations.exit[side].anim,
                8.0, -8.0, -1, 512, 0, false, false, false)  
            
            
            local exitDuration = GetAnimDuration(animations.exit[side].dict, animations.exit[side].anim)
            Wait((exitDuration * 1000) - 1000)
            SetEntityCollision(ped, true, true)  
            
            ClearPedTasks(ped)
        end
    end
})

lib.addKeybind({
    name = 'logout',
    description = 'Logout (Don\'t Change)',
    defaultKey = 'Q',
    onPressed = function()
        if isOnBed and bedSide then 
            SendNuiMessage(json.encode({
                action = "hide"
            }))
            DoScreenFadeOut(1000)
            Wait(1000)
            bedSide = nil
            isOnBed = false
            TriggerServerEvent('snowy_bed:server:logout')
        end
    end
})

lib.addKeybind({
    name = 'quit',
    description = 'Quit (Don\'t Change)',
    defaultKey = 'R',
    onPressed = function()
        if isOnBed and bedSide then
            SendNuiMessage(json.encode({
                action = "hide"
            }))
            DoScreenFadeOut(1000)
            Wait(1000)
            bedSide = nil
            isOnBed = false
            TriggerServerEvent('snowy_bed:server:quit')
        end
    end
})
