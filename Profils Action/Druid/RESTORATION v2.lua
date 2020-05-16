-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local HealingEngine                             = Action.HealingEngine
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")
local Action									= Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell								= Action.FrameHasSpell
local Azerite									= LibStub("AzeriteTraits")
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local wipe                                      = wipe 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local TMW                                       = TMW
local _G, setmetatable                          = _G, setmetatable
local select, unpack, table, pairs              = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_DRUID_RESTORATION] = {
    -- Racial
    ArcaneTorrent                             = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                                 = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                                 = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                             = Create({ Type = "Spell", ID = 274738     }),
    Berserking                                = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                               = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                               = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                                  = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                                  = Create({ Type = "Spell", ID = 20549     }),
    BullRush                                  = Create({ Type = "Spell", ID = 255654     }),    
    GiftofNaaru                               = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                                = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                                 = Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                               = Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                         = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                              = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                        = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Roots   
    EntanglingRoots                           = Create({ Type = "Spell", ID = 339    }),
    MassEntanglement                          = Create({ Type = "Spell", ID = 102359, isTalent = true   }), 
    -- Disorient
	Cyclone                                   = Create({ Type = "Spell", ID = 33786, isTalent = true   }), -- PvP Talent
	-- Stun
	MightyBash                                = Create({ Type = "Spell", ID = 5211, isTalent = true   }),
	-- Knockbacks
	Typhoon                                   = Create({ Type = "Spell", ID = 132469, isTalent = true   }),
    -- Hots
    Lifebloom                                 = Create({ Type = "Spell", ID = 33763     }),
	Rejuvenation                              = Create({ Type = "Spell", ID = 774     }),
	RejuvenationGermimation                   = Create({ Type = "Spell", ID = 155777    }),
    WildGrowth                                = Create({ Type = "Spell", ID = 48438     }),
	CenarionWard                              = Create({ Type = "Spell", ID = 102351, isTalent = true     }),
	-- Direct Heals
	Regrowth                                  = Create({ Type = "Spell", ID = 8936     }),
	Swiftmend                                 = Create({ Type = "Spell", ID = 18562     }),
    -- Self Defensives
    Barkskin                                  = Create({ Type = "Spell", ID = 22812     }),
	-- Cooldowns
	Ironbark                                  = Create({ Type = "Spell", ID = 102342     }),
	Tranquility                               = Create({ Type = "Spell", ID = 740     }),
    Innervate                                 = Create({ Type = "Spell", ID = 29166     }),
    -- Shapeshift
    TravelForm                                = Create({ Type = "Spell", ID = 783     }), 
    BearForm                                  = Create({ Type = "Spell", ID = 5487     }), 
    CatForm                                   = Create({ Type = "Spell", ID = 768     }), 
    AquaticForm                               = Create({ Type = "Spell", ID = 276012     }), 	
    -- Utilities
	UrsolVortex                               = Create({ Type = "Spell", ID = 102793     }),
    NaturesCure                               = Create({ Type = "Spell", ID = 88423     }),  
	Dash                                      = Create({ Type = "Spell", ID = 1850     }), 
	Rebirth                                   = Create({ Type = "Spell", ID = 20484     }),  -- Combat Rez
	Revive                                    = Create({ Type = "Spell", ID = 50769     }), 
	Hibernate                                 = Create({ Type = "Spell", ID = 2637     }), 
	Soothe                                    = Create({ Type = "Spell", ID = 2908     }), 
	Prowl                                     = Create({ Type = "Spell", ID = 5215     }), 
	Revitalize                                = Create({ Type = "Spell", ID = 212040     }), 
	WildCharge                                = Create({ Type = "Spell", ID = 102401, isTalent = true     }),
    -- Healing Spells       
    Efflorescence                             = Create({ Type = "Spell", ID = 145205     }),
	Renewal                                   = Create({ Type = "Spell", ID = 108238, isTalent = true     }),
	-- Talents
	SouloftheForest                           = Create({ Type = "Spell", ID = 114108, isTalent = true, Hidden = true     }),
	IncarnationTreeofLife                     = Create({ Type = "Spell", ID = 33891, isTalent = true     }),
	IncarnationTreeofLifeBuff                 = Create({ Type = "Spell", ID = 117679, Hidden = true     }),
	Flourish                                  = Create({ Type = "Spell", ID = 197721, isTalent = true     }),
	Photosynthesis                            = Create({ Type = "Spell", ID = 274902, isTalent = true, Hidden = true     }),
	Germination                               = Create({ Type = "Spell", ID = 155675, isTalent = true, Hidden = true     }),
	GuardianAffinity                          = Create({ Type = "Spell", ID = 197491, isTalent = true, Hidden = true     }),
	FeralAffinity                             = Create({ Type = "Spell", ID = 197490, isTalent = true, Hidden = true     }),
	BalanceAffinity                           = Create({ Type = "Spell", ID = 197632, isTalent = true, Hidden = true     }),	
	InnerPeace                                = Create({ Type = "Spell", ID = 197073, isTalent = true, Hidden = true     }),
	Stonebark                                 = Create({ Type = "Spell", ID = 197061, isTalent = true, Hidden = true     }),
	Prosperity                                = Create({ Type = "Spell", ID = 200383, isTalent = true, Hidden = true     }),
	Abundance 	                              = Create({ Type = "Spell", ID = 207383, isTalent = true, Hidden = true     }),
	SpringBlossoms                            = Create({ Type = "Spell", ID = 207385, isTalent = true, Hidden = true     }),
	Cultivation                               = Create({ Type = "Spell", ID = 200390, isTalent = true, Hidden = true     }),
    -- PvP Talents
	Disentanglement                           = Create({ Type = "Spell", ID = 233673, isTalent = true, Hidden = true     }),
	EntanglingBark                            = Create({ Type = "Spell", ID = 247543, isTalent = true, Hidden = true     }),
	EarlySpring                               = Create({ Type = "Spell", ID = 203624, isTalent = true, Hidden = true     }),
	Nourish                                   = Create({ Type = "Spell", ID = 289022, isTalent = true     }),
	Overgrowth                                = Create({ Type = "Spell", ID = 203651, isTalent = true     }),
	Thorns                                    = Create({ Type = "Spell", ID = 236696, isTalent = true     }),
	DeepRoots                                 = Create({ Type = "Spell", ID = 233755, isTalent = true, Hidden = true     }),		
    MarkoftheWild                             = Create({ Type = "Spell", ID = 289318, isTalent = true     }),
	FocusedGrowth                             = Create({ Type = "Spell", ID = 203553, isTalent = true, Hidden = true     }),
	MasterShapeshifter                        = Create({ Type = "Spell", ID = 289237, isTalent = true     }),
	-- Azerites
    AutumnLeaves                              = Create({ Type = "Spell", ID = 274432, Hidden = true     }),
	EarlyHarvest                              = Create({ Type = "Spell", ID = 287251, Hidden = true     }),
	GroveTending                              = Create({ Type = "Spell", ID = 279778, Hidden = true     }),
	LivelySpirit                              = Create({ Type = "Spell", ID = 279642, Hidden = true     }),
	RampantGrowth                             = Create({ Type = "Spell", ID = 278515, Hidden = true     }),
	WakingDream                               = Create({ Type = "Spell", ID = 278513, Hidden = true     }),
	-- Offensives Spells
    Moonfire                                  = Create({ Type = "Spell", ID = 8921     }),
	MoonfireDebuff                            = Create({ Type = "Spell", ID = 164812     }),
	Sunfire                                   = Create({ Type = "Spell", ID = 93402     }),
	SunfireDebuff                             = Create({ Type = "Spell", ID = 164815     }),
	SolarWrath                                = Create({ Type = "Spell", ID = 5176     }),
	Mutilate                                  = Create({ Type = "Spell", ID = 33917     }),
	-- Offensives abilities with Affinity
	-- Boomkin
	Starsurge                                 = Create({ Type = "Spell", ID = 197626     }),
	LunarStrike                               = Create({ Type = "Spell", ID = 197628     }),
	MoonkinForm                               = Create({ Type = "Spell", ID = 24858     }),
	-- Guardian
	FrenziedRegeneration                      = Create({ Type = "Spell", ID = 22842     }),
	Ironfur                                   = Create({ Type = "Spell", ID = 192081     }),
	Thrash                                    = Create({ Type = "Spell", ID = 106832     }),
	Mangle                                    = Create({ Type = "Spell", ID = 33917   }),
	-- Feral
	Shred                                     = Create({ Type = "Spell", ID = 5221     }),
	Rip                                       = Create({ Type = "Spell", ID = 1079     }),
	FerociousBite                             = Create({ Type = "Spell", ID = 22568     }),
	Rake                                      = Create({ Type = "Spell", ID = 1822     }),
	RakeDebuff                                = Create({ Type = "Spell", ID = 155722	,    Hidden = true }),
	Swipe                                     = Create({ Type = "Spell", ID = 106785 }),
    -- Movememnt    

    -- Items
    PotionofReconstitution                    = Create({ Type = "Potion", ID = 168502     }),     
    CoastalManaPotion                         = Create({ Type = "Potion", ID = 152495     }), 
    -- Hidden 
	ClearCasting                              = Create({ Type = "Spell", ID = 16870,    Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep  
    TigerTailSweep                            = Create({ Type = "Spell", ID = 264348,     isTalent = true, Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep    
    RisingMist                                = Create({ Type = "Spell", ID = 274909,     isTalent = true, Hidden = true }), -- 7/3 Talent "Fistweaving Rotation by damage healing"
    SpiritoftheCrane                          = Create({ Type = "Spell", ID = 210802,     isTalent = true, Hidden = true }), -- 3/2 Talent "Mana regen by BlackoutKick"
    TeachingsoftheMonastery                   = Create({ Type = "Spell", ID = 202090,     Hidden = true }), -- Buff condition for Blackout Kick
    PoolResource                              = Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    DummyTest                                 = Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon    
	--Mythic Plus Spells 
	Quake                                     = Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
	Burst                                     = Create({ Type = "Spell", ID = 240443, Hidden = true     }), -- Bursting (Mythic Plus Affix) Upon death the creature Bursts, inflicting damage equal to (35 / 10)% of maximum health every 1 sec.
	GrievousWound                             = Create({ Type = "Spell", ID = 240559, Hidden = true     }), -- Grievous (Mythic Plus Affix) 2% of a player's maximum health every 3 sec
    Slow                                      = Create({ Type = "Spell", ID = 313255, Hidden = true     }), -- Shadhar slow
	Fixate                                    = Create({ Type = "Spell", ID = 318078, Hidden = true     }), -- Wrathion Fixate
}

Action:CreateEssencesFor(ACTION_CONST_DRUID_RESTORATION)
local A = setmetatable(Action[ACTION_CONST_DRUID_RESTORATION], { __index = Action })

local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForStun								= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC								= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun					= {"CCTotalImun", "StunImun"},
	AuraForDisableMag						= {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AuraForInterrupt						= {"TotalImun", "DamagePhysImun", "KickImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local player = "player"
local targettarget = "targettarget"
local target = "target"
local mouseover = "mouseover"

-- Call to avoid lua limit of 60upvalues 
-- Call RotationsVariables in each function that need these vars
local function RotationsVariables()
    UseDBM = GetToggle(1 ,"DBM") -- Don't call it DBM else it broke all the global DBM var used by another addons
    Potion = GetToggle(1, "Potion")
    Racial = GetToggle(1, "Racial")
    HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
	MouseOver = GetToggle(2, "mouseover")
    -- ProfileUI vars
    TrinketMana = GetToggle(2, "TrinketMana")
	MythicPlusLogic = GetToggle(2, "MythicPlusLogic")
	StopCastOverHeal = GetToggle(2, "StopCastOverHeal")
	StopCastQuake = GetToggle(2, "StopCastQuake")
	StopCastQuakeSec = GetToggle(2, "StopCastQuakeSec")

end

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 


       
end 
A[1] = function(icon)

    -- Cyclone AntiFake CC Focus
    local cast = Unit(player):CastTime(A.Cyclone.ID)
    if A.Cyclone:IsReady("focus") and
    A.Cyclone:IsSpellLearned() and
    (
        cast == 0 or
        Unit(player):GetCurrentSpeed() == 0 
    ) and
    A.Cyclone:IsSpellInRange("focus") and
    Unit("focus"):HasBuffs("CCMagicImun") <= cast  
    then
        return A.Cyclone:Show(icon)                  
    end 
			
    -- AntiFake Bash Cat / Bear form
    if A.MightyBash:IsReady("focus") and
    Player:GetStance()~=2 and
    Player:GetStance()~=1 and
    A.WildCharge:IsSpellLearned() and -- Charge
    A.WildCharge:GetCooldown()==0 and
    A.WildCharge:IsSpellInRange("focus") and
    A.MightyBash:IsSpellLearned() and -- Bash
    A.MightyBash:GetCooldown() == 0 and
    not A.MightyBash:IsSpellInRange("focus") and
    A.MightyBash:AbsentImun("focus", Temp.TotalAndPhys, true)
    then
        return A.MightyBash:Show(icon)                  
    end 
			
    -- AntiFake Bash Jump
    if A.WildCharge:IsReady("focus") and
    (
        Player:GetStance()==2 or
        Player:GetStance()==1
    ) and
    A.WildCharge:IsSpellLearned() and -- Charge
    A.WildCharge:GetCooldown()==0 and
    A.WildCharge:IsSpellInRange("focus") and
    A.MightyBash:IsSpellLearned() and -- Bash
    A.MightyBash:GetCooldown() == 0 and
    not A.MightyBash:IsSpellInRange("focus") and
    A.WildCharge:AbsentImun("focus", Temp.TotalAndPhys, true)
    then
        return A.WildCharge:Show(icon)                  
    end 
			
    -- AntiFake Bash
    if A.MightyBash:IsReady("focus") and 
    A.MightyBash:IsSpellLearned() and
    A.MightyBash:IsSpellInRange("focus") and
    A.MightyBash:AbsentImun("focus", Temp.TotalAndPhys, true)
    then
        return A.MightyBash:Show(icon)                  
    end 
                                                           
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy(mouseover) then 
        unit = mouseover
    elseif A.IsUnitEnemy(target) then 
        unit = target
    elseif A.IsUnitEnemy(targettarget) then 
        unit = targettarget
    end 
    
    if unit then         
        local total, sleft, _, _, _, notKickAble = Unit(unit):CastTime()
        if sleft > 0 then                                     

            -- Typhun Target
            if not notKickAble and A.Typhoon:IsReady(unit, nil, nil, true) and A.Typhoon:AbsentImun("target", Temp.TotalAndMag, true) and
            A.Typhoon:IsSpellLearned() and
            A.Typhoon:GetCooldown() and
            Unit("target"):CanInterract(15)			
			then
                return A.Typhoon:Show(icon)                                                  
            end 

            -- Typhun MouseOver Restor Only
            if not notKickAble and A.Typhoon:IsReady(unit, nil, nil, true) and A.Typhoon:AbsentImun("mouseover", Temp.TotalAndMag, true) and
            A.Typhoon:IsSpellLearned() and
            A.Typhoon:GetCooldown() and
            Unit("mouseover"):CanInterract(15)
			then
                return A.Typhoon:Show(icon)                                                  
            end
			
            -- Typhun TargetTarget Restor Only
            if not notKickAble and A.Typhoon:IsReady(unit, nil, nil, true) and A.Typhoon:AbsentImun("targettarget", Temp.TotalAndMag, true) and
            A.Typhoon:IsSpellLearned() and
            not IsUnitEnemy("target") and
            A.Typhoon:GetCooldown() and
            Unit("targettarget"):CanInterract(15)
			then
                return A.Typhoon:Show(icon)                                                  
            end
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) and A.LastPlayerCastID ~= A.Typhoon.ID then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) and A.LastPlayerCastID ~= A.Typhoon.ID then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) and A.LastPlayerCastID ~= A.Typhoon.ID then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) and A.LastPlayerCastID ~= A.Typhoon.ID then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

-----------------------------------------
--        ROTATION FUNCTIONS           --
-----------------------------------------

-- Return number
-- Efflorescence duration left
local function Efflorescence()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 134222 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end

-- Mana Management
local function IsSaveManaPhase()
    if not A.IsInPvP and A.GetToggle(2, "ManaManagement") and Unit(player):HasBuffs(A.Innervate.ID) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit(player):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit(player):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)


local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
	-- Barkskin
    local Barkskin = A.GetToggle(2, "Barkskin")
    if     Barkskin >= 0 and A.Barkskin:IsReady(player, nil, nil, true) and IsSchoolFree() and
    (
        (     -- Auto 
            Barkskin >= 85 and 
            (
                Unit(player):HealthPercent() <= 50 or
                (                        
                    Unit(player):HealthPercent() < 70 
                )
            )
        ) or 
        (    -- Custom
            Barkskin < 85 and 
            Unit(player):HealthPercent() <= Barkskin
        )
    ) 
    then 
        return A.Barkskin
    end 
	
    -- Stoneform on defensive
    local Stoneform = A.GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP(player, nil, nil, true) and 
    (
        (     -- Auto 
            Stoneform >= 100 and 
            (
                (
                    not A.IsInPvP and                         
                    Unit(player):TimeToDieX(65) < 3 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            Stoneform < 100 and 
            Unit(player):HealthPercent() <= Stoneform
        )
    ) 
    then 
        return A.Stoneform
    end     
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:AutoRacial(player, true, nil, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = Action.MakeFunctionCachedDynamic(SelfDefensives)

-- Interrupts
local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")
    
    if useCC and A.MightyBash:IsReady(unit) and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.MightyBash              
    end             
    
    if useRacial and A.QuakingPalm:AutoRacial(unit, nil, nil, true) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit, nil, nil, true) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit, nil, nil, true) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit, nil, nil, true) then 
        return A.BullRush
    end      
    
end 
Interrupts = Action.MakeFunctionCachedDynamic(Interrupts)

-- Return average DMG taken from all our current member team
-- DEPRECATED SEE FriendlyTeam:GetLastTimeDMGX(x, range)
local function FriendlyTeamReceivedLast5sec() 
    local total = 0
	local getmembersAll = HealingEngine.GetMembersAll()
	
    if #getmembersAll > 0 then 
        for i = 1, #getmembersAll do
		    -- Avoid getting pet damage
		    if Unit(getmembersAll[i].Unit):IsPlayer() then
                total = total + Unit(getmembersAll[i].Unit):GetLastTimeDMGX(5)
			end
        end
		
		avg = total / #getmembersAll
    end 
    return total
end
FriendlyTeamReceivedLast5sec = Action.MakeFunctionCachedDynamic(FriendlyTeamReceivedLast5sec)

function FriendlyTeam:GetLastTimeDMGX(x, range)
    -- @return number, number, number
    -- [1] Average received damage latest 'x' seconds 
    -- [2] Summary received damage latest 'x' seconds 
    -- [3] Count of members valid for conditions
    -- Nill-able: range
    local ROLE                            = self.ROLE
    local lastDMG, members                = 0, 0
    local member
    
    if TeamCacheFriendly.Size <= 1 then 
        if Unit(player):Role(ROLE) then  
            lastDMG = Unit(player):GetLastTimeDMGX(x)
            return lastDMG, 1     
        end 
        
        return lastDMG, members
    end         
    
    if ROLE and TeamCacheFriendly[ROLE] then 
        for member in pairs(TeamCacheFriendly[ROLE]) do
            if Unit(member):InRange() and (not range or Unit(member):GetRange() <= range) then
                lastDMG = lastDMG + Unit(member):GetLastTimeDMGX(x)   
                members = members + 1
            end             
        end             
    else
        for i = 1, TeamCacheFriendly.MaxSize do
            member = TeamCacheFriendlyIndexToPLAYERs[i]                
            if member and Unit(member):InRange() and (not range or Unit(member):GetRange() <= range) then
                lastDMG = lastDMG + Unit(member):GetLastTimeDMGX(x)   
                members = members + 1
            end 
        end  
        
        if TeamCacheFriendly.Type ~= "raid" then
            lastDMG = lastDMG + Unit(player):GetLastTimeDMGX(x)  
            members = members + 1
        end 
    end      
    
    if lastDMG == 0 and members == 0 then 
        return 0, lastDMG, members
    else 
        return lastDMG / members, lastDMG, members
    end 
end

local function BurstBuffs()
    return 
    Unit("player"):HasBuffs(A.IncarnationTreeofLifeBuff.ID, true)>0 or
    Unit("player"):HasBuffs("BurstHaste")>0 
end

local function noDamageCheck(unit)
    if isChecked("Dont DPS spotter") and GetObjectID(unit) == 135263 then
        return true
    end
    if isCC(unit) then
        return true
    end
    if isCasting(302415, unit) then
        -- emmisary teleporting home
        return true
    end

    if hasBuff(263246, unit) then
        -- shields on first boss in temple
        return true
    end
    if hasBuff(260189, unit) then
        -- shields on last boss in MOTHERLODE
        return true
    end
    if hasBuff(261264, unit) or hasBuff(261265, unit) or hasBuff(261266, unit) then
        -- shields on witches in wm
        return true
    end

    if GetObjectID(thisUnit) == 155432 then
        --emmisaries to punt, dealt with seperately
        return true
    end
    return false --catchall
end
noDamageCheck = Action.MakeFunctionCachedDynamic(noDamageCheck)

-- Restor Druid 
local function CanAoEFlourish(pHP)   
	local total = 0
	local getmembersAll = HealingEngine.GetMembersAll()
	
	for i = 1, #getmembersAll do
		if getmembersAll[i].HP <= pHP and
		-- Rejuvenation
		Unit(getmembersAll[i].Unit):HasBuffs(774) > 0 and 
		(
			-- Wild Growth
			Unit(getmembersAll[i].Unit):HasBuffs(48438, true) > 0 or 
			-- Lifebloom or Regrowth or Germination
			Unit(getmembersAll[i].Unit):HasBuffs({33763, 8936, 155777}, true) > 0 
		)
		then
			total = total + 1
		end
	end
	return total >= #getmembersAll * 0.3
end

-- PvE
local function SootheAble(unit)
    -- https://questionablyepic.com/bfa-dungeon-debuffs/
    return Unit(unit):HasBuffs({
            228318, -- Raging (Raging Affix)
            255824, -- Fanatic's Rage (Dazar'ai Juggernaut)
            257476, -- Bestial Wrath (Irontide Mastiff)
            269976, -- Ancestral Fury (Shadow-Borne Champion)
            262092, -- Inhale Vapors (Addled Thug)
            272888, -- Ferocity (Ashvane Destroyer)
            259975, -- Enrage (The Sand Queen)
            265081, -- Warcry (Chosen Blood Matron)
            266209, -- Wicked Frenzy (Fallen Deathspeaker)
    }, true)>2
