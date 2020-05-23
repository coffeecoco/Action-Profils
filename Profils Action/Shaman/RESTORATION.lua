-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local Action                                 = Action
local Listener                                 = Action.Listener
local Create                                 = Action.Create
local GetSpellInfo                            = Action.GetSpellInfo
local GetToggle                                = Action.GetToggle
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local ShouldStop                            = Action.ShouldStop
local AuraIsValid                            = Action.AuraIsValid
local InterruptIsValid                        = Action.InterruptIsValid
local BurstIsON                                = Action.BurstIsON
local BossMods_Pulling                        = Action.BossMods_Pulling
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local IsUnitEnemy                            = Action.IsUnitEnemy 
local IsUnitFriendly                        = Action.IsUnitFriendly 
local TeamCacheFriendly                        = TeamCache.Friendly
local HealingEngineMembersALL                = HealingEngine.GetMembersAll() -- function call!
local HealingEngineGetMinimumUnits            = HealingEngine.GetMinimumUnits
local HealingEngineGetIncomingDMGAVG        = HealingEngine.GetIncomingDMGAVG
local HealingEngineGetIncomingHPSAVG        = HealingEngine.GetIncomingHPSAVG
local _G, setmetatable, select, math        = _G, setmetatable, select, math 
local ACTION_CONST_STOPCAST                    = _G.ACTION_CONST_STOPCAST
local ACTION_CONST_SPELLID_FREEZING_TRAP    = _G.ACTION_CONST_SPELLID_FREEZING_TRAP
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local select, unpack, table                     = select, unpack, table 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local _G, setmetatable, select, math            = _G, setmetatable, select, math 
local huge                                      = math.huge  
local UIParent                                  = _G.UIParent 
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType 


-- Spells
Action[ACTION_CONST_SHAMAN_RESTORATION] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Main Spells
    Riptide                                = Action.Create({ Type = "Spell", ID = 61295   }),
	HealingSurge                           = Action.Create({ Type = "Spell", ID = 8004   }),
	HealingWave                            = Action.Create({ Type = "Spell", ID = 77472   }),	
	ChainHeal                              = Action.Create({ Type = "Spell", ID = 1064   }),
	HealingRain                            = Action.Create({ Type = "Spell", ID = 73920   }),
	HealingStreamTotem                     = Action.Create({ Type = "Spell", ID = 5394   }),
	TidalWaveBuff                          = Action.Create({ Type = "Spell", ID = 53390   }),
	-- Offensive Abilities
	FlameShock                             = Action.Create({ Type = "Spell", ID = 188838   }),
	FlameShockDebuff                       = Action.Create({ Type = "Spell", ID = 188389   }),
	LavaBurst                              = Action.Create({ Type = "Spell", ID = 51505   }),
	LightningBolt                          = Action.Create({ Type = "Spell", ID = 403   }),
	ChainLightning                         = Action.Create({ Type = "Spell", ID = 421   }),
	-- Cooldowns
	HealingTideTotem                       = Action.Create({ Type = "Spell", ID = 108280   }),
	SpiritLinkTotem                        = Action.Create({ Type = "Spell", ID = 98008   }),
	SpiritWalkersGrace                     = Action.Create({ Type = "Spell", ID = 79206   }),
	UnleashLife                            = Action.Create({ Type = "Spell", ID = 73685   }), -- Increase next direct heal by 35%
	Ascendance                             = Action.Create({ Type = "Spell", ID = 114052   }),
	-- Totems
	CloudburstTotem                        = Action.Create({ Type = "Spell", ID = 157153   }), -- Talent, replace HealingStreamTotem
	AncestralProtectionTotem               = Action.Create({ Type = "Spell", ID = 207399   }), -- Incoming death on critical unit
	WindRushTotem                          = Action.Create({ Type = "Spell", ID = 192077   }), -- Speed
	EarthgrabTotem                         = Action.Create({ Type = "Spell", ID = 51485   }), -- Rooted
	EarthenWallTotem                       = Action.Create({ Type = "Spell", ID = 198838   }), -- Shield phys
	EarthbindTotem                         = Action.Create({ Type = "Spell", ID = 2484   }), -- Slow
	CapacitorTotem                         = Action.Create({ Type = "Spell", ID = 192058   }), -- Stun
	TremorTotem                            = Action.Create({ Type = "Spell", ID = 8143   }), -- Antifear
	SkyfuryTotem                           = Action.Create({ Type = "Spell", ID = 204330   }), -- Burst
	-- Talents
	HighTide                               = Action.Create({ Type = "Spell", ID = 157154, Hidden = true     }),
	EchooftheElements                      = Action.Create({ Type = "Spell", ID = 108283, Hidden = true     }),
	AncestralVigor                         = Action.Create({ Type = "Spell", ID = 207401, Hidden = true     }),
	FlashFlood                             = Action.Create({ Type = "Spell", ID = 280614, Hidden = true     }),
	Torrent                                = Action.Create({ Type = "Spell", ID = 200072, Hidden = true     }),
	Undulation                             = Action.Create({ Type = "Spell", ID = 200071, Hidden = true     }),
	SpiritWolf                             = Action.Create({ Type = "Spell", ID = 260878, Hidden = true     }),
	EarthShield                            = Action.Create({ Type = "Spell", ID = 974, Hidden = true     }),
	Wellspring                             = Action.Create({ Type = "Spell", ID = 197995, Hidden = true     }),
	-- Defensives
	AstralShift                            = Action.Create({ Type = "Spell", ID = 108271   }),
	-- Utilities
	AncestralSpirit                        = Action.Create({ Type = "Spell", ID = 2008   }),
	AncestralVision                        = Action.Create({ Type = "Spell", ID = 212048   }),
	AstralRecall                           = Action.Create({ Type = "Spell", ID = 556   }),
	FarSight                               = Action.Create({ Type = "Spell", ID = 6196   }),
	GhostWolf                              = Action.Create({ Type = "Spell", ID = 2645   }),
	Bloodlust                              = Action.Create({ Type = "Spell", ID = 2825   }),
	Heroism                                = Action.Create({ Type = "Spell", ID = 32182   }),
	Hex                                    = Action.Create({ Type = "Spell", ID = 51514   }),
    HexGreen                               = Action.Create({ Type = "SpellSingleColor", ID = 51514, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
	Purge                                  = Action.Create({ Type = "Spell", ID = 370   }),
	PurifySpirit                           = Action.Create({ Type = "Spell", ID = 77130   }),
	WaterWalking                           = Action.Create({ Type = "Spell", ID = 546   }),
	AncestralGift                          = Action.Create({ Type = "Spell", ID = 290254, Hidden = true}), -- PvP Talent - Silence and interrupt immune
	WindShear                              = Action.Create({ Type = "Spell", ID = 57994   }),
    WindShearAntiFake                      = Action.Create({ Type = "Spell", ID = 57994, Desc = "[2] Kick", QueueForbidden = true    }),
	EarthElemental                         = Action.Create({ Type = "Spell", ID = 198103   }),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	
	--Mythic Plus Spells 
	Quake                                  = Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
	Burst                                  = Create({ Type = "Spell", ID = 240443, Hidden = true     }), -- Bursting (Mythic Plus Affix) Upon death the creature Bursts, inflicting damage equal to (35 / 10)% of maximum health every 1 sec.
	GrievousWound                          = Create({ Type = "Spell", ID = 240559, Hidden = true     }), -- Grievous (Mythic Plus Affix) 2% of a player's maximum health every 3 sec
    Slow                                   = Create({ Type = "Spell", ID = 313255, Hidden = true     }), -- Shadhar slow
	Fixate                                 = Create({ Type = "Spell", ID = 318078, Hidden = true     }), -- Wrathion Fixate
	Cyclone                                = Create({ Type = "Spell", ID = 33786, Hidden = true   }), -- Debuff check
	Innervate                              = Create({ Type = "Spell", ID = 29166, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_SHAMAN_RESTORATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_RESTORATION], { __index = Action })


local player = "player"
local targettarget = "targettarget"
local target = "target"
local mouseover = "mouseover"

local Temp                                  = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = 
GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- Call to avoid lua limit of 60upvalues 
-- Call RotationsVariables in each function that need these vars
local function RotationsVariables()
    combatTime = Unit(player):CombatTime()
	inCombat = Unit(player):CombatTime() > 0
    UseDBM = GetToggle(1 ,"DBM") -- Don't call it DBM else it broke all the global DBM var used by another addons
    Potion = GetToggle(1, "Potion")
    Racial = GetToggle(1, "Racial")
    HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
	MouseOver = GetToggle(2, "mouseover")
    StartByPreCast = GetToggle(2, "StartByPreCast")
    TrinketMana = GetToggle(2, "TrinketMana")
	MythicPlusLogic = GetToggle(2, "MythicPlusLogic")
	StopCastOverHeal = GetToggle(2, "StopCastOverHeal")
	StopCastQuake = GetToggle(2, "StopCastQuake")
	StopCastQuakeSec = GetToggle(2, "StopCastQuakeSec")
	GrievousWoundsLogic = GetToggle(2, "GrievousWoundsLogic")
	GrievousWoundsMinStacks = GetToggle(2, "GrievousWoundsMinStacks")
	HealingStreamTotemRefresh = GetToggle(2, "HealingStreamTotemRefresh")
	HealingRainRefresh = GetToggle(2, "HealingRainRefresh")
	AoEON = GetToggle(2, "AoE")
	EarthShieldWorkMode = GetToggle(2, "EarthShieldWorkMode")
end

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    IsUnitEnemy(unit) and 
    Unit(unit):IsControlAble("incapacitate", 0) and 
    A.HexGreen:AbsentImun(unit, Temp.TotalAndPhysAndCC, true)          
end 
A[1] = function(icon)    
    if     A.HexGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        AntiFakeStun("targettarget") or 
        (
            not IsUnitEnemy("mouseover") and 
            not IsUnitEnemy("target") and             
            not IsUnitEnemy("targettarget") 
        )
    )
    then 
        return A.HexGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif IsUnitEnemy("target") then 
        unit = "target"
    elseif IsUnitEnemy("targettarget") then 
        unit = "targettarget"
    end 
    
    if unit then         
        local total, sleft, _, _, _, notKickAble = Unit(unit):CastTime()
        if sleft > 0 then                                     
            if A.WindShearAntiFake:IsReady(unit) and A.WindShearAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then
                return A.WindShearAntiFake:Show(icon)                  
            end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

-----------------------------------------
--                 ROTATION  
-----------------------------------------

local function IsEnoughHPS(unit)
    return Unit(player):GetHPS() > Unit(unit):GetDMG()
end 

local function IsSaveManaPhase()
    if not A.IsInPvP and GetToggle(2, "ManaManagement") and Unit(player):HasBuffs(A.Innervate.ID) == 0 then 
        local bossID
        for i = 1, MAX_BOSS_FRAMES do 
            bossID = "boss" .. i
            if Unit(bossID):IsExists() and not Unit(bossID):IsDead() and Unit(player):PowerPercent() < Unit(bossID):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit(player):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)

