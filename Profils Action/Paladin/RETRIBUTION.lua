--- ====================== ACTION HEADER ============================ ---
local Action                                 = Action
local TeamCache                              = Action.TeamCache
local EnemyTeam                              = Action.EnemyTeam
local FriendlyTeam                           = Action.FriendlyTeam
--local HealingEngine                        = Action.HealingEngine
local LoC                                    = Action.LossOfControl
local Player                                 = Action.Player
local MultiUnits                             = Action.MultiUnits
local UnitCooldown                           = Action.UnitCooldown
local Unit                                   = Action.Unit
local Pet                                    = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local setmetatable                           = setmetatable
local TR                                     = Action.TasteRotation
--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_PALADIN_RETRIBUTION] = {
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
    -- Generic Spells
    WakeofAshes                          = Action.Create({ Type = "Spell", ID = 255937     }),
    LightsJudgment                       = Action.Create({ Type = "Spell", ID = 255647     }),
    ShieldofVengeance                    = Action.Create({ Type = "Spell", ID = 184662     }),
    AvengingWrath                        = Action.Create({ Type = "Spell", ID = 31884     }),
    Inquisition                          = Action.Create({ Type = "Spell", ID = 84963     }),
    Crusade                              = Action.Create({ Type = "Spell", ID = 231895     }),
    RighteousVerdict                     = Action.Create({ Type = "Spell", ID = 267610     }),
    ExecutionSentence                    = Action.Create({ Type = "Spell", ID = 267798     }),
    DivineStorm                          = Action.Create({ Type = "Spell", ID = 53385     }),
    DivinePurpose                        = Action.Create({ Type = "Spell", ID = 223817     }),
    TemplarsVerdict                      = Action.Create({ Type = "Spell", ID = 85256     }),
    HammerofWrath                        = Action.Create({ Type = "Spell", ID = 24275     }),
    BladeofJustice                       = Action.Create({ Type = "Spell", ID = 184575     }),
    Judgment                             = Action.Create({ Type = "Spell", ID = 20271     }),
    Consecration                         = Action.Create({ Type = "Spell", ID = 205228     }),
    CrusaderStrike                       = Action.Create({ Type = "Spell", ID = 35395     }),
    Rebuke                               = Action.Create({ Type = "Spell", ID = 96231     }),
    HammerofJustice                      = Action.Create({ Type = "Spell", ID = 198054     }),
    Repentance                           = Action.Create({ Type = "Spell", ID = 20066     }), 
    Cavalier                             = Action.Create({ Type = "Spell", ID = 190784     }),
    BlessingofProtectionYellow           = Action.Create({ Type = "Spell", ID = 1022, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    BlessingofProtection                 = Action.Create({ Type = "Spell", ID = 1022     }), 
    WordofGlory                          = Action.Create({ Type = "Spell", ID = 210191     }),
    BlessingofFreedom                    = Action.Create({ Type = "Spell", ID = 1044     }),
    BlessingofFreedomYellow              = Action.Create({ Type = "Spell", ID = 1044, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    -- PvP
    HammerofReckoning                    = Action.Create({ Type = "Spell", ID = 247675     }),
    BlessingofSanctuary                  = Action.Create({ Type = "Spell", ID = 210256     }),
    BlessingofSanctuaryYellow              = Action.Create({ Type = "Spell", ID = 210256, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    -- Buffs
    DivinePurposeBuff                    = Action.Create({ Type = "Spell", ID = 223819, Hidden = true     }),
    EmpyreanPowerBuff                    = Action.Create({ Type = "Spell", ID = 286393, Hidden = true     }),
    AvengingWrathBuff                    = Action.Create({ Type = "Spell", ID = 31884, Hidden = true     }),
    AvengingWrathCritBuff                = Action.Create({ Type = "Spell", ID = 294027, Hidden = true     }),
    InquisitionBuff                      = Action.Create({ Type = "Spell", ID = 84963, Hidden = true     }),  
    CrusadeBuff                          = Action.Create({ Type = "Spell", ID = 231895, Hidden = true     }), 
    SeethingRageBuff                     = Action.Create({ Type = "Spell", ID = 297126, Hidden = true     }), 
    RecklessForceBuff                    = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),  
    -- Debuffs
    JudgmentDebuff                       = Action.Create({ Type = "Spell", ID = 197277, Hidden = true     }),
    ConcentratedFlameBurn                = Action.Create({ Type = "Spell", ID = 295368, Hidden = true     }),
    RazorCoralDebuff                     = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
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
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PALADIN_RETRIBUTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_RETRIBUTION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarWingsPool = 0;
local VarDsCastable = 0;
local VarHow = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarWingsPool = 0
  VarDsCastable = 0
  VarHow = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
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
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

-- [1] CC AntiFake Rotation
--[[local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.LegSweepGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.LegSweepGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))) or 
                (not A.IsInPvP and MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1)
            )
        )
    )
    then 
        return A.LegSweepGreen:Show(icon)         
    end                                                                     
end]]--

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.Rebuke:IsReady(unit, nil, nil, true) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.Rebuke:Show(icon)                                                  
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