end

local fishfeast = 0

local StunsBlackList = {
    -- Atal'Dazar
    [87318] = "Dazar'ai Colossus",
    [122984] = "Dazar'ai Colossus",
    [128455] = "T'lonja",
    [129553] = "Dinomancer Kish'o",
    [129552] = "Monzumi",
    -- Freehold
    [129602] = "Irontide Enforcer",
    [130400] = "Irontide Crusher",
    -- King's Rest
    [133935] = "Animated Guardian",
    [134174] = "Shadow-Borne Witch Doctor",
    [134158] = "Shadow-Borne Champion",
    [137474] = "King Timalji",
    [137478] = "Queen Wasi",
    [137486] = "Queen Patlaa",
    [137487] = "Skeletal Hunting Raptor",
    [134251] = "Seneschal M'bara",
    [134331] = "King Rahu'ai",
    [137484] = "King A'akul",
    [134739] = "Purification Construct",
    [137969] = "Interment Construct",
    [135231] = "Spectral Brute",
    [138489] = "Shadow of Zul",
    -- Shrine of the Storm
    [134144] = "Living Current",
    [136214] = "Windspeaker Heldis",
    [134150] = "Runecarver Sorn",
    [136249] = "Guardian Elemental",
    [134417] = "Deepsea Ritualist",
    [136353] = "Colossal Tentacle",
    [136295] = "Sunken Denizen",
    [136297] = "Forgotten Denizen",
    -- Siege of Boralus
    [129369] = "Irontide Raider",
    [129373] = "Dockhound Packmaster",
    [128969] = "Ashvane Commander",
    [138255] = "Ashvane Spotter",
    [138465] = "Ashvane Cannoneer",
    [135245] = "Bilge Rat Demolisher",
    -- Temple of Sethraliss
    [134991] = "Sandfury Stonefist",
    [139422] = "Scaled Krolusk Tamer",
    [136076] = "Agitated Nimbus",
    [134691] = "Static-charged Dervish",
    [139110] = "Spark Channeler",
    [136250] = "Hoodoo Hexer",
    [139946] = "Heart Guardian",
    -- MOTHERLODE!!
    [130485] = "Mechanized Peacekeeper",
    [136139] = "Mechanized Peacekeeper",
    [136643] = "Azerite Extractor",
    [134012] = "Taskmaster Askari",
    [133430] = "Venture Co. Mastermind",
    [133463] = "Venture Co. War Machine",
    [133436] = "Venture Co. Skyscorcher",
    [133482] = "Crawler Mine",
    -- Underrot
    [131436] = "Chosen Blood Matron",
    [133912] = "Bloodsworn Defiler",
    [138281] = "Faceless Corruptor",
    -- Tol Dagor
    [130025] = "Irontide Thug",
    -- Waycrest Manor
    [131677] = "Heartsbane Runeweaver",
    [135329] = "Matron Bryndle",
    [131812] = "Heartsbane Soulcharmer",
    [131670] = "Heartsbane Vinetwister",
    [135365] = "Matron Alma",
}