local function HealingRainDuration()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 136037 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end
HealingRainDuration = A.MakeFunctionCachedStatic(HealingRainDuration)

local function HealingStreamTotemDuration()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 5394 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end
HealingStreamTotemDuration = A.MakeFunctionCachedStatic(HealingStreamTotemDuration)

local function CloudburstTotemDuration()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 157153 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end
CloudburstTotemDuration = A.MakeFunctionCachedStatic(CloudburstTotemDuration)

-- Cached parts 
-- PvP: Balance Solar Interrupt 
UnitCooldown:Register("arena", 78675, 60) 
-- PvP: Mage Counterspell
UnitCooldown:Register("arena", 2139, 24)
-- SpiritWalkersGrace with AncestralGift talent to give player silence and interrupt immunities
local function CanSpiritWalkersGrace(mode)
    if A.IsInPvP and A.SpiritWalkersGrace:IsReady("player") and Unit(player):HasBuffs(A.SpiritWalkersGrace.ID, true) == 0 and A.AncestralGift:IsSpellLearned() then 
        -- If melee is around (doesn't tracking their kick but anyway)
        if not mode and EnemyTeam("DAMAGER_MELEE"):GetUnitID(15) ~= "none" then 
            return true 
        end 
        
        -- Catch Balance Interrupt if enemy in burst or while rooted
        if UnitCooldown:GetCooldown("arena", 78675) == 0 then 
            local UnitBalance = EnemyTeam("DAMAGER_RANGE"):GetUnitID(40, 102)         
            if UnitBalance ~= "none" and Unit(UnitBalance):InCC() == 0 and Unit(player):HasBuffs("Reflect") == 0 then
                -- If rooted 
                if mode == "CATCH" and LoC:Get("ROOT") > 0 then 
                    return true   
                end 
                -- If bursting 
                if not mode and (EnemyTeam("DAMAGER"):GetBuffs("DamageBuffs", 40) > 0 or FriendlyTeam():GetTTD(1, 8)) then 
                    return true 
                end 
            end 
        end 
        
        -- Catch Mage Interrupt if enemy in burst or through Blink / Shrimmer 
        if not mode and UnitCooldown:GetCooldown("arena", 2139) == 0 then 
            local UnitMage = EnemyTeam("DAMAGER_RANGE"):GetUnitID(60, {62, 63, 64})
            if UnitMage ~= "none" and Unit(UnitMage):InCC() == 0 and Unit(player):HasBuffs("Reflect") == 0 then
                -- If Blink / Shrimmer  
                if Unit(UnitMage):GetRange() > 40 and Unit(UnitMage):GetBlinkOrShrimmer() <= 1.5 then 
                    return true   
                end 
                -- If bursting 
                if EnemyTeam("DAMAGER"):GetBuffs("DamageBuffs", 40) > 0 or FriendlyTeam():GetTTD(1, 8) then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanSpiritWalkersGrace = A.MakeFunctionCachedDynamic(CanSpiritWalkersGrace)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    if CanSpiritWalkersGrace("CATCH") then 
        return A.SpiritWalkersGrace
    end 
    
    -- EarthShieldHP
    local EarthShield = A.GetToggle(2, "EarthShieldHP")
    if     EarthShield >= 0 and A.EarthShield:IsReady("player") and  
    (
        (     -- Auto 
            EarthShield >= 100 and 
            (
                Unit("player"):HasBuffsStacks(A.EarthShield.ID, true) <= 3 
                or A.IsInPvP and Unit("player"):HasBuffsStacks(A.EarthShield.ID, true) <= 2
            ) 
        ) or 
        (    -- Custom
            EarthShield < 100 and 
            Unit("player"):HasBuffs(A.EarthShield.ID, true) <= 5 and 
            Unit("player"):HealthPercent() <= EarthShield
        )
    ) 
    then 
        return A.EarthShield
    end
        
    -- Abyssal Healing Potion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 25
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 25 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end  
    
    -- AstralShift
    local AstralShift = A.GetToggle(2, "AstralShiftHP")
    if     AstralShift >= 0 and A.AstralShift:IsReady("player") and 
    (
        (     -- Auto 
            AstralShift >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AstralShift < 100 and 
            Unit("player"):HealthPercent() <= AstralShift
        )
    ) 
    then 
        return A.AstralShift
    end   
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 

local function Interrupts(unit)
    local useKick, useCC, useRacial = InterruptIsValid(unit, "TargetMouseover")
    
    if useKick and A.WindShear:IsReady(unit) and A.WindShear:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then 
        return A.WindShear              
    end   
	
    if useCC and A.Hex:IsReady(unit) and A.Hex:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        return A.Hex              
    end  
	
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        return A.BullRush
    end      
	
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CanHealingTideTotem()
    if A.HealingTideTotem:IsReady("player", true, nil, nil) and IsSchoolFree() then 
        local HealingTideTotemHP = GetToggle(2, "HealingTideTotemHP")
        local HealingTideTotemUnits = GetToggle(2, "HealingTideTotemUnits") 
        
        -- Auto Counter
        if HealingTideTotemUnits > 40 then 
            HealingTideTotemUnits = HealingEngineGetMinimumUnits(1)
            -- Reduce size in raid by 20%
            if HealingTideTotemUnits > 5 then 
                HealingTideTotemUnits = HealingTideTotemUnits - (#HealingEngineMembersALL * 0.2)
            end 
            -- If user typed counter higher than max available members 
        elseif HealingTideTotemUnits >= TeamCacheFriendly.Size then 
            HealingTideTotemUnits = TeamCacheFriendly.Size
        end 
        
        if HealingTideTotemUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #HealingEngineMembersALL do 
            -- Auto HP 
            if HealingTideTotemHP >= 100 and A.HealingTideTotem:PredictHeal("HealingTideTotem", HealingEngineMembersALL[i].Unit, 400) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if HealingTideTotemHP < 100 and HealingEngineMembersALL[i].HP <= HealingTideTotemHP then 
                counter = counter + 1
            end 
            
            if counter >= HealingTideTotemUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanHealingTideTotem = A.MakeFunctionCachedStatic(CanHealingTideTotem)

local function CanHealingStreamTotem()
    if A.HealingStreamTotem:IsReady(unit, true, nil, nil) and IsSchoolFree() then 
        local HealingStreamTotemHP = GetToggle(2, "HealingStreamTotemHP")
        local HealingStreamTotemUnits = GetToggle(2, "HealingStreamTotemUnits") 
        
        -- Auto Counter
        if HealingStreamTotemUnits > 40 then 
            HealingStreamTotemUnits = HealingEngineGetMinimumUnits(1)
            -- Reduce size in raid by 35%
            if HealingStreamTotemUnits > 5 then 
                HealingStreamTotemUnits = HealingStreamTotemUnits - (#HealingEngineMembersALL * 0.35)
            end 
            -- If user typed counter higher than max available members 
        elseif HealingStreamTotemUnits >= TeamCacheFriendly.Size then 
            HealingStreamTotemUnits = TeamCacheFriendly.Size
        end 
        
        if HealingStreamTotemUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #HealingEngineMembersALL do 
            -- Auto HP 
            if HealingStreamTotemHP >= 100 and A.HealingStreamTotem:PredictHeal("HealingStreamTotem", HealingEngineMembersALL[i].Unit, 1500) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if HealingStreamTotemHP < 100 and HealingEngineMembersALL[i].HP <= HealingStreamTotemHP then 
                counter = counter + 1
            end 
            
            if counter >= HealingStreamTotemUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanHealingStreamTotem = A.MakeFunctionCachedStatic(CanHealingStreamTotem)

local function UrgentMythicPlusTargetting()
    
    local getmembersAll = HealingEngine.GetMembersAll()
	local BleedFriendCount = 0
	local BleedStack = 0
	RotationsVariables()
	
	if MythicPlusLogic then
	
        -- Junkyard
        if inCombat and select(8, GetInstanceInfo()) == 2097 then
            for i = 1, #getmembersAll do
                if Unit(getmembersAll[i].Unit):HasDeBuffs(302274, true) ~= 0 --Fulminating Zap
                        and Unit(getmembersAll[i].Unit):HealthPercent() < 80 
				then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)
                end
            end
        end
		
        -- Waycrest Manor
        if inCombat and select(8, GetInstanceInfo()) == 1862 then
            for i = 1, #getmembersAll do
                if Unit(getmembersAll[i].Unit):HasDeBuffs(260741, true) ~= 0 --Jagged Nettles
                        and Unit(getmembersAll[i].Unit):HealthPercent() < 95 
				then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)
                end
            end
        end
		
        --Kings Rest
        if inCombat and select(8, GetInstanceInfo()) == 1762 then
            for i = 1, #getmembersAll do
                if Unit(getmembersAll[i].Unit):HasDeBuffs(267626, true) ~= 0 -- Dessication
                        or Unit(getmembersAll[i].Unit):HasDeBuffs(267618, true) ~= 0 -- Drain Fluids
                        or Unit(getmembersAll[i].Unit):HasDeBuffs(266231, true) ~= 0 -- Severing axe from axe lady in council
                        or Unit(getmembersAll[i].Unit):HasDeBuffs(272388, true) ~= 0 -- shadow barrage
                        or Unit(getmembersAll[i].Unit):HasDeBuffs(265773, true) > 1 -- spit-gold
                        or (Unit(getmembersAll[i].Unit):HasDeBuffs(270487, true) ~= 0 and Unit(getmembersAll[i].Unit):HasDeBuffsStacks(270487, true) > 1) -- severing-blade
                        and Unit(getmembersAll[i].Unit):HealthPercent() < 95 
				then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)
                end
            end
        end
        
		-- Grievous Wounds
		-- Only check on minimum Mythic +7
        if Action.InstanceInfo.KeyStone >= 7 and GrievousWoundsLogic then
            for i = 1, #getmembersAll do
                if Unit(getmembersAll[i].Unit):HealthPercent() < 100 and Unit(getmembersAll[i].Unit):GetRange() <= 40 or UnitIsUnit(getmembersAll[i].Unit, "player") then
					local CurrentBleedstack = Unit(getmembersAll[i].Unit):HasDeBuffsStacks(A.GrievousWound.ID, true)
                    if CurrentBleedstack >= GrievousWoundsMinStacks then
                        HealingEngine.SetTarget(getmembersAll[i].Unit) -- default 2sec delay to stay on target
                    end
					
                end
            end
        end			
		
    end     
