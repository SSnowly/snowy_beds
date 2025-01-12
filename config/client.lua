return {
    debug = false, -- true - show debug zones, useful for setting up new beds. (for corners)
    useTarget = true, -- true - use ox_target, false - use LGF_SpriteTextUI (https://github.com/ENT510/LGF_SpriteTextUI)
    beds = {
        ["modernapartment1"] = {
            ["left"] = {
                box = {
                    coords = vec3(-797.11, 335.64, 220.0),
                    size = vec3(1.25, 2.9, 1.45),
                    rotation = 0.0,
                    referenceCorner = "topright"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, -0.1),
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(0.5, -1.3, 0.0),
                    scene = vec3(-1.1, -1.3, 0.0),
                    heading = 85.0
                },
            },
            ["right"] = {
                box = {
                    coords = vec3(-798.33, 335.63, 220.0),
                    size = vec3(1.25, 2.9, 1.45),
                    rotation = 0.0,
                    referenceCorner = "topleft"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, 0.45),
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(-0.8, -0.6, 0.0),
                    scene = vec3(-0.8, -0.6, 0.0), 
                    heading = 230.0
                },
                
            }
        },
        ["modernapartment2"] = {
            ["left"] = {
                box = {
                    coords = vec3(-793.78, 333.32, 210.5),
                    size = vec3(2.8, 1.15, 1.4),
                    rotation = 0.0,
                    referenceCorner = "bottomright"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, -0.3),
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(-0.9, -0.5, 0.0),
                    scene = vec3(-1.1, 1.0, 0.0),
                    heading = 355.0
                },
            },
            ["right"] = {
                box = {
                    coords = vec3(-793.76, 334.45, 210.5),
                    size = vec3(2.8, 1.15, 1.4),
                    rotation = 0.0,
                    referenceCorner = "topright"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, 0.45),
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(-0.5, 0.9, 0.0),
                    scene = vec3(-0.5, 0.9, 0.0),
                    heading = 140.0
                },
            }
        },
        ["modernapartment3"] = {
            ["left"] = {
                box = {
                    coords = vec3(-763.86, 322.17, 199.0),
                    size = vec3(1.25, 2.85, 1.75),
                    rotation = 0.0,
                    referenceCorner = "bottomleft"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, -0.05),
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(-0.9, 1.3, 0.0),
                    scene = vec3(1.1, 1.3, 0.0),
                    heading = 265.0
                },
            },
            ["right"] = {
                box = {
                    coords = vec3(-762.67, 322.16, 199.0),
                    size = vec3(1.25, 2.85, 1.75),
                    rotation = 0.0,    
                    referenceCorner = "bottomright"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, 0.55),
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(0.8, 0.6, 0.0),
                    scene = vec3(0.8, 0.6, 0.0), 
                    heading = 50.0
                },
            }
        },
        ["modernapartment4"] = {
            ["left"] = {
                box = {
                    coords = vec3(-796.3, 338.31, 201.0),
                    size = vec3(1.15, 2.8, 1.25),
                    rotation = 90.0,
                    referenceCorner = "bottomleft"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, -0.2),
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(-1.0, -1.0, 0.0),
                    scene = vec3(-1.0, 1.0, 0.0),
                    heading = 265.0
                },
            },
            ["right"] = {
                box = {
                    coords = vec3(-796.3, 339.25, 201.0),
                    size = vec3(1.15, 2.8, 1.25),
                    rotation = 90.0,
                    referenceCorner = "bottomright"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, 0.45),
                    heading = 180.0,
                },
                offsets = {
                    entry = vec3(-0.4, 0.9, 0.0),
                    scene = vec3(-0.4, 0.9, 0.0),
                    heading = 50.0
                },
            }
        },
        ["modernapartment5"] = {
            ["left"] = {
                box = {
                    coords = vec3(-797.09, 335.67, 190.4), 
                    size = vec3(1.15, 2.8, 1.25),
                    rotation = 0.0,
                    referenceCorner = "topright"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, -0.25), 
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(0.5, -1.3, 0.0),
                    scene = vec3(-1.1, -1.3, 0.0),
                    heading = 85.0
                },
            },
            ["right"] = {
                box = {
                    coords = vec3(-798.36, 335.7, 190.35),
                    size = vec3(1.15, 2.8, 1.25),
                    rotation = 0.0,
                    referenceCorner = "topleft"
                },
                ped = {
                    bedOffset = vec3(0.0, 0.0, 0.38),
                    heading = 90.0,
                },
                offsets = {
                    entry = vec3(-0.8, -0.6, 0.0),
                    scene = vec3(-0.8, -0.6, 0.0),
                    heading = 230.0
                },
            }
        },
    }
}