local precast_spell_list = {
    --spell_id	, precast_time	,	spell_name
    { 214652, 5, 'Acidic Fragments' },
    { 205862, 5, 'Slam' },
    { 259832, 1.5, 'Massive Glaive - Stormbound Conqueror (Warport Wastari, Zuldazar, for testing purpose only)' },
    { 218774, 5, 'Summon Plasma Spheres' },
    { 206949, 5, 'Frigid Nova' },
    { 206517, 5, 'Fel Nova' },
    { 207720, 5, 'Witness the Void' },
    { 206219, 5, 'Liquid Hellfire' },
    { 211439, 5, 'Will of the Demon Within' },
    { 209270, 5, 'Eye of Guldan' },
    { 227071, 5, 'Flame Crash' },
    { 233279, 5, 'Shattering Star' },
    { 233441, 5, 'Bone Saw' },
    { 235230, 5, 'Fel Squall' },
    { 231854, 5, 'Unchecked Rage' },
    { 232174, 5, 'Frosty Discharge' },
    { 230139, 5, 'Hydra Shot' },
    { 233264, 5, 'Embrace of the Eclipse' },
    { 236542, 5, 'Sundering Doom' },
    { 236544, 5, 'Doomed Sundering' },
    { 235059, 5, 'Rupturing Singularity' },
    { 288693, 3, 'Tormented Soul - Grave Bolt (Reaping affix)' },
    { 262347, 5, 'Static Pulse' },
    { 302420, 5, 'Queen\'s Decree: Hide' },
    { 260333, 7, 'Tantrum - Underrot 2nd boss' },
    { 255577, 5, 'Transfusion' }, -- https://www.wowhead.com/spell=255577/transfusion
    { 259732, 5, 'Festering Harvest' }, --https://www.wowhead.com/spell=259732/festering-harvest
    { 285388, 5, 'Vent Jets' }, --https://www.wowhead.com/spell=285388/vent-jets
    { 291626, 3, 'Cutting Beam' }, --https://www.wowhead.com/spell=291626/cutting-beam
    { 300207, 3, 'shock-coil' }, -- https://www.wowhead.com/spell=300207/shock-coil
    { 297261, 5, 'rumble' }, -- https://www.wowhead.com/spell=297261/rumble
    { 262347, 5, 'pulse' }, --https://www.wowhead.com/spell=262347/static-pulse
}
--end of dbm list

local DebuffSniperList = {

    --junkyard
    { spellID = 298669, stacks = 0, secs = 1 }, -- Taze
    -- Uldir
    { spellID = 262313, stacks = 0, secs = 5 }, -- Malodorous Miasma
    { spellID = 262314, stacks = 0, secs = 3 }, -- Putrid Paroxysm
    { spellID = 264382, stacks = 0, secs = 1 }, -- Eye Beam
    { spellID = 264210, stacks = 0, secs = 5 }, -- Jagged Mandible
    { spellID = 265360, stacks = 0, secs = 5 }, -- Roiling Deceit
    { spellID = 265129, stacks = 0, secs = 5 }, -- Omega Vector
    { spellID = 266948, stacks = 0, secs = 5 }, -- Plague Bomb
    { spellID = 274358, stacks = 0, secs = 5 }, -- Rupturing Blood
    { spellID = 274019, stacks = 0, secs = 1 }, -- Mind Flay
    { spellID = 272018, stacks = 0, secs = 1 }, -- Absorbed in Darkness
    { spellID = 273359, stacks = 0, secs = 5 }, -- Shadow Barrage
    -- Freehold
    { spellID = 257437, stacks = 0, secs = 5 }, -- Poisoning Strike
    { spellID = 267523, stacks = 0, secs = 5 }, -- Cutting Surge
    { spellID = 256363, stacks = 0, secs = 5 }, -- Ripper Punch
    -- Shrine of the Storm
    { spellID = 264526, stacks = 0, secs = 5 }, -- Grasp from the Depths
    { spellID = 264166, stacks = 0, secs = 1 }, -- Undertow
    { spellID = 268214, stacks = 0, secs = 1 }, -- Carve Flesh
    { spellID = 276297, stacks = 0, secs = 5 }, -- Void Seed
    { spellID = 268322, stacks = 0, secs = 5 }, -- Touch of the Drowned
    -- Siege of Boralus
    { spellID = 256897, stacks = 0, secs = 5 }, -- Clamping Jaws
    { spellID = 273470, stacks = 0, secs = 3 }, -- Gut Shot
    { spellID = 275014, stacks = 0, secs = 5 }, -- Putrid Waters
    -- Tol Dagor
    { spellID = 258058, stacks = 0, secs = 1 }, -- Squeeze
    { spellID = 260016, stacks = 0, secs = 3 }, -- Itchy Bite
    { spellID = 260067, stacks = 0, secs = 5 }, -- Vicious Mauling
    { spellID = 258864, stacks = 0, secs = 5 }, -- Suppression Fire
    { spellID = 258917, stacks = 0, secs = 3 }, -- Righteous Flames
    { spellID = 256198, stacks = 0, secs = 5 }, -- Azerite Rounds: Incendiary
    { spellID = 256105, stacks = 0, secs = 1 }, -- Explosive Burst
    -- Waycrest Manor
    { spellID = 266035, stacks = 0, secs = 1 }, -- Bone Splinter
    { spellID = 260703, stacks = 0, secs = 1 }, -- Unstable Runic Mark
    { spellID = 260741, stacks = 0, secs = 1 }, -- Jagged Nettles
    { spellID = 264050, stacks = 0, secs = 3 }, -- Infected Thorn
    { spellID = 264556, stacks = 0, secs = 2 }, -- Tearing Strike
    { spellID = 264150, stacks = 0, secs = 1 }, -- Shatter
    { spellID = 265761, stacks = 0, secs = 1 }, -- Thorned Barrage
    { spellID = 263905, stacks = 0, secs = 1 }, -- Marking Cleave
    { spellID = 264153, stacks = 0, secs = 3 }, -- Spit
    { spellID = 278456, stacks = 0, secs = 3 }, -- Infest
    { spellID = 271178, stacks = 0, secs = 3 }, -- Ravaging Leap
    { spellID = 265880, stacks = 0, secs = 1 }, -- Dread Mark
    { spellID = 265882, stacks = 0, secs = 1 }, -- Lingering Dread
    { spellID = 264378, stacks = 0, secs = 5 }, -- Fragment Soul
    { spellID = 261438, stacks = 0, secs = 1 }, -- Wasting Strike
    { spellID = 261440, stacks = 0, secs = 1 }, -- Virulent Pathogen
    { spellID = 268202, stacks = 0, secs = 1 }, -- Death Lens
    -- Atal'Dazar
    { spellID = 253562, stacks = 0, secs = 3 }, -- Wildfire
    { spellID = 254959, stacks = 0, secs = 2 }, -- Soulburn
    { spellID = 255558, stacks = 0, secs = 5 }, -- Tainted Blood
    { spellID = 255814, stacks = 0, secs = 5 }, -- Rending Maul
    { spellID = 250372, stacks = 0, secs = 5 }, -- Lingering Nausea
    { spellID = 250096, stacks = 0, secs = 1 }, -- Wracking Pain
    { spellID = 256577, stacks = 0, secs = 5 }, -- Soulfeast
    -- King's Rest
    { spellID = 269932, stacks = 0, secs = 3 }, -- Gust Slash
    { spellID = 265773, stacks = 0, secs = 4 }, -- Spit Gold
    { spellID = 270084, stacks = 0, secs = 3 }, -- Axe Barrage
    { spellID = 270865, stacks = 0, secs = 3 }, -- Hidden Blade
    { spellID = 270289, stacks = 0, secs = 3 }, -- Purification Beam
    { spellID = 271564, stacks = 0, secs = 3 }, -- Embalming
    { spellID = 267618, stacks = 0, secs = 3 }, -- Drain Fluids
    { spellID = 270487, stacks = 0, secs = 3 }, -- Severing Blade
    { spellID = 270507, stacks = 0, secs = 5 }, -- Poison Barrage
    { spellID = 266231, stacks = 0, secs = 3 }, -- Severing Axe
    { spellID = 267273, stacks = 0, secs = 3 }, -- Poison Nova
    { spellID = 268419, stacks = 0, secs = 3 }, -- Gale Slash
    -- MOTHERLODE!!
    { spellID = 269298, stacks = 0, secs = 1 }, -- Widowmaker
    { spellID = 262347, stacks = 0, secs = 1 }, -- Static Pulse
    { spellID = 263074, stacks = 0, secs = 3 }, -- Festering Bite
    { spellID = 262270, stacks = 0, secs = 1 }, -- Caustic Compound
    { spellID = 262794, stacks = 0, secs = 1 }, -- Energy Lash
    { spellID = 259853, stacks = 0, secs = 3 }, -- Chemical Burn
    { spellID = 269092, stacks = 0, secs = 1 }, -- Artillery Barrage
    { spellID = 262348, stacks = 0, secs = 1 }, -- Mine Blast
    { spellID = 260838, stacks = 0, secs = 1 }, -- Homing Missile
    -- Temple of Sethraliss
    { spellID = 263371, stacks = 0, secs = 1 }, -- Conduction
    { spellID = 272657, stacks = 0, secs = 3 }, -- Noxious Breath
    { spellID = 267027, stacks = 0, secs = 1 }, -- Cytotoxin
    { spellID = 272699, stacks = 0, secs = 3 }, -- Venomous Spit
    { spellID = 268013, stacks = 0, secs = 5 }, -- Flame Shock
    -- Underrot
    { spellID = 265019, stacks = 0, secs = 1 }, -- Savage Cleave
    { spellID = 265568, stacks = 0, secs = 1 }, -- Dark Omen
    { spellID = 260685, stacks = 0, secs = 5 }, -- Taint of G'huun
    { spellID = 278961, stacks = 0, secs = 5 }, -- Decaying Mind
    { spellID = 260455, stacks = 0, secs = 1 }, -- Serrated Fangs
    { spellID = 273226, stacks = 0, secs = 1 }, -- Decaying Spores
    { spellID = 269301, stacks = 0, secs = 5 }, -- Putrid Blood
    -- all
    { spellID = 302421, stacks = 0, secs = 5 }, -- Queen's Decree
}

local function SetFriendlyToSnipe()
    local getmembersAll = A.HealingEngine.GetMembersAll()
    for i = 1, #getmembersAll do
        if Unit(getmembersAll[i].Unit):GetRange() <= 40 then
            for k, v in pairs(DebuffSniperList) do
                if Unit(getmembersAll[i].Unit):HasDeBuffs(v.spellID, true) > v.secs and Unit(getmembersAll[i].Unit):HasDeBuffsStacks(v.spellID, true) >= v.stacks and Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID, player, true) == 0 then
                    if A.Germination:IsSpellLearned() and Unit(getmembersAll[i].Unit):HasBuffs(A.RejuvenationGermimation.ID, player, true) == 0 then
                        if A.Rejuvenation:IsReady(getmembersAll[i].Unit) then
                            A.HealingEngine.SetTarget(getmembersAll[i].Unit)
                        end
                    elseif Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID, player, true) == 0 then
                        if A.Rejuvenation:IsReady(getmembersAll[i].Unit) then
                            A.HealingEngine.SetTarget(getmembersAll[i].Unit)
                        end
                    end
                end
            end
        end
	end