end


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
        if Unit("player"):Role(ROLE) then  
            lastDMG = Unit("player"):GetLastTimeDMGX(x)
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
            lastDMG = lastDMG + Unit("player"):GetLastTimeDMGX(x)  
            members = members + 1
        end 
    end      
    
    if lastDMG == 0 and members == 0 then 
        return 0, lastDMG, members
    else 
        return lastDMG / members, lastDMG, members
    end 
end


local DispelSpell = {
    -- DeBuffs Poison and Disease
    ["Slow"] = {
        3408, -- Crippling Poison
        58180, -- Infected Wounds
        197091, -- Neurotoxin
        -- 55095б -- Frost DK dot (no reason spend gcd for that)
    },
}

local function Dispel(unit)    
    return 
    (
        -- SELF 
        (
            UnitIsUnit(unit, player) and 
            (
                (          
                    A.PurifySpirit:IsReady(unit) and 
                    A.LastPlayerCastID ~= A.PurifySpirit.ID
                )
            ) and 
            Unit(unit):HasDeBuffs(DispelSpell["Slow"], true) > 2 and 
            Unit(unit):GetCurrentSpeed() > 0 and
            Unit(unit):GetCurrentSpeed() < 100 
        ) or 
        -- PvE: ANOTHER UNIT   
        (
            -- Useable conditions
            not A.IsInPvP and
            Unit(unit):IsExists() and
            --not UnitIsUnit(unit, player) and 
            Unit(unit):HasDeBuffs(A.Cyclone.ID, true) == 0 and -- Cyclone
            Env.PvEDispel(unit)             
        ) or
        -- PvP: ANOTHER UNIT   
        (
            -- Useable conditions
            A.IsInPvP and
            Unit(unit):IsExists() and
            --not UnitIsUnit(unit, player) and 
            Unit(unit):HasDeBuffs(A.Cyclone.ID, true) == 0 and -- Cyclone
            (
                (
                    A.PurifySpirit:IsReady(unit) and 
                    A.LastPlayerCastID ~= A.PurifySpirit.ID and
                    A.PurifySpirit:IsInRange(unit)
                )
            ) and 
            -- Dispel types 
            (
                -- Poison CC 
                Unit(unit):HasDeBuffs("Curse") > 2 or
                (
                    (
                        Unit(unit):HasDeBuffs("Magic") > 2 or 
                        -- Magic Rooted (if not available Tremor)
                        (                            
                            (
                                not A.TremorTotem:IsReady(player) -- Tremor
                            ) and 
                            select(2, UnitClass(unit)) ~= "DRUID" and
                            Unit(unit):HasDeBuffs("MagicRooted") > 3 and 
                            Unit(unit):IsMelee() and
                            Unit(unit):GetRealTimeDMG() <= Unit(unit):HealthMax() * 0.1 
                        )
                    )
                )
            )
        )
    ) and
    -- Check another CC types     
    Unit(unit):HasDeBuffs("Physical") <= GetCurrentGCD() and 
    -- Hex
    Unit(unit):HasDeBuffs(51514, true) <= GetCurrentGCD()
