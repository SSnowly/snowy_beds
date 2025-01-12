# snowy_beds
 
## How to set up?

1. Download as Zip or clone the repository
2. Install it on your server
3. Run `ensure snowy_beds` in your server console
4. Its done!

## How to add more beds?
1. Go into the `snowy_beds` folder
2. Go into the `config/client.lua` file
3. Add your beds as this (insdie the beds table):
```lua
    ["name_of_your_bed"] = {
            ["left"] = { -- left side of the bed
                box = {
                    coords = vec3(-797.09, 335.67, 190.4), -- coords of the zone ( u can use /zone box to make one!)
                    size = vec3(1.15, 2.8, 1.25), -- size of the zone
                    rotation = 0.0, -- rotation of the zone ( u can use /zone box to make one!)
                    referenceCorner = "topright" -- topright, topleft, bottomright, bottomleft
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, -0.25), -- offset of the player when he is laying on the bed, we use -0.25 to go downwards
                    heading = 90.0, -- heading the player is facing when he is laying on the bed
                },
                offsets = { --[[ L/R   F/B   U/D ]]
                    entry = vec3(0.5, -1.3, 0.0), -- offset of the player when he is entering the bed (this is where movement goes before anim)
                    scene = vec3(-1.1, -1.3, 0.0), -- offset for the scene, this is sometimes different, other times same.
                    heading = 85.0 -- heading of the anim ( we set player to this aswell, so it just looks at the bed)
                },
            },
            ["right"] = { -- right side of the bed
                box = {
                    coords = vec3(-798.36, 335.7, 190.35), -- coords of the zone ( u can use /zone box to make one!)
                    size = vec3(1.15, 2.8, 1.25), -- size of the zone
                    rotation = 0.0, -- rotation of the zone ( u can use /zone box to make one!)
                    referenceCorner = "topleft" -- topright, topleft, bottomright, bottomleft
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, 0.38), -- offset of the player when he is laying on the bed, we use -0.25 to go downwards
                    heading = 90.0, -- heading the player is facing when he is laying on the bed
                },
                offsets = { --[[ L/R   F/B   U/D ]]
                    entry = vec3(-0.8, -0.6, 0.0), -- offset of the player when he is entering the bed (this is where movement goes before anim)
                    scene = vec3(-0.8, -0.6, 0.0), -- offset for the scene, this is sometimes different, other times same.
                    heading = 230.0 -- heading of the anim ( we set player to this aswell, so it just looks at the bed)
                },
            }
        },
```
4. Save the file
5. Restart the script
6. Its done!


# Credits
- Special Credits to [@BeansFL](https://github.com/BeansFL) for the UI!
- Thanks to Izzy on qbox discord for the idea!
- Me for the code :)