end
SetFriendlyToSnipe = Action.MakeFunctionCachedDynamic(SetFriendlyToSnipe)

local pre_hot_list = {   --snipe list
    --Battle of Dazar'alor
    [283572] = { targeted = true }, --"Sacred Blade"
    [284578] = { targeted = true }, --"Penance"
    [286988] = { targeted = true }, --Divine Burst"
    [282036] = { targeted = true }, --"Fireball"
    [282182] = { targeted = false }, --"Buster Cannon"
    --Uldir
    [279669] = { targeted = false }, --"Bacterial Outbreak"
    [279660] = { targeted = false }, --"Endemic Virus"
    [274262] = { targeted = false }, --"Explosive Corruption"
    --Reaping
    [288693] = { targeted = true }, --"Grave Bolt",
    --Atal'Dazar
    [250096] = { targeted = true }, --"Wracking Pain"
    [253562] = { targeted = true }, --"Wildfire"
    [252781] = { targeted = true }, --"Unstable Hex"
    [252923] = { targeted = true }, --"Venom Blast"
    [253239] = { targeted = true }, -- Dazarai Juggernaut - Merciless Assault },
    [256846] = { targeted = true }, --'Dinomancer Kisho - Deadeye Aim'},
    [257407] = { targeted = true }, -- Rezan - Pursuit},
    --Kings Rest
    [267618] = { targeted = true }, --"Drain Fluids"
    [267308] = { targeted = true }, --"Lighting Bolt"
    [270493] = { targeted = true }, --"Spectral Bolt"
    [269973] = { targeted = true }, --"Deathly Chill"
    [270923] = { targeted = true }, --"Shadow Bolt"
    [272388] = { targeted = true }, --"Shadow Barrage"
    [266231] = { targeted = true }, -- Kula the Butcher - Severing Axe},
    [270507] = { targeted = true }, --  Spectral Beastmaster - Poison Barrage},
    [265773] = { targeted = true }, -- The Golden Serpent - Spit Gold},
    [270506] = { targeted = true }, -- Spectral Beastmaster - Deadeye Shot},
    [265773] = { targeted = true }, -- https://www.wowhead.com/spell=270487/severing-blade
    [268586] = { targeted = true }, -- https://www.wowhead.com/spell=268586/blade-combo
    --Free Hold
    [259092] = { targeted = true }, --"Lightning Bolt"
    [281420] = { targeted = true }, --"Water Bolt"
    [257267] = { targeted = false }, --"Swiftwind Saber"
    [257739] = { targeted = true }, -- Blacktooth Scrapper - Blind Rage},
    [258338] = { targeted = true }, -- Captain Raoul - Blackout Barrel},
    [256979] = { targeted = true }, -- Captain Eudora - Powder Shot},
    --Siege of Boralus
    [272588] = { targeted = true }, --"Rotting Wounds"
    [272827] = { targeted = false }, --"Viscous Slobber"
    [272581] = { targeted = true }, -- "Water Spray"
    [257883] = { targeted = false }, -- "Break Water"
    [257063] = { targeted = true }, --"Brackish Bolt"
    [272571] = { targeted = true }, --"Choking Waters"
    [257641] = { targeted = true }, -- Kul Tiran Marksman - Molten Slug},
    [272874] = { targeted = true }, -- Ashvane Commander - Trample},
    [272581] = { targeted = true }, -- Bilge Rat Tempest - Water Spray},
    [272528] = { targeted = true }, -- Ashvane Sniper - Shoot},
    [272542] = { targeted = true }, -- Ashvane Sniper - Ricochet},
    -- Temple of Sethraliss
    [263775] = { targeted = true }, --"Gust"
    [268061] = { targeted = true }, --"Chain Lightning"
    [272820] = { targeted = true }, --"Shock"
    [263365] = { targeted = true }, --"https://www.wowhead.com/spell=263365/a-peal-of-thunder"
    [268013] = { targeted = true }, --"Flame Shock"
    [274642] = { targeted = true }, --"Lava Burst"
    [268703] = { targeted = true }, --"Lightning Bolt"
    [272699] = { targeted = true }, --"Venomous Spit"
    [268703] = { targeted = true }, -- Charged Dust Devil - Lightning Bolt},
    [272670] = { targeted = true }, -- Sandswept Marksman - Shoot},
    [267278] = { targeted = true }, -- Static-charged Dervish - Electrocute},
    [272820] = { targeted = true }, -- Spark Channeler - Shock},
    [274642] = { targeted = true }, -- Hoodoo Hexer - Lava Burst},
    [268061] = { targeted = true }, -- Plague Doctor - Chain Lightning},
    --Shrine of the Storm
    [265001] = { targeted = true }, --"Sea Blast"
    [268347] = { targeted = true }, --"Void Bolt"
    [267969] = { targeted = true }, --"Water Blast"
    [268233] = { targeted = true }, --"Electrifying Shock"
    [268315] = { targeted = true }, --"Lash"
    [268177] = { targeted = true }, --"Windblast"
    [268273] = { targeted = true }, --"Deep Smash"
    [268317] = { targeted = true }, --"Rip Mind"
    [265001] = { targeted = true }, --"Sea Blast"
    [274703] = { targeted = true }, --"Void Bolt"
    [268214] = { targeted = true }, --"Carve Flesh"
    [264166] = { targeted = true }, -- Aqusirr - Undertow},
    [268214] = { targeted = true }, -- Runecarver Sorn - Carve Flesh},
    --Motherlode
    [259856] = { targeted = true }, --"Chemical Burn"
    [260318] = { targeted = true }, --"Alpha Cannon"
    [262794] = { targeted = true }, --"Energy Lash"
    [263202] = { targeted = true }, --"Rock Lance"
    [262268] = { targeted = true }, --"Caustic Compound"
    [263262] = { targeted = true }, --"Shale Spit"
    [263628] = { targeted = true }, --"Charged Claw"
    [268185] = { targeted = true }, -- Refreshment Vendor, Iced Spritzer},
    [258674] = { targeted = true }, -- Off-Duty Laborer - Throw Wrench},
    [276304] = { targeted = true }, -- Rowdy Reveler - Penny For Your Thoughts},
    [263209] = { targeted = true }, -- Mine Rat - Throw Rock},
    [263202] = { targeted = true }, -- Venture Co. Earthshaper - Rock Lance},
    [262794] = { targeted = true }, -- Venture Co. Mastermind - Energy Lash},
    [260669] = { targeted = true }, -- Rixxa Fluxflame - Propellant Blast},
    [271456] = { targeted = true }, -- https://www.wowhead.com/spell=271456/drill-smash},
    --Underrot
    [260879] = { targeted = true }, --"Blood Bolt"
    [265084] = { targeted = true }, --"Blood Bolt"
    [259732] = { targeted = false }, --"Festering Harvest"
    [266209] = { targeted = false }, --"Wicked Frenzy"
    [265376] = { targeted = true }, -- Fanatical Headhunter - Barbed Spear},
    [265625] = { targeted = true }, -- Befouled Spirit - Dark Omen},
    --Tol Dagor
    [257777] = { targeted = true }, --"Crippling Shiv"
    [258150] = { targeted = true }, --"Salt Blast"
    [258869] = { targeted = true }, --"Blaze"
    [256039] = { targeted = true }, -- Overseer Korgus - Deadeye},
    [185857] = { targeted = true }, -- Ashvane Spotter - Shoot},

    --work shop_
    [294195] = { targeted = true }, --https://www.wowhead.com/spell=294195/arcing-zap
    [293827] = { targeted = true }, --https://www.wowhead.com/spell=293827/giga-wallop
    [292264] = { targeted = true }, -- https://www.wowhead.com/spell=292264/giga-zap
    --junk yard
    [300650] = { targeted = true }, --https://www.wowhead.com/spell=300650/suffocating-smog
    [299438] = { targeted = true }, --https://www.wowhead.com/spell=299438/sledgehammer
    [300188] = { targeted = true }, -- https://www.wowhead.com/spell=300188/scrap-cannon#used-by-npc
    [302682] = { targeted = true }, --https://www.wowhead.com/spell=302682/mega-taze

    --Waycrest Manor
    [260701] = { targeted = true }, --"Bramble Bolt"
    [260700] = { targeted = true }, --"Ruinous Bolt"
    [260699] = { targeted = true }, --"Soul Bolt"
    [261438] = { targeted = true }, --"Wasting Strike"
    [266225] = { targeted = true }, --Darkened Lightning"
    [273653] = { targeted = true }, --"Shadow Claw"
    [265881] = { targeted = true }, --"Decaying Touch"
    [264153] = { targeted = true }, --"Spit"
    [278444] = { targeted = true }, --"Infest"
    [167385] = { targeted = true }, --"Infest"
    [263891] = { targeted = true }, -- Heartsbane Vinetwister - Grasping Thorns},
    [264510] = { targeted = true }, -- Crazed Marksman - Shoot},
    [260699] = { targeted = true }, -- Coven Diviner - Soul Bolt},
    [260551] = { targeted = true }, -- Soulbound Goliath - Soul Thorns},
    [260741] = { targeted = true }, -- Heartsbane Triad - Jagged Nettles},
    [268202] = { targeted = true } -- Gorak Tul - Death Lens},
}
local CC_CreatureTypeList = { "Beast", "Dragonkin" }
local StunsBlackList = {
    -- Atal'Dazar
    [87318] = "Dazar'ai Colossus",
    [122984] = "Dazar'ai Colossus",
    [128455] = "T'lonja",
    [129553] = "Dinomancer Kish'o",
    [129552] = "Monzumi",
    -- Freehold
    [129602] = "Irontide Enforcer",
    [130400] = "Irontide Crusher",
    -- King's Rest
    [133935] = "Animated Guardian",
    [134174] = "Shadow-Borne Witch Doctor",
    [134158] = "Shadow-Borne Champion",
    [137474] = "King Timalji",
    [137478] = "Queen Wasi",
    [137486] = "Queen Patlaa",
    [137487] = "Skeletal Hunting Raptor",
    [134251] = "Seneschal M'bara",
    [134331] = "King Rahu'ai",
    [137484] = "King A'akul",
    [134739] = "Purification Construct",
    [137969] = "Interment Construct",
    [135231] = "Spectral Brute",
    [138489] = "Shadow of Zul",
    -- Shrine of the Storm
    [134144] = "Living Current",
    [136214] = "Windspeaker Heldis",
    [134150] = "Runecarver Sorn",
    [136249] = "Guardian Elemental",
    [134417] = "Deepsea Ritualist",
    [136353] = "Colossal Tentacle",
    [136295] = "Sunken Denizen",
    [136297] = "Forgotten Denizen",
    -- Siege of Boralus
    [129369] = "Irontide Raider",
    [129373] = "Dockhound Packmaster",
    [128969] = "Ashvane Commander",
    [138255] = "Ashvane Spotter",
    [138465] = "Ashvane Cannoneer",
    [135245] = "Bilge Rat Demolisher",
    -- Temple of Sethraliss
    [134991] = "Sandfury Stonefist",
    [139422] = "Scaled Krolusk Tamer",
    [136076] = "Agitated Nimbus",
    [134691] = "Static-charged Dervish",
    [139110] = "Spark Channeler",
    [136250] = "Hoodoo Hexer",
    [139946] = "Heart Guardian",
    -- MOTHERLODE!!
    [130485] = "Mechanized Peacekeeper",
    [136139] = "Mechanized Peacekeeper",
    [136643] = "Azerite Extractor",
    [134012] = "Taskmaster Askari",
    [133430] = "Venture Co. Mastermind",
    [133463] = "Venture Co. War Machine",
    [133436] = "Venture Co. Skyscorcher",
    [133482] = "Crawler Mine",
    -- Underrot
    [131436] = "Chosen Blood Matron",
    [133912] = "Bloodsworn Defiler",
    [138281] = "Faceless Corruptor",
    -- Tol Dagor
    [130025] = "Irontide Thug",
    -- Waycrest Manor
    [131677] = "Heartsbane Runeweaver",
    [135329] = "Matron Bryndle",
    [131812] = "Heartsbane Soulcharmer",
    [131670] = "Heartsbane Vinetwister",
    [135365] = "Matron Alma",
    --mini bosses
    [161241] = "Voidweaver Mal'thir",
}