end

-- Return total active Beacon of Light Buff for player only
local function ActiveEarthShield()
    return HealingEngine.GetBuffsCount(A.EarthShield.ID, 0, player, true)
end

-- Return total active Beacon of Light Buff for tank only
local function ActiveEarthShieldOnTank()
    local CurrentTanks = HealingEngine.GetMembersByMode("TANK")
	local total = 0
	-- Iterate through current tanks
	for i = 1, #CurrentTanks do 
	    if Unit(CurrentTanks[i].Unit):HasBuffs(A.EarthShield.ID, player, true) > 0 then
            total = total + 1
        end
	end
    return total
end

local StopCast = false 

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    
	local inCombat = Unit(player):CombatTime() > 0
    local isMoving = Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local combatTime = Unit(player):CombatTime()    
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    -- Healing Engine vars
    local ReceivedLast5sec = FriendlyTeam("ALL"):GetLastTimeDMGX(5) --Unit(player):GetLastTimeDMGX(5) -- LastIncDMG(player, 5)
    local AVG_DMG = HealingEngine.GetIncomingDMGAVG()
    local AVG_HPS = HealingEngine.GetIncomingHPSAVG()
    local TeamCacheEnemySize = TeamCache.Enemy.Size
    local TeamCacheFriendlySize = TeamCache.Friendly.Size
    local TeamCacheFriendlyType = TeamCache.Friendly.Type or "none" 
    RotationsVariables()    

    --------------------
    --- DPS ROTATION ---
    --------------------	
    local function DamageRotation(unit)
        
        -- Purge
        if A.ArcaneTorrent:IsRacialReady(unit) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- Interrupts
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end         
                
        -- PvP CrownControl (Enemy Healer)
        if A.IsInPvP then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(40)
            
            if EnemyHealerUnitID ~= "none" and A.Hex:IsReady(EnemyHealerUnitID, true, nil, nil) and A.Hex:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("incapacitate", 0) and Unit(EnemyHealerUnitID):InCC() <= GetCurrentGCD() then
                return A.Hex:Show(icon)     
            end 
        end 
        
        -- Bursting 
        if BurstIsON(unit) and A.AbsentImun(nil, unit, Temp.TotalAndPhys) then 
            
            if Unit(unit):HealthPercent() <= GetToggle(2, "RacialBurstDamaging") then 
                if A.BloodFury:AutoRacial(unit) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit) then 
                    return A.Berserking:Show(icon)
                end 
            end 
        end
        
        -- Trinkets 
        if inMelee and A.AbsentImun(nil, unit, Temp.TotalAndPhys) and Unit(unit):HealthPercent() <= GetToggle(2, "TrinketBurstDamaging") then 
            if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end     
        end     
        
        -- Damage Rotation 
		
		-- LavaBurst
        if A.LavaBurst:IsReady(unit) and 
		A.LavaBurst:AbsentImun(unit, Temp.TotalAndMag) and 
		Unit(unit):HasDeBuffs(A.FlameShock.ID, true) > 0 and 
		(
		    Unit("player"):HasBuffs(A.LavaSurge.ID, true) > 0 
			or
			A.EchooftheElements:IsSpellLearned() and A.LavaBurst:GetSpellCharges() > 1
		)
		then 
            return A.LavaBurst:Show(icon)
        end 
        
		-- FlameShock
        if A.FlameShock:IsReady(unit) and A.FlameShock:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):HasDeBuffs(A.FlameShock.ID, true) < 3 then 
            return A.FlameShock:Show(icon)
        end 

		-- ChainLightning
        if A.ChainLightning:IsReady(unit) and A.GetToggle(2, "AoE") and A.ChainLightning:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):HasDeBuffs(A.FlameShock.ID, true) > 0 and MultiUnits:GetByRange(30) > 2 then 
            return A.ChainLightning:Show(icon)
        end 

		-- LightningBolt
        if A.LightningBolt:IsReady(unit) and A.LightningBolt:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):HasDeBuffs(A.FlameShock.ID, true) > 0 then 
            return A.LightningBolt:Show(icon)
        end 
        
        -- Azerite Essence 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if     (isMulti or GetToggle(2, "AoE")) and A.RippleinSpace:AutoHeartOfAzeroth(unit) and A.RippleinSpace:AbsentImun(unit, Temp.TotalAndMag) and MultiUnits:GetByRange(25, 3) >= 3 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)    
        ) 
        then 
            return A.RippleinSpace:Show(icon)
        end 
		
		-- To COntinue ? 
                    
    end 
	
    ---------------------
    --- HEAL ROTATION ---
    ---------------------  
    local function HealingRotation(unit)
 
        -- RESS ALL PEOPLE
        if A.AncestralVision:IsReady(player) and
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
		    return A.AncestralVision:Show(icon)
        end

        -- RESS Single
        if A.AncestralSpirit:IsReady(unit) and
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
                A.AncestralSpirit:IsSpellInRange("mouseover")
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
                A.AncestralSpirit:IsSpellInRange("target")
            )
        )
		then
		    return A.AncestralSpirit:Show(icon)
        end
 
        -- Purge
        if A.ArcaneTorrent:IsRacialReady(unit) and inCombat then 
            return A.ArcaneTorrent:Show(icon)
        end      
        
        -- Interrupts (@targettarget)
        if unit == "target" and IsUnitEnemy("targettarget")  and inCombat then 
            local Interrupt = Interrupts("targettarget")
            if Interrupt then 
                return Interrupt:Show(icon)
            end 
        end    
        
        -- Special Mythic + logic - Critical Healing required
		-- Return specific units to target depending on current dungeon logic triggers
		-- Also contain specific Affixes logic
        if UrgentMythicPlusTargetting() and inCombat and A.IsInInstance and not A.IsInPvP then
		    return true
		end    

        -- Priority Earth Shield on tanks
		local CurrentTanks = A.HealingEngine.GetMembersByMode("TANK")
        if A.EarthShield:IsReady() and EarthShieldWorkMode == "Tanking Units" and ActiveEarthShieldOnTank == 0 then
            for i = 1, #CurrentTanks do 
                if Unit(CurrentTanks[i].Unit):GetRange() <= 40 then 
                      if Unit(CurrentTanks[i].Unit):IsPlayer() and Unit(CurrentTanks[i].Unit):HasBuffs(A.EarthShield.ID, true) < 2 then    
                        -- Notification                    
                        Action.SendNotification("Placing " .. A.GetSpellInfo(A.EarthShield.ID) .. " on " .. UnitName(CurrentTanks[i].Unit), A.EarthShield.ID)
                        HealingEngine.SetTarget(CurrentTanks[i].Unit)    -- Add 1sec delay in case of emergency switch                         
                        return A.EarthShield:Show(icon)                        
                    end                    
                end                
            end    
        end

        -- #1 RPvE Dispel
        if A.PurifySpirit:IsReady(unit) and 
        (
            -- MouseOver
            (
                MouseOver and        
                A.MouseHasFrame() and                      
                not IsUnitEnemy(mouseover) and                 
                Unit(mouseover):IsPlayer() and  
                Unit(mouseover):TimeToDie() >= 6 and
                Dispel(mouseover)
            ) or 
            -- Target
            (
                (
                    not MouseOver or 
                    not Unit(mouseover):IsExists() 
                ) and       
                not IsUnitEnemy(target) and
                Unit(target):IsPlayer() and  
                Unit(target):TimeToDie() >= 6 and
                Dispel(target)
            )
        )
        then
            return A.PurifySpirit:Show(icon)
        end
		
        -- #5 Bursting Essences		        
        -- #5.1 Life Binders Invocation
        if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and HealingEngine.GetBelowHealthPercentercentUnits(LifeBindersInvocationHP, 40) >= LifeBindersInvocationUnits then
            -- Notification                    
            Action.SendNotification("Burst " .. A.GetSpellInfo(A.LifeBindersInvocation.ID), A.LifeBindersInvocation.ID)            
            return A.LifeBindersInvocation:Show(icon)
        end
            
        -- #5.2 Overcharge Mana
        if A.OverchargeMana:AutoHeartOfAzeroth(unit, true) then
            return A.OverchargeMana:Show(icon)
        end
                
        -- #5.3 MemoryofLucidDreams if less than 85% mana left
        if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Player:Mana() < Player:ManaMax() * (LucidDreamManaPercent / 100) then
            return A.MemoryofLucidDreams:Show(icon)
        end

        -- #5.4 Concentrated Flame Heal
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) then
            return A.ConcentratedFlame:Show(icon)
        end
        
        -- #5.5 Vitality Conduit
        if (isMulti or AoEON) then 
            if A.VitalityConduit:AutoHeartOfAzeroth(unit, true) then 
                return A.VitalityConduit:Show(icon)
            end
            -- OverchargeMana    
            if A.OverchargeMana:AutoHeartOfAzeroth(unit, true) and (not IsEnoughHPS(unit) or HealingEngine.GetIncomingDMGAVG() > HealingEngine.GetIncomingHPSAVG() + 10) then 
                return A.OverchargeMana:Show(icon)
            end 
        end 		
		
        -- #9 Burst Cooldowns
        -- #9.1 Ascendance
        if A.Ascendance:IsReady(player) and A.Ascendance:IsSpellLearned() and A.BurstIsON(unit) and
        (       
            -- HealingEngine conditions for burst raid/party heal
            (
                AoEON and
                (
                    (
                        not MouseOver or
                        not A.MouseHasFrame() or
                        not IsUnitEnemy(mouseover)
                    ) and
                    not IsUnitEnemy(target) 
                ) and
                (            
                    (
                        TeamCacheFriendlySize > 1 and 
                        (
                            AVG_DMG and
                            ReceivedLast5sec and 
                            AVG_HPS and
                            (
                                ReceivedLast5sec > AVG_DMG + AVG_HPS or
                                AVG_DMG >= AVG_HPS * 3
                            ) 
                        ) and
                        (
                            HealingEngine.GetTimeToDieUnits(15) >= GetValidMembers(true) * 0.5 or
                            HealingEngine.GetBelowHealthPercentercentUnits(60) >= GetValidMembers(true) * 0.5
                        )
                    ) or        
                    (
                        TeamCacheFriendlyType == "party" and
                        HealingEngine.GetBelowHealthPercentercentUnits(40) >= 3  
                    ) or 
                    (
                        TeamCacheFriendlyType == "raid" and
                        HealingEngine.GetBelowHealthPercentercentUnits(55) >= 5               
                    )
                )
            ) or
            -- MouseOver
            (
                MouseOver and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and               
                not IsUnitEnemy(mouseover) and                 
                Unit(mouseover):IsPlayer() and
                Unit(mouseover):GetRange() <= 40 and
                --Unit(mouseover):HasDeBuffs(A.Cyclone.ID, true) and
                Unit(mouseover):HasDeBuffs(A.Cyclone.ID, true) <= GetCurrentGCD() + GetGCD() and
                Unit(mouseover):Health() <= Unit(mouseover):HealthMax() * 0.7 and
                Unit(mouseover):GetRealTimeDMG() > 0 and
                (                          
                    Unit(mouseover):GetDMG() > Unit(mouseover):HealthMax()*0.2 or
                    Unit(mouseover):GetDMG() > Unit(mouseover):GetHEAL() * 1.2 or
                    Unit(mouseover):Health() <= Unit(mouseover):HealthMax()*0.25
                ) and
                Unit(mouseover):TimeToDie() > 3
            ) or 
            -- Target
            (
                (
                    not MouseOver or 
                    not Unit(mouseover):IsExists() 
                ) and       
                not IsUnitEnemy(target) and
                Unit(target):IsPlayer() and
                Unit(target):GetRange() <= 40 and 
                --Unit(mouseover):HasDeBuffs(A.Cyclone.ID, true) and
                Unit(target):HasDeBuffs(A.Cyclone.ID, true) <= GetCurrentGCD() + GetGCD() and
                Unit(target):Health() <= Unit(target):HealthMax() * 0.7 and
                Unit(target):GetRealTimeDMG() > 0 and
                (                        
                    Unit(target):GetDMG() > Unit(target):HealthMax() * 0.2 or
                    Unit(target):GetDMG() > Unit(target):GetHEAL() * 1.2 or            
                    Unit(target):Health() <= Unit(target):HealthMax() * 0.25
                ) and        
                Unit(target):TimeToDie() > 3
            ) 
        )        
        then
            -- Notification                    
            Action.SendNotification("Burst " .. A.GetSpellInfo(A.Ascendance.ID), A.Ascendance.ID)
            return A.Ascendance:Show(icon)
        end		

        -- #9.3 HealingTideTotem            
        if A.HealingTideTotem:IsReady(player) and A.BurstIsON(unit) and combatTime > 5 and 
        (
               HealingEngine.GetTimeToDieUnits(10) >= GetValidMembers(true) * 0.4 
            or
               ReceivedLast5sec > AVG_DMG * 5 
            or
            HealingEngine.GetBelowHealthPercentercentUnits(35) >= GetValidMembers(true) * 0.35 -- 
            or
            HealingEngine.GetBelowHealthPercentercentUnits(35) >= 5 -- 
        )             
        then
            -- Notification                    
            Action.SendNotification("Burst " .. A.GetSpellInfo(A.HealingTideTotem.ID), A.HealingTideTotem.ID)                
            return A.HealingTideTotem:Show(icon)
        end
		
        -- RPvE #1 Riptide (HPS)
        if A.Riptide:IsReadyByPassCastGCD(unit) and
        (
            -- MouseOver
            (
                MouseOver and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and                        
                not IsUnitEnemy(mouseover) and                 
                A.Riptide:IsInRange(mouseover) and
                Unit(mouseover):HasDeBuffs(A.Cyclone.ID, true) == 0 and -- Cyclone
                A.Riptide:PredictHeal("Riptide", mouseover) and
                (
                    (
                        Action.InstanceInfo.KeyStone > 0 and
                        Action.InstanceInfo.GroupSize <= 5
                    ) 
					or 
                    Unit(mouseover):TimeToDie() <= GetGCD() * 2.5 or
                    (
                        (
                            -- Ascendance
                            Unit(player):HasBuffs(A.Ascendance.ID, true) < GetCurrentGCD() + GetGCD() or
                            -- CloudburstTotem snipe 
                            (
                                Unit(player):HasBuffs(A.CloudburstTotem.ID, true) > 0 and
                                Unit(player):HasBuffs(A.CloudburstTotem.ID, true) < GetCurrentGCD() + GetGCD()
                            )
                        ) and 
                        (                                   
                            -- Tidal Wave Buff                          
                            Unit(player):HasBuffs(A.TidalWaveBuff.ID, true) <= Unit(player):CastTime(A.ChainHeal.ID) + GetCurrentGCD() + 0.3 or                    
                            Unit(player):GetCurrentSpeed() ~= 0 
                        )
                    )
                )        
            ) 
			or 
            -- Target
            (
                (
                    not MouseOver or 
                    not Unit(mouseover):IsExists() 
                ) and        
                not IsUnitEnemy(target) and
                A.Riptide:IsInRange(target) and
                Unit(target):HasDeBuffs(A.Cyclone.ID, true) == 0 and -- Cyclone
                A.Riptide:PredictHeal("Riptide", target) and
                (
                    (
                        Action.InstanceInfo.KeyStone > 0 and
                        Action.InstanceInfo.GroupSize <= 5
                    ) 
					or 
                    Unit(target):TimeToDie() <= GetGCD() * 2.5 or
                    (
                        (
                            -- Ascendance
                            Unit(player):HasBuffs(A.Ascendance.ID, true) < GetCurrentGCD() + GetGCD() or
                            -- CloudburstTotem snipe 
                            (
                                Unit(player):HasBuffs(A.CloudburstTotem.ID, true) > 0 and
                                Unit(player):HasBuffs(A.CloudburstTotem.ID, true) < GetCurrentGCD() + GetGCD()
                            )
                        ) and 
                        (                                   
                            -- Tidal Wave Buff                          
                            Unit(player):HasBuffs(A.TidalWaveBuff.ID, true) <= Unit(player):CastTime(A.ChainHeal.ID) + GetCurrentGCD() + 0.3 or                    
                            Unit(player):GetCurrentSpeed() ~= 0 
                        )
                    )
                )           
            ) 
        ) and
        A.LastPlayerCastID ~= A.Riptide.ID      
        then
            return A.Riptide:Show(icon)
        end
		
		-- RPvE #1 Healing Stream Totem Maintain
        --if we have 3+ melee units which can be healed or while run 
        if A.HealingStreamTotem:IsReady(player) and
        A.GetToggle(2, "AoE") and
		HealingStreamTotemDuration() <= HealingStreamTotemRefresh and
		-- Mana Check
		(
		    not IsSaveManaPhase() or
            Unit(player):HasBuffs(29166, player, true) > GetCurrentGCD() + 0.2 
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
                Unit(mouseover):CanInterract(40) and
                (
                    Unit(player):GetCurrentSpeed() > 0 or
                    not Unit(mouseover):PT(A.Riptide.ID, nil, true) -- Regrowth   
                ) and
                A.HealingStreamTotem:PredictHeal("HealingStreamTotem", "mouseover")        
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
                    Unit(player):GetCurrentSpeed() > 0  
               ) and
                A.HealingStreamTotem:PredictHeal("HealingStreamTotem", "target") 
            ) or
            HealingEngine.HealingByRange(40, "Riptide", A.Riptide, true) >= 3
        ) and
        A.LastPlayerCastID ~= A.HealingStreamTotem.ID
        then 
            return A.HealingStreamTotem:Show(icon)
        end	

        -- RPvE #1 Cloudburst Totem Recall
		if A.CloudburstTotem:IsReady(player) and
		CloudburstTotemDuration() > GetGCD() + GetCurrentGCD() and
		CloudburstTotemDuration() < 10 and
		combatTime > 3 and
		(        
            (
                TeamCache.Friendly.Size <= 2 and
                HealingEngine.GetBelowHealthPercentercentUnits(75) >= 2
            ) or
            (
                TeamCache.Friendly.Size <= 5 and
                HealingEngine.GetBelowHealthPercentercentUnits(75) >= 3
            ) or
            (
                TeamCache.Friendly.Size > 5 and      
                HealingEngine.GetBelowHealthPercentercentUnits(80) >= AoEMembers(true, _, 5)
            ) or     
            HealingEngine.GetHealthFrequency(GetGCD()*3) > 25
			or
			HealingEngine.GetHealthAVG() < 85
        )
        then 
            return A.CloudburstTotem:Show(icon)
        end 		

        -- RPvE #2 Cloudburst Totem Call
		if A.CloudburstTotem:IsReady(player) and
		CloudburstTotemDuration() == 0 and
		combatTime > 3  and
		(
		    HealingEngine.GetHealthAVG() < 95 or
		    HealingEngine.GetHealthFrequency(GetGCD()*3) > 10 
		)		
        then 
            return A.CloudburstTotem:Show(icon)
        end 		
		
        -- RPvE #1 UnleashLife
        if A.UnleashLife:IsReady(unit) and
        -- Unleash Life buff
        Unit(player):HasBuffs(73685, player, true) == 0 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and
                not Unit(mouseover):IsDead() and                
                not IsUnitEnemy(mouseover) and                 
                A.UnleashLife:IsSpellInRange(mouseover) and
                A.UnleashLife:PredictHeal("UnleashLife", "mouseover") and
                (
                    Unit(mouseover):Health() <= Unit(mouseover):HealthMax()*0.95
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
                A.UnleashLife:IsSpellInRange(target) and
                A.UnleashLife:PredictHeal("UnleashLife", "target") and
                (
                    Unit(target):Health() <= Unit(target):HealthMax()*0.95
                )
            )
        )
        then 
            return A.UnleashLife:Show(icon)
        end 

		
        -- RPvE #1 HealingRain 
        if A.HealingRain:IsReady(player) and
        A.GetToggle(2, "AoE") and
		HealingRainDuration() <= HealingRainRefresh and
		-- Mana Check
		(
		    not IsSaveManaPhase() or
            Unit(player):HasBuffs(29166, player, true) > GetCurrentGCD() + 0.2 
		) and
		(        
            (
                TeamCache.Friendly.Size <= 2 and
                HealingEngine.GetBelowHealthPercentercentUnits(95) >= 2
            ) or
            (
                TeamCache.Friendly.Size <= 5 and
                HealingEngine.GetBelowHealthPercentercentUnits(95) >= 3
            ) or
            (
                TeamCache.Friendly.Size > 5 and      
                HealingEngine.GetBelowHealthPercentercentUnits(90) >= AoEMembers(true, _, 5)
            ) or     
            HealingEngine.GetHealthFrequency(GetGCD()*4) > 10
        )
        then 
            return A.HealingRain:Show(icon)
        end 	
		
        -- RPvE #1 Earthen Wall Totem 
        if A.EarthenWallTotem:IsReady(player) and
		(        
            (
                TeamCache.Friendly.Size <= 2 and
                HealingEngine.GetBelowHealthPercentercentUnits(95) >= 2
            ) or
            (
                TeamCache.Friendly.Size <= 5 and
                HealingEngine.GetBelowHealthPercentercentUnits(95) >= 3
            ) or
            (
                TeamCache.Friendly.Size > 5 and      
                HealingEngine.GetBelowHealthPercentercentUnits(90) >= AoEMembers(true, _, 5)
            ) or     
            HealingEngine.GetHealthFrequency(GetGCD()*4) > 10
        )
        then 
            return A.EarthenWallTotem:Show(icon)
        end 
		
        -- RPvE #1 Chain Heal
        if A.ChainHeal:IsReady(unit) and
        A.GetToggle(2, "AoE") and
		TeamCache.Friendly.Size > 2 and
		-- UnleashLife
		(
		    A.UnleashLife:IsSpellLearned() and 
			(    
			    Unit(player):HasBuffs(A.UnleashLife.ID, true) > 0 or
			    A.UnleashLife:GetCooldown() > 10 
			) or
			not A.UnleashLife:IsSpellLearned()
		) and		
		(        
            (
                TeamCache.Friendly.Size <= 5 and
                HealingEngine.GetBelowHealthPercentercentUnits(70) >= 4 and
				Unit(player):HasBuffs(A.TidalWaveBuff.ID, true) == 0
            ) or
            (
                TeamCache.Friendly.Size > 5 and      
                HealingEngine.GetBelowHealthPercentercentUnits(90) >= AoEMembers(true, _, 4)
            ) or     
            HealingEngine.GetHealthFrequency(GetGCD()*4) > 15
        )
        then 
            return A.ChainHeal:Show(icon)
        end 
		
		-- RPvE #1 Wellspring
        if A.Wellspring:IsReady(unit) and
        A.GetToggle(2, "AoE") and
		TeamCache.Friendly.Size > 2 and		
		(        
            (
                TeamCache.Friendly.Size <= 5 and
                HealingEngine.GetBelowHealthPercentercentUnits(70) >= 4
            ) or
            (
                TeamCache.Friendly.Size > 5 and      
                HealingEngine.GetBelowHealthPercentercentUnits(90) >= AoEMembers(true, _, 4)
            ) or     
            HealingEngine.GetHealthFrequency(GetGCD()*4) > 20
        )
        then 
            return A.Wellspring:Show(icon)
        end 
		
        -- HPvE #1 HealingSurge Critical
		local TidalWave = Unit(player):HasBuffs(A.TidalWaveBuff.ID, true)
		local HScast_t = Unit(player):CastTime(A.HealingSurge.ID)
        if A.HealingSurge:IsReady(unit) and 
        -- Infusion of Light
        TidalWave > 0 and
        TidalWave > HScast_t + GetCurrentGCD() + 0.1 and
        Unit(player):GetCurrentSpeed() == 0 and 
        (
            -- MouseOver
            (
                MouseOver and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and                        
                not IsUnitEnemy(mouseover) and                 
                A.HealingSurge:IsInRange(mouseover) and
                Unit(mouseover):HasDeBuffs(A.Cyclone.ID, true) < HScast_t + GetCurrentGCD() and
                A.HealingSurge:PredictHeal("HealingSurge", mouseover) and
                Unit(mouseover):TimeToDie() > HScast_t + GetCurrentGCD() + 2 and
                (
                    Unit(mouseover):IsTank() or
                    HealingEngine.IsMostlyIncDMG(mouseover) or
                    Unit(mouseover):Health() < Unit(mouseover):HealthMax() * 0.8 --or
                    --Unit(mouseover):HealthPercent() < FlashofLightHP or
                    --Unit(mouseover):TimeToDieX(3) < FlashofLightTTD    
                )
            ) or 
            -- Target
            (
                (
                    not MouseOver or 
                    not Unit(mouseover):IsExists() 
                ) and        
                not IsUnitEnemy(target) and
                A.HealingSurge:IsInRange(target) and
                Unit(target):HasDeBuffs(A.Cyclone.ID, true) < HScast_t + GetCurrentGCD() and
                A.HealingSurge:PredictHeal("HealingSurge", target) and
                Unit(target):TimeToDie() > HScast_t + GetCurrentGCD() + 2 and
                (
                    Unit(target):IsTank() or
                    HealingEngine.IsMostlyIncDMG(target) or
                    Unit(target):Health() < Unit(target):HealthMax() * 0.8 --or
                    --Unit(target):HealthPercent() < FlashofLightHP or
                    --Unit(target):TimeToDieX(5) < FlashofLightTTD                
                )
            ) or
            -- Save us
            (
                Unit(player):HealthPercent() < 60 or
                Unit(player):TimeToDieX(5) < 2    
            )            
        )
        then
            return A.HealingSurge:Show(icon)
        end
		 
        -- HPvE #1 HealingWave - Low to Moderate
		local HWcast_t = Unit(player):CastTime(A.HealingWave.ID)
        if A.HealingWave:IsReady(unit) and TidalWave > 0 and TidalWave > HWcast_t + GetCurrentGCD() + 0.1 and Unit(player):GetCurrentSpeed() == 0 and 
        (
            -- MouseOver
            (
                MouseOver and
                Unit(mouseover):IsExists() and 
                A.MouseHasFrame() and                        
                not IsUnitEnemy(mouseover) and                 
                A.HealingWave:IsInRange(mouseover) and
                Unit(mouseover):HasDeBuffs(A.Cyclone.ID, true) < HWcast_t + GetCurrentGCD() and
                A.HealingWave:PredictHeal("HealingWave", mouseover) and
                Unit(mouseover):TimeToDie() > HWcast_t + GetCurrentGCD() + 1
            ) or 
            -- Target
            (
                (
                    not MouseOver or 
                    not Unit(mouseover):IsExists() or 
                    IsUnitEnemy(mouseover)
                ) and        
                not IsUnitEnemy(target) and
                A.HealingWave:IsInRange(target) and
                Unit(target):HasDeBuffs(A.Cyclone.ID, true) < HWcast_t + GetCurrentGCD() and
                A.HealingWave:PredictHeal("HealingWave", target) and
                Unit(target):TimeToDie() > HWcast_t + GetCurrentGCD() + 1
            )
            or
            -- Save us
            (
                Unit(player):HealthPercent() < 91 or
                Unit(player):TimeToDieX(15) < 5    
            )    
        )
        then
            return A.HealingWave:Show(icon)
        end	
	   
	   
    end 
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Mouseover 
    if IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    if IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if HealingRotation(unit) then 
            return true 
        end             
    end 
    
    -- Target / TargetTarget     
    if IsUnitEnemy("target") then 
        unit = "target"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    if IsUnitFriendly("target") then 
        unit = "target"
        
        if HealingRotation(unit) then 
            return true 
        end 
    end 
      
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

-- [5] Trinket Rotation
-- No specialization trinket actions 
A[5] = nil 

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (Action.Zone == "pvp" or Action.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then 
            -- Hex BreakAble CC
            if A.Hex:IsReady(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.Hex
            end 
        end
    end 
end 

local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

    -- BlessingofFreedom
    if A.TremorTotem:IsReady(player) and Unit(unit):HasDeBuffs("Fear") > 0 then
        return A.TremorTotem
    end
    
    -- Purify Spirit
    if A.PurifySpirit:IsReady(unit) and      
    (
        Unit(unit):IsPlayer() and  
        Unit(unit):TimeToDie() >= 6 and
        Dispel(unit)     
    )
    then
        return A.PurifySpirit
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
  
    --if RotationPassive(icon) then 
    --    return true 
    --end 
    
    local Arena = ArenaRotation("arena1")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[7] = function(icon)
    --if RotationPassive(icon) then 
    --    return true 
    --end 
    
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
    --if RotationPassive(icon) then 
    --    return true 
    --end 
    
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    local Arena = ArenaRotation("arena3")
    if Arena then 
        return Arena:Show(icon)
    end 
end