local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
	
    -- DivineShield
    local DivineShield = A.GetToggle(2, "DivineShieldHP")
    if     DivineShield >= 0 and A.DivineShield:IsReady("player") and 
    (
        (     -- Auto 
            DivineShield >= 100 and 
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
            DivineShield < 100 and 
            Unit("player"):HealthPercent() <= DivineShield
        )
    ) 
    then 
	    -- Notification					
        Action.SendNotification("[DEF] Divine Shield", A.DivineShield.ID)
        return A.DivineShield
    end
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Rebuke:IsReady(unit) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
	    -- Notification					
        Action.SendNotification("Rebuke interrupting on Target ", A.Rebuke.ID)
        return A.Rebuke
    end 
    
    if useCC and A.HammerofJustice:IsReady(unit) and A.HammerofJustice:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	    -- Notification					
        Action.SendNotification("HammerofJustice interrupting...", A.HammerofJustice.ID)
        return A.HammerofJustice              
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

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Cooldowns, Finishers, Generators
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- arcane_torrent,if=!talent.wake_of_ashes.enabled
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.WakeofAshes:IsSpellLearned()) then
                return A.ArcaneTorrent:Show(icon)
            end
			
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- potion,if=(cooldown.guardian_of_azeroth.remains>90|!essence.condensed_lifeforce.major)&(buff.bloodlust.react|buff.avenging_wrath.up&buff.avenging_wrath.remains>18|buff.crusade.up&buff.crusade.remains<25)
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and 
			(
			    (A.GuardianofAzeroth:GetCooldown() > 90 or not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) 
				and 
				(
				    Unit("player"):HasHeroism() 
					or 
					Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 18 
					or 
					Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) < 25
				)
			)
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- lights_judgment,if=spell_targets.lights_judgment>=2|(!raid_event.adds.exists|raid_event.adds.in>75)
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and MultiUnits:GetByRange(5) >= 2 then
                return A.LightsJudgment:Show(icon)
            end
			
            -- fireblood,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and 
			(
			    Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 
				or 
				Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10
			)
			then
                return A.Fireblood:Show(icon)
            end
			
            -- shield_of_vengeance,if=buff.seething_rage.down&buff.memory_of_lucid_dreams.down
            if A.ShieldofVengeance:IsReady(unit) and (Unit("player"):HasBuffsDown(A.SeethingRageBuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.ShieldofVengeance:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(buff.avenging_wrath.remains>=20|buff.crusade.stack=10&buff.crusade.remains>15)&(cooldown.guardian_of_azeroth.remains>90|target.time_to_die<30|!essence.condensed_lifeforce.major)
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) 
				or 
				(
				    Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) >= 20 
					or 
					Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10 and Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 15
				) 
				and 
				(
				    A.GuardianofAzeroth:GetCooldown() > 90 
					or 
					Unit(unit):TimeToDie() < 30 
					or 
					not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)
				)
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
            -- the_unbound_force,if=time<=2|buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):CombatTime() <= 2 or Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
                return A.TheUnboundForce:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- guardian_of_azeroth,if=!talent.crusade.enabled&(cooldown.avenging_wrath.remains<5&holy_power>=3&(buff.inquisition.up|!talent.inquisition.enabled)|cooldown.avenging_wrath.remains>=45)|(talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|holy_power>=3&time<10&talent.wake_of_ashes.enabled|cooldown.crusade.remains>=45)
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not A.Crusade:IsSpellLearned() and (A.AvengingWrath:GetCooldown() < 5 and Player:HolyPower() >= 3 and (Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) > 0 or not A.Inquisition:IsSpellLearned()) or A.AvengingWrath:GetCooldown() >= 45) or (A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 4 or Player:HolyPower() >= 3 and Unit("player"):CombatTime() < 10 and A.WakeofAshes:IsSpellLearned() or A.Crusade:GetCooldown() >= 45)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- worldvein_resonance,if=cooldown.avenging_wrath.remains<gcd&holy_power>=3|talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|cooldown.avenging_wrath.remains>=45|cooldown.crusade.remains>=45
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.AvengingWrath:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 3 or A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 4 or A.AvengingWrath:GetCooldown() >= 45 or A.Crusade:GetCooldown() >= 45) then
                return A.WorldveinResonance:Show(icon)
            end
            -- focused_azerite_beam,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)&!(buff.avenging_wrath.up|buff.crusade.up)&(cooldown.blade_of_justice.remains>gcd*3&cooldown.judgment.remains>gcd*3)
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((not (MultiUnits:GetByRange(40) > 1) or MultiUnits:GetByRange(8) >= 2) and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) == 0 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0) and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 3 and A.Judgment:GetCooldown() > A.GetGCD() * 3)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- memory_of_lucid_dreams,if=(buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10)&holy_power<=3
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) and Player:HolyPower() <= 3) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- purifying_blast,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((not (MultiUnits:GetByRange(40) > 1) or MultiUnits:GetByRange(8) >= 2)) then
                return A.PurifyingBlast:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=!(buff.avenging_wrath.up|buff.crusade.up)&(cooldown.blade_of_justice.remains>gcd*3&cooldown.judgment.remains>gcd*3)
            if A.CyclotronicBlast:IsReady(unit) and (not (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0) and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 3 and A.Judgment:GetCooldown() > A.GetGCD() * 3)) then
                return A.CyclotronicBlast:Show(icon)
            end
            -- avenging_wrath,if=(!talent.inquisition.enabled|buff.inquisition.up)&holy_power>=3
            if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and ((not A.Inquisition:IsSpellLearned() or Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) > 0) and Player:HolyPower() >= 3) then
                return A.AvengingWrath:Show(icon)
            end
            -- crusade,if=holy_power>=4|holy_power>=3&time<10&talent.wake_of_ashes.enabled
            if A.Crusade:IsReady(unit) and A.BurstIsON(unit) and (Player:HolyPower() >= 4 or Player:HolyPower() >= 3 and Unit("player"):CombatTime() < 10 and A.WakeofAshes:IsSpellLearned()) then
                return A.Crusade:Show(icon)
            end
        end
        
        --Finishers
        local function Finishers(unit)
            -- variable,name=wings_pool,value=!equipped.169314&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>gcd*3|cooldown.crusade.remains>gcd*3)|equipped.169314&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>gcd*6|cooldown.crusade.remains>gcd*6)
            if (true) then
                VarWingsPool = num((not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 or A.Crusade:GetCooldown() > A.GetGCD() * 3) or (not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > A.GetGCD() * 6 or A.Crusade:GetCooldown() > A.GetGCD() * 6))
            end
            -- variable,name=ds_castable,value=spell_targets.divine_storm>=2&!talent.righteous_verdict.enabled|spell_targets.divine_storm>=3&talent.righteous_verdict.enabled|buff.empyrean_power.up&debuff.judgment.down&buff.divine_purpose.down&buff.avenging_wrath_autocrit.down
            if (true) then
                VarDsCastable = num(MultiUnits:GetByRange(8) >= 2 and not A.RighteousVerdict:IsSpellLearned() or MultiUnits:GetByRange(8) >= 3 and A.RighteousVerdict:IsSpellLearned() or Unit("player"):HasBuffs(A.EmpyreanPowerBuff.ID, true) > 0 and Unit(unit):HasDeBuffsDown(A.JudgmentDebuff.ID, true) and Unit("player"):HasBuffsDown(A.DivinePurposeBuff.ID, true) and Unit("player"):HasBuffsDown(A.AvengingWrathAutocritBuff.ID, true))
            end
            -- inquisition,if=buff.avenging_wrath.down&(buff.inquisition.down|buff.inquisition.remains<8&holy_power>=3|talent.execution_sentence.enabled&cooldown.execution_sentence.remains<10&buff.inquisition.remains<15|cooldown.avenging_wrath.remains<15&buff.inquisition.remains<20&holy_power>=3)
            if A.Inquisition:IsReady(unit) and (Unit("player"):HasBuffsDown(A.AvengingWrathBuff.ID, true) and (Unit("player"):HasBuffsDown(A.InquisitionBuff.ID, true) or Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 8 and Player:HolyPower() >= 3 or A.ExecutionSentence:IsSpellLearned() and A.ExecutionSentence:GetCooldown() < 10 and Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 15 or A.AvengingWrath:GetCooldown() < 15 and Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 20 and Player:HolyPower() >= 3)) then
                return A.Inquisition:Show(icon)
            end
            -- execution_sentence,if=spell_targets.divine_storm<=2&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>10|talent.crusade.enabled&buff.crusade.down&cooldown.crusade.remains>10|buff.crusade.stack>=7)
            if A.ExecutionSentence:IsReady(unit) and (MultiUnits:GetByRange(8) <= 2 and (not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > 10 or A.Crusade:IsSpellLearned() and Unit("player"):HasBuffsDown(A.CrusadeBuff.ID, true) and A.Crusade:GetCooldown() > 10 or Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) >= 7)) then
                return A.ExecutionSentence:Show(icon)
            end
            -- divine_storm,if=variable.ds_castable&variable.wings_pool&((!talent.execution_sentence.enabled|(spell_targets.divine_storm>=2|cooldown.execution_sentence.remains>gcd*2))|(cooldown.avenging_wrath.remains>gcd*3&cooldown.avenging_wrath.remains<10|cooldown.crusade.remains>gcd*3&cooldown.crusade.remains<10|buff.crusade.up&buff.crusade.stack<10))
            if A.DivineStorm:IsReady(unit) and (bool(VarDsCastable) and bool(VarWingsPool) and ((not A.ExecutionSentence:IsSpellLearned() or (MultiUnits:GetByRange(8) >= 2 or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2)) or (A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 and A.AvengingWrath:GetCooldown() < 10 or A.Crusade:GetCooldown() > A.GetGCD() * 3 and A.Crusade:GetCooldown() < 10 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) < 10))) then
                return A.DivineStorm:Show(icon)
            end
            -- templars_verdict,if=variable.wings_pool&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*2|cooldown.avenging_wrath.remains>gcd*3&cooldown.avenging_wrath.remains<10|cooldown.crusade.remains>gcd*3&cooldown.crusade.remains<10|buff.crusade.up&buff.crusade.stack<10)
            if A.TemplarsVerdict:IsReady(unit) and (bool(VarWingsPool) and (not A.ExecutionSentence:IsSpellLearned() or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2 or A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 and A.AvengingWrath:GetCooldown() < 10 or A.Crusade:GetCooldown() > A.GetGCD() * 3 and A.Crusade:GetCooldown() < 10 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) < 10)) then
                return A.TemplarsVerdict:Show(icon)
            end
        end
        
        --Generators
        local function Generators(unit)
            -- variable,name=HoW,value=(!talent.hammer_of_wrath.enabled|target.health.pct>=20&!(buff.avenging_wrath.up|buff.crusade.up))
            if (true) then
                VarHow = num((not A.HammerofWrath:IsSpellLearned() or Unit(unit):HealthPercent() >= 20 and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) == 0 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) == 0)))
            end
            -- call_action_list,name=finishers,if=holy_power>=5|buff.memory_of_lucid_dreams.up|buff.seething_rage.up|talent.inquisition.enabled&buff.inquisition.down&holy_power>=3
            if Finishers(unit) and (Player:HolyPower() >= 5 or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) > 0 or A.Inquisition:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.InquisitionBuff.ID, true)) and Player:HolyPower() >= 3) then
                return true
            end
            -- wake_of_ashes,if=(!raid_event.adds.exists|raid_event.adds.in>15|spell_targets.wake_of_ashes>=2)&(holy_power<=0|holy_power=1&cooldown.blade_of_justice.remains>gcd)&(cooldown.avenging_wrath.remains>10|talent.crusade.enabled&cooldown.crusade.remains>10)
            if A.WakeofAshes:IsReady(unit) and ((not (MultiUnits:GetByRange(40) > 1) or MultiUnits:GetByRange(5) >= 2) and (Player:HolyPower() <= 0 or Player:HolyPower() == 1 and A.BladeofJustice:GetCooldown() > A.GetGCD()) and (A.AvengingWrath:GetCooldown() > 10 or A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() > 10)) then
                return A.WakeofAshes:Show(icon)
            end
            -- blade_of_justice,if=holy_power<=2|(holy_power=3&(cooldown.hammer_of_wrath.remains>gcd*2|variable.HoW))
            if A.BladeofJustice:IsReady(unit) and (Player:HolyPower() <= 2 or (Player:HolyPower() == 3 and (A.HammerofWrath:GetCooldown() > A.GetGCD() * 2 or bool(VarHow)))) then
                return A.BladeofJustice:Show(icon)
            end
            -- judgment,if=holy_power<=2|(holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|variable.HoW))
            if A.Judgment:IsReady(unit) and (Player:HolyPower() <= 2 or (Player:HolyPower() <= 4 and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or bool(VarHow)))) then
                return A.Judgment:Show(icon)
            end
            -- hammer_of_wrath,if=holy_power<=4
            if A.HammerofWrath:IsReady(unit) and (Player:HolyPower() <= 4) then
                return A.HammerofWrath:Show(icon)
            end
            -- consecration,if=holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2
            if A.Consecration:IsReady(unit) and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2) then
                return A.Consecration:Show(icon)
            end
            -- call_action_list,name=finishers,if=talent.hammer_of_wrath.enabled&target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up
            if Finishers(unit) and (A.HammerofWrath:IsSpellLearned() and Unit(unit):HealthPercent() <= 20 or Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 0) then
                return true
            end
            -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2&cooldown.consecration.remains>gcd*2)
            if A.CrusaderStrike:IsReady(unit) and (A.CrusaderStrike:GetSpellChargesFrac() >= 1.75 and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2 and A.Consecration:GetCooldown() > A.GetGCD() * 2)) then
                return A.CrusaderStrike:Show(icon)
            end
            -- call_action_list,name=finishers
            if Finishers(unit) then
                return true
            end
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            -- crusader_strike,if=holy_power<=4
            if A.CrusaderStrike:IsReady(unit) and (Player:HolyPower() <= 4) then
                return A.CrusaderStrike:Show(icon)
            end
            -- arcane_torrent,if=holy_power<=4
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:HolyPower() <= 4) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and Precombat(unit) then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
            -- auto_attack
			
			-- Interrupt Handler 	 	
  			local unit = "target"
   			local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")          
      	    local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		
			-- Rebuke
  	  	    if useKick and A.Rebuke:IsReady(unit) then 
			  	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
         	 	    return A.Rebuke:Show(icon)
         		end 
      		end 
			
     		-- HammerofJustice
      		if useCC and A.HammerofJustice:IsReady(unit) then 
	  			if Unit(unit):CanInterrupt(true, nil, 25, 70) then
     		        return A.HammerofJustice:Show(icon)
     	 	    end 
     		end 
			
            -- call_action_list,name=cooldowns
            if A.BurstIsON(unit) and Cooldowns(unit) then
                return true
            end
			
            -- call_action_list,name=generators
            if Generators(unit) then
                return true
            end
			
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 

    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 

    end
end
-- Finished

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
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end ]]--

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.HammerofJustice:IsReady() and A.HammerofJustice:IsSpellLearned() and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.HammerofJustice:Show(icon)
            end 
        end
    end 
end 

local function PartyRotation(unit)
   -- if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
   --     return false 
   -- end

  	-- BlessingofFreedomYellow
    if A.BlessingofFreedomYellow:IsCastable() and Unit(unit):HasDeBuffs("Rooted") > 0 and not Unit(unit):InLOS() then
        return A.BlessingofFreedomYellow:Show(icon)
    end
	
  	-- BlessingofProtectionYellow
    if A.BlessingofProtectionYellow:IsCastable() and not Unit(unit):InLOS() and 	
	    Unit(unit):HasBuffs("DeffBuffs") == 0 
	    or  
	   -- HP lose per sec >= 20
        Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 
		or 
        Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 
		or 
        -- TTD 
        Unit("player"):TimeToDieX(10) < 3 
	then
        return A.BlessingofProtectionYellow:Show(icon)
    end
	
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end