local function PvPEntanglingRoots(unit)
    return
    Unit(unit):IsMelee() and
    not UnitIsUnit(unit, "target") and
    --not Env.InLOS(unit) and 
    Unit(unit):HasBuffs("DamageBuffs") > 0 and
    A.EntanglingRoots:IsSpellInRange(unit) and
    (
        (
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, true) > 0
        ) or
        Unit(player):GetCurrentSpeed()==0
    ) 
end

local function CanDispel(unit)
    return
    (         
        A.GetToggle(2, "AutoDispel") --dispel_toggle
    ) and
    Unit(unit):IsExists() and
    --not Env.InLOS(unit) and    
    A.NaturesCure:IsSpellInRange(unit) and    
    A.LastPlayerCastID~=88423 and
    (
        (
            A.IsInPvP and 
            (
                Unit(unit):HasDeBuffs("Curse")>2 or
                Unit(unit):HasDeBuffs("Poison")>2 or
                Unit(unit):HasDeBuffs("Magic")>2 or
                (
                    select(2, UnitClass(unit)) ~= "DRUID" and
                    Unit(unit):IsMelee()  and
                    Unit(unit):HasDeBuffs("MagicRooted")>2
                )
            ) 
        ) or         
        Env.PvEDispel(unit)    
    )
end

-- [3] Single Rotation
A[3] = function(icon, isMulti)

    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
	local DBM = GetToggle(1 ,"DBM")
	local Potion = GetToggle(1, "Potion")
	local Racial = GetToggle(1, "Racial")
	local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
	local StopCastQuake = GetToggle(2, "StopCastQuake")
	local StopCastQuakeSec = GetToggle(2, "StopCastQuakeSec")
	local ReceivedLast5sec = FriendlyTeam("ALL"):GetLastTimeDMGX(5)
	local AVG_DMG = HealingEngine.GetIncomingDMGAVG()
	local AVG_HPS = HealingEngine.GetIncomingHPSAVG()

    --------------------
    --- DPS ROTATION ---
    --------------------
    local function DamageRotation(unit)
	
        -- General Prowl Restor (precombat)
        if A.Prowl:IsReady(player) and
        combatTime == 0 and
        A.FeralAffinity:IsSpellLearned() and -- Feral affility
        not Player:IsStealthed() and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) 
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) 
            )
        )
        then
            return A.Prowl:Show(icon)
	    end

        -- General Soothe
        if A.Soothe:IsReady(unit) and
        --Soothe_toggle and
        (
            (   -- MouseOver
                A.GetToggle(2, "mouseover") and
                Unit("mouseover"):IsExists() and 
                A.MouseHasFrame() and     
                IsUnitEnemy("mouseover") and  
                A.Soothe:IsSpellInRange("mouseover") and
                (
                    (
                        A.IsInPvP and
                        select(2, UnitClass("mouseover")) == "WARRIOR" and
                        Unit("mouseover"):HasBuffs("Rage")>2
                    ) or 
                    (
                        not A.IsInPvP and
                        SootheAble("mouseover")
                    )
                ) 
            ) or 
            (    -- Target
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit("mouseover"):IsExists() or 
                    not IsUnitEnemy("mouseover")
                ) and
                IsUnitEnemy("target") and     
                A.Soothe:IsSpellInRange("target") and
                (
                    (
                        A.IsInPvP and
                        select(2, UnitClass("target")) == "WARRIOR" and
                        Unit("target"):HasBuffs("Rage")>2
                    ) or 
                    (
                        not A.IsInPvP and
                        SootheAble("target")
                    )
                )
            )
        )
        then
            return A.Soothe:Show(icon)
	    end

        -- General Rake
        if A.Rake:IsReady(unit) and
        A.FeralAffinity:IsSpellLearned() and -- Feral affility 
        Player:GetStance()==2 and
        (
            Player:ComboPoints()<5 or
            Player:IsStealthed()
        ) and
        (    
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.Rake:IsSpellInRange(mouseover) and
                (
                    Unit(mouseover):PT(155722, true, true) or
                    Player:IsStealthed()
                ) and
		        A.Rake:AbsentImun(mouseover, Temp.TotalAndPhys, true)
            ) or 
            -- Target
            (
        
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.Rake:IsSpellInRange(target) and
                (
                    Unit(target):PT(155722, true, true) or
                    Player:IsStealthed()
                ) and
                A.Rake:AbsentImun(target, Temp.TotalAndPhys, true)
            ) or
            -- TargetTarget
            (
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.Rake:IsSpellInRange(targettarget) and			
                (			    
                    Unit(targettarget):PT(155722, true, true) or
                    Player:IsStealthed()
                ) and
		        A.Rake:AbsentImun(targettarget, Temp.TotalAndPhys, true)
		
            )    
        )
        then
            return A.Rake:Show(icon)
	    end
		
        -- General AoE Swipe
        if A.Swipe:IsReady(player) and 
        A.FeralAffinity:IsSpellLearned() and -- Feral affility
        Player:GetStance()== 2 and
        Player:ComboPoints() < 5 and
        IsUnitEnemy(target) and
        Unit(target):CanInterract(8)
        then
            return A.Swipe:Show(icon)
	    end

        -- General Shred
        if A.Shred:IsReady(unit) and 
        Player:GetStance()==2 and
        Player:ComboPoints()<5 and
        A.FeralAffinity:IsSpellLearned() and -- Feral affility
        (    
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.Shred:IsSpellInRange(mouseover) and
			    A.Shred:AbsentImun(mouseover, Temp.TotalAndPhys, true)
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.Shred:IsSpellInRange(target) and
			    A.Shred:AbsentImun(target, Temp.TotalAndPhys, true)
            ) or
            -- TargetTarget
            (
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.Shred:IsSpellInRange(targettarget) and
			    A.Shred:AbsentImun(targettarget, Temp.TotalAndPhys, true)
            )
        )
        then
            return A.Shred:Show(icon)
	    end

	    -- General Rip
        if A.Rip:IsReady(unit) and 
	    Player:GetStance()==2 and
	    Player:ComboPoints()>=5 and
	    A.FeralAffinity:IsSpellLearned() and -- Feral affility
	    (
   	        -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.Rip:IsSpellInRange(mouseover) and
                Unit(mouseover):PT(1079, true, true) and
			    A.Rip:AbsentImun(mouseover, Temp.TotalAndPhys, true)
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.Rip:IsSpellInRange(target) and
                Unit(target):PT(1079, true, true) and
                A.Rip:AbsentImun(target, Temp.TotalAndPhys, true)
            ) or 
            -- TargetTarget
            (
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.Rip:IsSpellInRange(targettarget) and
                Unit(targettarget):PT(1079, true, true) and
                A.Rip:AbsentImun(targettarget, Temp.TotalAndPhys, true)
            )
        )
        then
            return A.Rip:Show(icon)
	    end

        -- General FerociousBite
        if A.FerociousBite:IsReady(unit) and 
        Player:GetStance()==2 and
        Player:ComboPoints()>=5 and
        A.FeralAffinity:IsSpellLearned() and -- Feral affility
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.FerociousBite:IsSpellInRange(mouseover) and
                A.FerociousBite:AbsentImun(mouseover, Temp.TotalAndPhys, true)
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.FerociousBite:IsSpellInRange(target) and
                A.FerociousBite:AbsentImun(target, Temp.TotalAndPhys, true)
            ) or
            -- TargetTarget
            (
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.FerociousBite:IsSpellInRange(targettarget) and
                A.FerociousBite:AbsentImun(targettarget, Temp.TotalAndPhys, true)
            )
        )
        then
            return A.FerociousBite:Show(icon)
	    end
	
        -- General Ironfur
        if A.Ironfur:IsReady(player) and 
        Player:GetStance()==1 and
        A.GuardianAffinity:IsSpellLearned() and -- Guardian affility
        Unit(player):GetDMG(3)>0 and
        Unit(player):HasBuffs(A.Ironfur.ID, true)<=1
        then
            return A.Ironfur:Show(icon)
	    end
	
        -- General Frenzied Regeneration
        if A.FrenziedRegeneration:IsReady(player) and
        Player:GetStance()==1 and
        A.GuardianAffinity:IsSpellLearned() and -- Guardian affility
        Unit(player):HasBuffs(A.FrenziedRegeneration.ID, true)<=0.1 and
        (
            (
                A.FrenziedRegeneration:GetSpellCharges()>=2 and
                Unit(player):Health()<=Unit(player):HealthMax()*0.9 
            ) or
            A.FrenziedRegeneration:PredictHeal("Frenzied Regeneration", "player")
        )
        then
            return A.FrenziedRegeneration:Show(icon)
	    end

        -- General Mangle
        if A.Mangle:IsReady(unit) and 
        Player:GetStance()==1 and
        --A.GuardianAffinity:IsSpellLearned() and -- Guardian affility
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.Mangle:IsSpellInRange(mouseover) and
			    A.Mangle:AbsentImun(mouseover, Temp.TotalAndPhys, true)
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.Mangle:IsSpellInRange(target) and
                A.Mangle:AbsentImun(target, Temp.TotalAndPhys, true)
            ) or
            -- TargetTarget
            (
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.Mangle:IsSpellInRange(targettarget) and
                A.Mangle:AbsentImun(targettarget, Temp.TotalAndPhys, true)
            )
        )
        then
            return A.Mangle:Show(icon)
	    end

        -- General Thrash
        if A.Thrash:IsReady(unit) and 
        Player:GetStance()==1 and
        A.GuardianAffinity:IsSpellLearned() and -- Guardian affility
        not (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover)
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) 
            )
        ) and
        AoE(1, 8) and
        A.Thrash:AbsentImun(target, Temp.TotalAndPhys, true)
        then
            return A.Thrash:Show(icon)
	    end

        -- General Sunfire
        if A.Sunfire:IsReady(unit) and 
        (
            Player:GetStance()==4 or
            (
                Player:GetStance()==0 and        
                (
                    (
                        combatTime > 0 and
                        Unit(target):GetRange() >= 25
                    )            
                )
            )    
        ) and
        (
            A.BalanceAffinity:IsSpellLearned() or -- Boomkin affility
            Unit(player):HasSpec(105) -- Restor
        ) and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.Sunfire:IsSpellInRange(mouseover) and
                Unit(mouseover):PT(164815, true, true) and
                A.Sunfire:AbsentImun(mouseover, Temp.TotalAndMag, true) and
                Unit(mouseover):HasBuffs(48707, true) == 0 -- AMS
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.Sunfire:IsSpellInRange(target) and
                Unit(target):PT(164815, true, true) and
                A.Sunfire:AbsentImun(target, Temp.TotalAndMag, true) and
                Unit(target):HasBuffs(48707, true) == 0 -- AMS
            ) or
            -- TargetTarget
            (
                --not Unit(player):HasSpec(105) and -- Restor
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.Sunfire:IsSpellInRange(targettarget) and
                Unit(targettarget):PT(164815, true, true) and
                A.Sunfire:AbsentImun(targettarget, Temp.TotalAndMag, true) and
                Unit(targettarget):HasBuffs(48707, true) == 0 -- AMS
            )
        )
        then
            return A.Sunfire:Show(icon)
	    end

        -- General Moonfire
        if A.Moonfire:IsReady(unit) and 
        (
            Player:GetStance()==4 or
            (
                Player:GetStance()==1 and
                -- 8.2 changes (only if Guardian and in bear)
                Unit(player):HasSpec(104)
            )or
            (        
                Unit(player):HasSpec(105) and -- Restor
                Player:GetStance()==0
            )
        ) and
        (
            (
                not A.Shred:IsSpellInRange(target) and
                combatTime > 0
            )
        ) and
        --A.BalanceAffinity:IsSpellLearned() and -- Boomkin affility
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.Moonfire:IsSpellInRange(mouseover) and
                Unit(mouseover):PT(164812, true, true) and
                A.Moonfire:AbsentImun(mouseover, Temp.TotalAndMag, true) and
                Unit(mouseover):HasBuffs(48707, true) == 0 -- AMS
            ) or 
            -- Target
            (        
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.Moonfire:IsSpellInRange(target) and
                Unit(target):PT(164812, true, true) and
                A.Moonfire:AbsentImun(target, Temp.TotalAndMag, true) and
                Unit(target):HasBuffs(48707, true) == 0 -- AMS
            ) or
            -- TargetTarget
            (
                not Unit(player):HasSpec(105) and -- Restor
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.Moonfire:IsSpellInRange(targettarget) and
                Unit(targettarget):PT(164812, true, true) and
                A.Moonfire:AbsentImun(targettarget, Temp.TotalAndMag, true) and
                Unit(targettarget):HasBuffs(48707, true) == 0 -- AMS
            )
        )
        then
            return A.Moonfire:Show(icon)
	    end

        -- General Starsurge - 197626
        if A.Starsurge:IsReady(unit) and 
        Player:GetStance()==4 and
        (
            (
                not A.Shred:IsSpellInRange(target) and
                combatTime > 0 
            )
        ) and
        A.BalanceAffinity:IsSpellLearned() and -- Boomkin affility
        Unit(player):GetCurrentSpeed()==0 and
        select(2, Unit(player):CastTime(197626))==0 and
        (
    
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.Starsurge:IsSpellInRange(mouseover) and
                A.Starsurge:AbsentImun(mouseover, Temp.TotalAndMag, true)
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.Starsurge:IsSpellInRange(target) and
                A.Starsurge:AbsentImun(target, Temp.TotalAndMag, true)
            ) or
            -- TargetTarget
            (
                not Unit(player):HasSpec(105) and -- Restor
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.Starsurge:IsSpellInRange(targettarget) and
                A.Starsurge:AbsentImun(targettarget, Temp.TotalAndMag, true)
            ) 
        )
        then
            return A.Starsurge:Show(icon)
	    end

        -- General Lunar Strike - 197628
        if A.LunarStrike:IsReady(unit) and 
        Player:GetStance()==4 and
        (
            (
                not A.Shred:IsSpellInRange(target) and
                combatTime > 0
            )
        ) and
        A.BalanceAffinity:IsSpellLearned() and -- Boomkin affility
        Unit(player):HasBuffs(164547, true)>0 and -- Lunar Empowerment
        Unit(player):GetCurrentSpeed()==0 and
        select(2, Unit(player):CastTime(197628))==0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.LunarStrike:IsSpellInRange(mouseover) and
                A.LunarStrike:AbsentImun(mouseover, Temp.TotalAndMag, true)
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.LunarStrike:IsSpellInRange(target) and
                A.LunarStrike:AbsentImun(target, Temp.TotalAndMag, true)
            ) or
            -- TargetTarget
            (
                not Unit(player):HasSpec(105) and -- Restor
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.LunarStrike:IsSpellInRange(targettarget) and
                A.LunarStrike:AbsentImun(targettarget, Temp.TotalAndMag, true)
            ) 
        )
        then
            return A.LunarStrike:Show(icon)
	    end

        -- General Solaw Wrath - 5176
        if A.SolarWrath:IsReady(unit) and 
        (
            Player:GetStance()==4 or
            Player:GetStance()==0
        ) and
        (
            (
                not A.Shred:IsSpellInRange(target) and
                combatTime > 0
            )
        ) and
        (
            A.BalanceAffinity:IsSpellLearned() or -- Boomkin affility
            Unit(player):HasSpec(105) -- Restor
        ) and
        Unit(player):GetCurrentSpeed()==0 and
        select(2, Unit(player):CastTime(5176))==0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                IsUnitEnemy(mouseover) and 
                A.SolarWrath:IsSpellInRange(mouseover) and
                A.SolarWrath:AbsentImun(mouseover, Temp.TotalAndMag, true)
            ) or 
            -- Target
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    not IsUnitEnemy(mouseover)
                ) and
                IsUnitEnemy(target) and
                A.SolarWrath:IsSpellInRange(target) and
                A.SolarWrath:AbsentImun(target, Temp.TotalAndMag, true)
            ) or
            -- TargetTarget
            (
                not Unit(player):HasSpec(105) and -- Restor
                Unit(targettarget):IsExists() and 
                IsUnitEnemy(targettarget) and 
                A.SolarWrath:IsSpellInRange(targettarget) and
                A.SolarWrath:AbsentImun(targettarget, Temp.TotalAndMag, true)
            ) 
        )
        then
            return A.SolarWrath:Show(icon)
	    end
              
    end 
    DamageRotation = Action.MakeFunctionCachedDynamic(DamageRotation)
	
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingRotation(unit)

        -- General
		
		-- BattleRez
        if A.Rebirth:IsReady(unit) and
        A.Zone ~= "arena" and
        Unit(player):CombatTime()>0 and
        Unit(player):GetCurrentSpeed()==0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit("mouseover"):IsExists() and        
                Unit("mouseover"):IsDead() and
                Unit("mouseover"):IsPlayer() and        
                (UnitInRaid("mouseover") or UnitInParty("mouseover")) and
                --MouseHasFrame() and
                A.Rebirth:IsSpellInRange("mouseover")
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit("mouseover"):IsExists() or 
                    IsUnitEnemy("mouseover")
                ) and
                Unit("target"):IsDead() and
                Unit("target"):IsPlayer() and
                (UnitInRaid("target") or UnitInParty("target")) and
                A.Rebirth:IsSpellInRange("target")
            )
        )
		then
		    return A.Rebirth:Show(icon)
        end
		
        -- RESS ALL PEOPLE
        if A.Revitalize:IsReady(unit) and
        Unit(player):CombatTime()==0 and
        Unit(player):GetCurrentSpeed()==0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit("mouseover"):IsExists() and        
                Unit("mouseover"):IsDead() and
                Unit("mouseover"):IsPlayer() and        
                (UnitInRaid("mouseover") or UnitInParty("mouseover")) and
                A.MouseHasFrame() and
                Unit("mouseover"):GetRange()<=100
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit("mouseover"):IsExists() or 
                    IsUnitEnemy("mouseover")
                ) and
                Unit("target"):IsDead() and
                Unit("target"):IsPlayer() and
                (UnitInRaid("target") or UnitInParty("target")) and
                Unit("target"):GetRange()<=100
            )
        )
		then
		    return A.Revitalize:Show(icon)
        end

        -- RESS Single
        if A.Revive:IsReady(unit) and
        Unit(player):CombatTime()==0 and
        Unit(player):GetCurrentSpeed()==0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit("mouseover"):IsExists() and        
                Unit("mouseover"):IsDead() and
                Unit("mouseover"):IsPlayer() and        
                not IsUnitEnemy("mouseover") and  
                A.MouseHasFrame() and
                A.Revive:IsSpellInRange("mouseover")
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit("mouseover"):IsExists() or 
                    IsUnitEnemy("mouseover")
                ) and
                Unit("target"):IsDead() and
                Unit("target"):IsPlayer() and
                not IsUnitEnemy("target") and
                A.Revive:IsSpellInRange("target")
            )
        )
		then
		    return A.Revive:Show(icon)
        end

        -- General Dispel
        if A.NaturesCure:IsReady(unit) and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit("mouseover"):IsExists() and 
                MouseHasFrame() and                      
                not IsUnitEnemy("mouseover") and         
                CanDispel("mouseover")
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit("mouseover"):IsExists() or 
                    IsUnitEnemy("mouseover")
                ) and        
                not IsUnitEnemy("target") and
                CanDispel("target")
            )
        )
		then
		    return A.NaturesCure:Show(icon)
        end

        -- PvP Mark of the Wild (precombat)
        if A.MarkoftheWild:IsReady(unit) and
        combatTime == 0 and
        --[[
        (
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 or
            Player:GetStance() == 3 or
            Player:GetStance() == 0  
        ) and
        ]]
        A.MarkoftheWild:IsSpellLearned() and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and   
                Unit(mouseover):HasDeBuffs(33786, true) == 0 and
                A.MarkoftheWild:IsSpellInRange(mouseover) and
                Unit(mouseover):PT(289318, nil, true)
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit(target):HasDeBuffs(33786, true) == 0 and
                A.MarkoftheWild:IsSpellInRange(target) and
                Unit(target):PT(289318, nil, true)
            )
        )
		then
		    return A.MarkoftheWild:Show(icon)
        end
        
        -- RPvP BearForm against CC casts
        if A.BearForm:IsReady(player) and
        combatTime > 0 and
        (
            (
                Player:GetStance() == 0 and
                Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) == 0 and    
                Unit(player):HasBuffs(117679, player, true) == 0 and -- Incarnation
                EnemyTeam():IsReshiftAble() 
            ) or
            (                
                -- Boomkin silence with roots
                Unit(player):HasDeBuffs(78675, true) > 0 and
                Unit(player):HasDeBuffs("Rooted") > 0
            )
        )
		then
		    return A.BearForm:Show(icon)
        end

        -- PvE Restor's Ironbark
        if A.Ironbark:IsReady(unit) and
        combatTime > 5 and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and 
                Unit(mouseover):GetRealTimeDMG() > 0 and
                Unit(mouseover):TimeToDie() < 9 and
                Unit(mouseover):Health() <= Unit(mouseover):HealthMax() * 0.6 and
                (
                    Unit(mouseover):GetHEAL() * 1.2 < Unit(mouseover):GetDMG() or
                    Unit(mouseover):Health() <= Unit(mouseover):GetDMG() * 2.2 
                ) and
                Unit(mouseover):HasBuffs("DeffBuffs") == 0 and               
                A.Ironbark:IsSpellInRange(mouseover) 
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit(target):GetRealTimeDMG() > 0 and
                Unit(target):TimeToDie() < 9 and
                Unit(target):Health() <= Unit(target):HealthMax() * 0.6 and
                (
                    Unit(target):GetHEAL() * 1.2 < Unit(target):GetDMG() or 
                    Unit(target):Health() <= Unit(target):GetDMG() * 2.2
                ) and
                Unit(target):HasBuffs("DeffBuffs") == 0 and               
                A.Ironbark:IsSpellInRange(target) 
            )
        )
		then
		    return A.Ironbark:Show(icon)
        end

        -- PvE Tranquility
        if A.Tranquility:IsReady(player) and
        A.BurstIsON(unit) and
        A.GetToggle(2, "AoE") and
        combatTime > 10 and
        (
            Player:GetStance() == 0 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        Unit(player):GetCurrentSpeed() == 0 and
        (        
            (
                TeamCache.Friendly.Size <= 2 and
                HealingEngine.GetBelowHealthPercentercentUnits(45) >= 2
            ) or
            (
                TeamCache.Friendly.Size <= 5 and
                HealingEngine.GetBelowHealthPercentercentUnits(60) >= 3
            ) or
            (
                TeamCache.Friendly.Size > 5 and      
                HealingEngine.GetBelowHealthPercentercentUnits(65) >= AoEMembers(true, _, 5)
            ) or     
            HealingEngine.GetHealthFrequency(GetGCD()*4) > 35
        )
		then
		    return A.Tranquility:Show(icon)
        end

        -- RPvE Incarnation
        if A.IncarnationTreeofLife:IsReady(player) and 
        A.BurstIsON(unit) and
        combatTime > 10 and
        A.IncarnationTreeofLife:IsSpellLearned() and
        Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) == 0 and
        (    
            -- Reshift to this form back
            (
                Unit(player):HasBuffs(117679, player, true) > 0 and
                Unit(player):HasBuffs(A.IncarnationTreeofLife.ID, player, true) == 0
            ) or
            -- HealingEngine conditions for burst raid/party heal
            (
                TeamCache.Friendly.Size > 1 and
                ReceivedLast5sec > AVG_DMG + AVG_HPS and
                HealingEngine.GetTimeToDieUnits(16) >= TeamCache.Friendly.Size * 0.67
            ) or
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                Unit("mouseover"):IsPlayer() and
                Unit(mouseover):CanInterract(40) and
                Unit(mouseover):Health() <= Unit(mouseover):HealthMax() * 0.35 and
                Unit(mouseover):GetDMG() * 1.2 > Unit(mouseover):GetHEAL() and
                Unit(mouseover):TimeToDie() > GetGCD() * 4
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit("target"):IsPlayer() and
                Unit(target):CanInterract(40) and 
                Unit(target):Health() <= Unit(target):HealthMax() * 0.35 and
                Unit(target):GetDMG() * 1.2 > Unit(target):GetHEAL() and
                Unit(target):TimeToDie() > GetGCD() * 4
            )
        )
		then
		    return A.IncarnationTreeofLife:Show(icon)
        end

        -- PvE Flourish
        if A.Flourish:IsReady(player) and
        A.BurstIsON(unit) and
        combatTime > 10 and
        A.Flourish:IsSpellLearned() and
        (
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 or
            Player:GetStance() == 3 or
            Player:GetStance() == 0  
        ) and
        (
            (    
                -- HealingEngine conditions for burst raid/party heal
                TeamCache.Friendly.Size and
                TeamCache.Friendly.Size > 1 and
                combatTime > 10 and
                ReceivedLast5sec > AVG_DMG + AVG_HPS and
                CanAoEFlourish(70)
            ) or
            (
                -- Combo Tranquility + Wild Growth 
                A.Tranquility:GetCooldown() >= 161 and
                A.LastPlayerCastID == 48438
            ) or
            (
                -- Burst heal target/mouseover if it dying and no burst heals
                not BurstBuffs() and
                (    
                    -- MouseOver
                    (
                        A.GetToggle(2, "mouseover") and
                        Unit(mouseover):IsExists() and 
                        A.MouseHasFrame() and
                        not Unit(mouseover):IsDead() and                
                        not IsUnitEnemy(mouseover) and                 
                        Unit("mouseover"):IsPlayer() and
                        Unit(mouseover):CanInterract(40) and
                        Unit(mouseover):TimeToDie() < 12 and
                        Unit(mouseover):Health() <= Unit(mouseover):HealthMax() * 0.45 and
                        Unit(mouseover):HasBuffs("DeffBuffs") == 0 and
                        -- Rejuvenation
                        Unit(mouseover):HasBuffs(774, player, true) > 0 and
                        -- Germination
                        (
                            A.Germination:IsSpellLearned() and 
                            Unit(mouseover):HasBuffs(155777, player, true) > 0
                        ) and
                        -- Lifebloom or Regrowth or Wild Growth
                        Unit(mouseover):HasBuffs({33763, 8936, 48438}, player, true) > 0 
                    ) or 
                    (
                        (
                            not A.GetToggle(2, "mouseover") or 
                            not Unit(mouseover):IsExists() or 
                            IsUnitEnemy(mouseover)
                        ) and
                        not Unit(target):IsDead() and
                        not IsUnitEnemy(target) and
                        Unit("target"):IsPlayer() and
                        Unit(target):CanInterract(40) and
                        Unit(mouseover):TimeToDie() < 12 and
                        Unit(target):Health() <= Unit(target):HealthMax() * 0.45 and
                        Unit(target):HasBuffs("DeffBuffs") == 0 and  
                        -- Rejuvenation
                        Unit(target):HasBuffs(774, player, true) > 0 and
                        -- Germination
                        (
                            A.Germination:IsSpellLearned() and 
                            Unit(target):HasBuffs(155777, player, true) > 0
                        ) and
                        -- Lifebloom or Regrowth or Wild Growth
                        Unit(target):HasBuffs({33763, 8936, 48438}, player, true) > 0
                    )
                )
            )
        )
		then
		    return A.Flourish:Show(icon)
        end

        -- RPvE Innervate
        if A.Innervate:IsReady(player) and 
        A.BurstIsON(unit) and
        combatTime > 20 and
		Player:Mana() < 80 and
        (
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 or
            Player:GetStance() == 0  
        ) and
        (    
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                Unit("mouseover"):IsPlayer() and
                Unit(mouseover):TimeToDie() > GetGCD() * 5 and
                Unit(mouseover):CanInterract(40) 
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit("target"):IsPlayer() and
                Unit(target):TimeToDie() > GetGCD() * 5 and
                Unit(target):CanInterract(40) 
            )
        )
		then
		    return A.Innervate:Show(icon)
        end

        -- Trinket1 
        if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DPS" and
        A.BurstIsON(unit) and
        (
            Player:GetStance() == 0 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        combatTime>0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and   
                Unit("mouseover"):IsPlayer() and
                Unit(mouseover):Health() <= Unit(mouseover):HealthMax() * 0.35 and
                Unit(mouseover):CanInterract(40)
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit("target"):IsPlayer() and
                Unit(target):Health() <= Unit(target):HealthMax() * 0.35 and
                Unit(target):CanInterract(40)
            )
        )
        then 
            return A.Trinket1:Show(icon)
        end 

        -- Trinket2
        if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DPS" and
        A.BurstIsON(unit) and
        (
            Player:GetStance() == 0 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        combatTime>0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and   
                Unit("mouseover"):IsPlayer() and
                Unit(mouseover):Health() <= Unit(mouseover):HealthMax() * 0.35 and
                Unit(mouseover):CanInterract(40)
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit("target"):IsPlayer() and
                Unit(target):Health() <= Unit(target):HealthMax() * 0.35 and
                Unit(target):CanInterract(40)
            )
        )
        then 
            return A.Trinket2:Show(icon)
        end 

        -- PvE Wild Growth
        if A.WildGrowth:IsReady(unit) and
        A.GetToggle(2, "AoE") and
        (
            TeamCache.Friendly.Type == "raid" or
            TeamCache.Friendly.Type == "party"
        ) and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        (
		    Unit(player):GetCurrentSpeed() == 0 
			or 
			A.EarlySpring:IsSpellLearned() -- PvP talent instant Wild Growth
		) and
        (
            (
                Unit(player):HasBuffs(29166, player, true) > 0 and
                Unit(player):HasBuffs(29166, player, true) > Unit(player):CastTime(48438) + GetCurrentGCD()
            ) or
            (
                TeamCache.Friendly.Size and 
                (
                    (
                        TeamCache.Friendly.Size > 5 and 
                        HealingEngine.HealingBySpell("Wild Growth", A.WildGrowth) >= 4
                    ) or
                    (
                        TeamCache.Friendly.Size <= 5 and 
                        HealingEngine.HealingBySpell("Wild Growth", A.WildGrowth) >= 3
                    )
                )
            ) or
            -- Tranquility
            A.LastPlayerCastID == 740 or
            HealingEngine.GetBuffsCount(157982, 0, player, true) >= 2
        ) and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.WildGrowth:IsSpellInRange(mouseover) 
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                A.WildGrowth:IsSpellInRange(target) 
            )
        ) and A.LastPlayerCastID ~= A.WildGrowth.ID -- Wild Growth
        then 
            return A.WildGrowth:Show(icon)
        end 


        -- PvE #1 Efflorescence (Innervate refresh)
        if A.Efflorescence:IsReady(player) and
        A.GetToggle(2, "AoE") and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        Unit(player):HasBuffs(29166, player, true) > GetCurrentGCD() + 0.2 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and  
                Unit("mouseover"):IsPlayer() and
                Unit(mouseover):CanInterract(40)
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit("target"):IsPlayer() and
                Unit(target):CanInterract(40)
            )
        ) and A.LastPlayerCastID ~= A.Efflorescence.ID -- Efflorescence
        then 
            return A.Efflorescence:Show(icon)
        end 


        -- RPvE #1 Swiftmend
        if A.Swiftmend:IsReady(unit) and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        -- Talent Soul of Forest
        Unit(player):HasBuffs(114108, player, true) == 0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.Swiftmend:IsSpellInRange(mouseover) and
                A.Swiftmend:PredictHeal("Swiftmend", "mouseover") and
                (
                    Unit(mouseover):Health() <= Unit(mouseover):HealthMax()*0.6 or
                    (
                        A.Prosperity:IsSpellLearned() and -- [talent:1/2]
                        A.Swiftmend:GetSpellChargesFrac() >= 1.8
                    )
                )
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                A.Swiftmend:IsSpellInRange(target) and
                A.Swiftmend:PredictHeal("Swiftmend", "target") and
                (
                    Unit(target):Health() <= Unit(target):HealthMax()*0.6 or
                    (
                        A.Prosperity:IsSpellLearned() and -- [talent:1/2]
                        A.Swiftmend:GetSpellChargesFrac() >= 1.8
                    )
                )
            )
        )
        then 
            return A.Swiftmend:Show(icon)
        end 


        -- RPvE #1 Regrowth (Clearcasting, Soul of Forest, Incarnation)
        --Note: Soul of Forest should be used if hots is not refresh able
        if A.Regrowth:IsReady(unit) and
        (
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 or
            Unit(player):GetCurrentSpeed() == 0
            --[[
            (
                Unit(player):GetCurrentSpeed() == 0 and
                (
                    Player:GetStance() == 3 or
                    Player:GetStance() == 0  
                )
            )
        ]]
        ) and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.Regrowth:IsSpellInRange(mouseover) and
                A.Regrowth:PredictHeal("Regrowth", "mouseover") and
                (
                    Unit(player):HasBuffs(A.ClearCasting.ID, player, true) > 0 or -- Clearcasting
                    (
                        -- Talent Soul of Forest
                        Unit(player):HasBuffs(114108, player, true) > 0 and
                        Unit(player):HasBuffs(114108, player, true) < 2 and
                        not Unit(mouseover):PT(774, nil, true) and -- Rejuvenation
                        (
                            not A.Germination:IsSpellLearned() or -- Germination
                            not Unit(mouseover):PT(114108, nil, true)
                        )
                    ) or
                    (
                        Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 and
                        Unit(mouseover):PT(8936, nil, true) -- Regrowth
                    )
                )
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                A.Regrowth:IsSpellInRange(target) and
                A.Regrowth:PredictHeal("Regrowth", "target") and
                (
                    Unit(player):HasBuffs(A.ClearCasting.ID, player, true) > 0 or -- Clearcasting
                    (
                        -- Talent Soul of Forest
                        Unit(player):HasBuffs(114108, player, true) > 0 and
                        Unit(player):HasBuffs(114108, player, true) < 2 and
                        not Unit(target):PT(774, nil, true) and -- Rejuvenation
                        (
                            not A.Germination:IsSpellLearned() or -- Germination
                            not Unit(target):PT(114108, nil, true)
                        )
                    ) or
                    (
                        Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 and
                        Unit(target):PT(8936, nil, true) -- Regrowth
                    )
                )
            )
        ) and
        select(2, Unit(player):CastTime()) == 0 -- no casting
        then 
            return A.Regrowth:Show(icon)
        end 

        -- RPvP Overgrowth
        if A.Overgrowth:IsReady(unit) and
        --[[
        (
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 or
            Player:GetStance() == 3 or
            Player:GetStance() == 0 
        ) and
        ]]
        A.Overgrowth:IsSpellLearned() and -- Overgrowth
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and       
                Unit("mouseover"):IsPlayer() and
                Unit(mouseover):HasDeBuffs(33786, true) and
                Unit(mouseover):HasDeBuffs(33786, true) <= GetCurrentGCD() + 0.1 and
                A.Overgrowth:IsSpellInRange(mouseover) and
                A.Overgrowth:PredictHeal("Overgrowth", "mouseover") and
                Unit(mouseover):Health() <= Unit(mouseover):HealthMax() * 0.8
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit("target"):IsPlayer() and
                Unit(target):HasDeBuffs(33786, true) and
                Unit(target):HasDeBuffs(33786, true) <= GetCurrentGCD() + 0.1 and
                A.Overgrowth:IsSpellInRange(target) and
                A.Overgrowth:PredictHeal("Overgrowth", "target") and
                Unit(target):Health() <= Unit(target):HealthMax() * 0.8
            )
        )
        then 
            return A.Overgrowth:Show(icon)
        end

        -- RPvP Nourish
        if A.Nourish:IsReady(unit) and
        --[[
        (
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 or
            Player:GetStance() == 3 or
            Player:GetStance() == 0 
        ) and
        ]]
        A.Nourish:IsSpellLearned() and
        Unit(player):GetCurrentSpeed() == 0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and    
                Unit(mouseover):HasDeBuffs(33786, true) and   
                Unit(mouseover):HasDeBuffs(33786, true) <= Unit(player):CastTime(289022) + GetCurrentGCD() and
                A.Nourish:IsSpellInRange(mouseover) and
                A.Nourish:PredictHeal("Nourish", "mouseover")
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit(target):HasDeBuffs(33786, true) and
                Unit(target):HasDeBuffs(33786, true) <= Unit(player):CastTime(289022) + GetCurrentGCD() and
                A.Nourish:IsSpellInRange(target) and
                A.Nourish:PredictHeal("Nourish", "target")
            )
        ) and
        select(2, Unit(player):CastTime()) == 0 -- no casting
        then 
            return A.Nourish:Show(icon)
        end



        -- PvE Lifebloom
        if A.Lifebloom:IsReady(unit) and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.Lifebloom:IsSpellInRange(mouseover) and
                A.Lifebloom:PredictHeal("Lifebloom", "mouseover") and
                Unit(mouseover):HasBuffs(33763, player, true) == 0 and
                (
                    (
                        HealingEngine.IsMostlyIncDMG(mouseover) and
                        Unit(mouseover):GetRealTimeDMG() > 0
                    ) or
                    Unit(mouseover):Role("TANK") or
                    combatTime == 0 or
                    -- Lifebloom Tracker (is not applied for any one unit)
                    A.HealingEngine.GetBuffsCount(33763, 0, player, true) == 0 or
                    -- Photosynthesis
                    (
                        A.Photosynthesis:IsSpellLearned() and
                        UnitIsUnit(mouseover, player)
                    )
                )
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                A.Lifebloom:IsSpellInRange(target) and
                A.Lifebloom:PredictHeal("Lifebloom", "target") and
                Unit(target):HasBuffs(33763, player, true) == 0 and
                (
                    (
                        HealingEngine.IsMostlyIncDMG(target) and
                        Unit(target):GetRealTimeDMG() > 0
                    ) or
                    Unit(target):Role("TANK") or
                    combatTime == 0 or
                    -- Lifebloom Tracker (is not applied for any one unit)
                    A.HealingEngine.GetBuffsCount(33763, 0, player, true) == 0 or
                    -- Photosynthesis
                    (
                        A.Photosynthesis:IsSpellLearned() and
                        UnitIsUnit(target, player)
                    )
                )
            )
        )
        then 
            return A.Lifebloom:Show(icon)
        end


        -- PvE Cenarion Ward
        if A.CenarionWard:IsReady(unit) and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        combatTime > 3 and
        A.CenarionWard:IsSpellLearned() and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.CenarionWard:IsSpellInRange(mouseover) and
                A.CenarionWard:PredictHeal("Cenarion Ward", "mouseover") and
                (
            
                    (
                        HealingEngine.IsMostlyIncDMG(mouseover) and
                        Unit(mouseover):Health() <= Unit(mouseover):HealthMax()*0.9
                    ) or
                    Unit(mouseover):Role("TANK")
                )
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                A.CenarionWard:IsSpellInRange(target) and
                A.CenarionWard:PredictHeal("Cenarion Ward", "target") and
                (
                    (
                        HealingEngine.IsMostlyIncDMG(target) and
                        Unit(target):Health() <= Unit(target):HealthMax()*0.9
                    ) or
                    Unit(target):Role("TANK")
                )
            )
        )
        then 
            return A.CenarionWard:Show(icon)
        end
        
		-- Rejuvenation Sniper
		if (IsInGroup() or IsInRaid()) and A.GetToggle(2, "SnipeFriendly") then
		    SetFriendlyToSnipe()
			if A.Rejuvenation:IsReady(unit) then
			    return A.Rejuvenation:Show(icon)
			end
        end
		
        -- PvE Rejuvenation
        if A.Rejuvenation:IsReady(unit) and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.Rejuvenation:IsSpellInRange(mouseover) and
                A.Rejuvenation:PredictHeal("Rejuvenation", "mouseover") and
                (
                    Unit(mouseover):PT(774, nil, true) or
                    (
                        A.Germination:IsSpellLearned() and -- Germination
                        Unit(mouseover):PT(155777, nil, true)
                    )
                )
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                A.Rejuvenation:IsSpellInRange(target) and
                A.Rejuvenation:PredictHeal("Rejuvenation", "target") and
                (
                    Unit(target):PT(774, nil, true) or
                    (
                        A.Germination:IsSpellLearned() and -- Germination
                        Unit(target):PT(155777, nil, true)
                    )
                )
            ) 
        )
        then 
            return A.Rejuvenation:Show(icon)
        end


        -- RPvE #2 Swiftmend
        if A.Swiftmend:IsReady(unit) and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        -- Talent Soul of Forest
        Unit(player):HasBuffs(114108, player, true) == 0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.Swiftmend:IsSpellInRange(mouseover) and
                A.Swiftmend:PredictHeal("Swiftmend", "mouseover") and
                Unit(mouseover):Health() <= Unit(mouseover):HealthMax()*0.75
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                A.Swiftmend:IsSpellInRange(target) and
                A.Swiftmend:PredictHeal("Swiftmend", "target") and
                Unit(target):Health() <= Unit(target):HealthMax()*0.75
            )
        )
        then 
            return A.Swiftmend:Show(icon)
        end


        -- PvE #2 Efflorescence
        --if we have 3+ melee units which can be healed or while run 
        if A.Efflorescence:IsReady(player) and
        A.GetToggle(2, "AoE") and
        --[[
        (
            Player:GetStance() == 0 or
            Player:GetStance() == 3 or
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0
        ) and
        ]]
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and  
                Unit("mouseover"):IsPlayer() and
                Unit(mouseover):CanInterract(40) and
                (
                    Unit(player):GetCurrentSpeed() > 0 or
                    not Unit(mouseover):PT(8936, nil, true) -- Regrowth   
                ) and
                A.Efflorescence:PredictHeal("Efflorescence", "mouseover")        
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                Unit("target"):IsPlayer() and
                Unit(target):CanInterract(40) and
                (
                    Unit(player):GetCurrentSpeed() > 0 or
                    not Unit(target):PT(8936, nil, true) -- Regrowth   
               ) and
                A.Efflorescence:PredictHeal("Efflorescence", "target") 
            ) or
            HealingEngine.HealingByRange(40, "Efflorescence", A.Efflorescence, true) >= 3
        ) and
        A.LastPlayerCastID~=145205 -- Efflorescence
        then 
            return A.Efflorescence:Show(icon)
        end


        -- RPvE #2 Regrowth
        if A.Regrowth:IsReady(unit) and
        (
            Unit(player):HasBuffs(A.IncarnationTreeofLifeBuff.ID, player, true) > 0 or
            Unit(player):GetCurrentSpeed() == 0
            --[[
            (
                (
                    Player:GetStance() == 3 or
                    Player:GetStance() == 0 
                ) and
                Unit(player):GetCurrentSpeed() == 0
            )  
        ]]   
        ) and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.Regrowth:IsSpellInRange(mouseover) and
                Unit(mouseover):HealthPercent() <= 95 and
                A.Regrowth:PredictHeal("Regrowth", "mouseover") and
                (
                    TeamCache.Friendly.Size <= 5 or
                    Unit(mouseover):Role("TANK") or
                    Unit(mouseover):HealthPercent() <= 40
                )
            ) or 
            (
                (
                    not A.GetToggle(2, "mouseover") or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and
                not Unit(target):IsDead() and
                not IsUnitEnemy(target) and
                A.Regrowth:IsSpellInRange(target) and
                Unit(target):HealthPercent() <= 95 and
                A.Regrowth:PredictHeal("Regrowth", "target") and
                (
                    TeamCache.Friendly.Size <= 5 or
                    Unit(target):Role("TANK") or
                    Unit(target):HealthPercent() <= 40
                )
            )
        ) and
        select(2, Unit(player):CastTime()) == 0 -- no casting
        then 
            return A.Regrowth:Show(icon)
        end	
		
    end 
    HealingRotation = Action.MakeFunctionCachedDynamic(HealingRotation)
	
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
	
	-- Friendly Mouseover
    if A.IsUnitFriendly(mouseover) then 
        unit = mouseover  
		
        if HealingRotation(unit) then 
            return true 
        end             
    end
    
    -- Enemy Mouseover 
    if A.IsUnitEnemy(mouseover) then 
        unit = mouseover	
		
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    -- DPS Target     
    if A.IsUnitEnemy(target) then 
        unit = target
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 

    -- DPS targettarget     
    if A.IsUnitEnemy(targettarget) then 
        unit = targettarget
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
	
    -- Heal Target 
    if A.IsUnitFriendly(target) then 
        unit = target 
		
        if HealingRotation(unit) then 
            return true 
        end 
    end    
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    --if Player:IsMovingTime() < 2.5 then 
    --    return 
    --end 
        
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

local function RotationPassive(icon)
    if not GetToggle(2, "UseRotationPassive") then 
        return 
    end 
    RotationsVariables()


    -- Passive Renewal
    if A.Renewal:IsReady(player) and 
    Unit(player):CombatTime()>0 and
    (
        --MacroSpells("Icon6", "Renewal") or
        (
            --deff_toggle and
            Unit(player):GetDMG()>0 and        
            (
                Unit(player):Health()<=Unit(player):HealthMax()*0.21 or
                (
                    A.IsInPvP and
                    Unit(player):UseDeff() and
                    (
                        FriendlyTeam("HEALER"):GetCC() >= 3 or
                        Unit(player):HasSpec(105) -- Restor
                    ) and
                    Unit(player):IsFocused() and
                    (
                    
                        Unit(player):TimeToDie()<=11 or
                        Unit(player):IsExecuted()            
                    )        
                )
            )        
        )    
    )
    then 
        return A.Renewal:Show(icon)
    end	


    -- Thorns Player
    if A.Thorns:IsReady(player) and 
    Unit(player):CombatTime()>0 and
    A.Thorns:IsSpellLearned() and
    (
        (
            --Thorns_toggle and
            not BurstBuffs() and
            Unit("player"):IsFocused("MELEE")
        ) 
    )
    then 
        return A.Thorns:Show(icon)
    end	
  
end 


-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
--[[local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit(player):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end ]]--


local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "arena") and (unit == "arena1" or unit == "arena2" or unit == "arena3") and not Player:IsStealthed() and not Player:IsMounted() then

        -- EntanglingRoots Arena
        if A.EntanglingRoots:IsReady(unit) and 
        PvPEntanglingRoots(unit) and 
        Unit(unit):HasBuffs("Reflect") == 0 and
        Unit(unit):HasBuffs("CCMagicImun") == 0 and
        Unit(unit):HasBuffs("CCTotalImun") == 0
        then
		    return A.EntanglingRoots
		end

        -- Soothe Arena
        if A.Soothe:IsReady(unit) and 
        --Soothe_toggle and
        not UnitIsUnit("target", unit) and  
        --not InLOS("arena1") and
        A.Soothe:IsSpellInRange(unit) and
        (
            (
                UnitClass(unit) == "WARRIOR" and
                Unit(unit):HasBuffs("Rage")>2
            ) or
            (
                PvPEnemyIsHealer(unit) and
                Unit(unit):HasBuffs("Reflect")>2        
            )
        )
        then
		    return A.Soothe
		end
    end 
end 

local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

    -- Dispel Party1
    if A.NaturesCure:IsReady(unit) and
    CanDispel(unit)
    then
	    return A.NaturesCure
	end
	
    -- Thorns Party1
    if A.Thorns:IsReady(unit) and
    Unit(player):CombatTime()>0 and
    A.Thorns:IsSpellLearned() and
    A.Thorns:IsSpellInRange(unit) and
    Unit(unit):HasDeBuffs(33786, true) == 0 and -- Cyclone
    --not InLOS("party1") and 
    (
        (
            --Thorns_toggle and
            not BurstBuffs() and
            Unit(unit):IsFocused("MELEE")
        ) 
    )
    then
	    return A.Thorns
	end

    
end 

A[6] = function(icon)
    -- Call rotations variables
	RotationsVariables()
	
    -- StopCast OverHeal
   -- if Temp.LastPrimaryUnitID and CanStopCastingOverHeal() and StopCastOverHeal then 
   --     return A:Show(icon, ACTION_CONST_STOPCAST)
  --  end

    -- Stop Cast M+ Quake Affix
    if Unit(player):IsCastingRemains() > 0 and StopCastQuake and Unit(player):HasDeBuffs(A.Quake.ID) <= StopCastQuakeSec and Unit(player):HasDeBuffs(A.Quake.ID) > 0 then
        return A:Show(icon, ACTION_CONST_STOPCAST)
    end
  
    if RotationPassive(icon) then 
        return true 
    end 
    
    local Arena = ArenaRotation("arena1")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[7] = function(icon)
    if RotationPassive(icon) then 
        return true 
    end 
    
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end   
    
    local Arena = ArenaRotation("arena2")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[8] = function(icon)
    if RotationPassive(icon) then 
        return true 
    end 
    
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    local Arena = ArenaRotation("arena3")
    if Arena then 
        return Arena:Show(icon)
    end 
end