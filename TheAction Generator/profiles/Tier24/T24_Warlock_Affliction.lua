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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARLOCK_AFFLICTION] = {
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
    -- Generics
    SummonPet                              = Action.Create({ Type = "Spell", ID = 691 }),
    GrimoireofSacrificeBuff                = Action.Create({ Type = "Spell", ID = 196099 }),
    GrimoireofSacrifice                    = Action.Create({ Type = "Spell", ID = 108503 }),
    SeedofCorruptionDebuff                 = Action.Create({ Type = "Spell", ID = 27243 }),
    SeedofCorruption                       = Action.Create({ Type = "Spell", ID = 27243 }),
    HauntDebuff                            = Action.Create({ Type = "Spell", ID = 48181 }),
    Haunt                                  = Action.Create({ Type = "Spell", ID = 48181 }),
    ShadowBolt                             = Action.Create({ Type = "Spell", ID = 232670 }),
    PhantomSingularity                     = Action.Create({ Type = "Spell", ID = 205179 }),
    SummonDarkglare                        = Action.Create({ Type = "Spell", ID = 205180 }),
    DreadfulCalling                        = Action.Create({ Type = "Spell", ID =  }),
    AgonyDebuff                            = Action.Create({ Type = "Spell", ID = 980 }),
    CorruptionDebuff                       = Action.Create({ Type = "Spell", ID = 146739 }),
    SiphonLifeDebuff                       = Action.Create({ Type = "Spell", ID = 63106 }),
    SiphonLife                             = Action.Create({ Type = "Spell", ID = 63106 }),
    DarkSoulMisery                         = Action.Create({ Type = "Spell", ID = 113860 }),
    DarkSoul                               = Action.Create({ Type = "Spell", ID = 113860 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    SowtheSeeds                            = Action.Create({ Type = "Spell", ID = 196226 }),
    BloodoftheEnemyBuff                    = Action.Create({ Type = "Spell", ID = 297108 }),
    Deathbolt                              = Action.Create({ Type = "Spell", ID = 264106 }),
    Agony                                  = Action.Create({ Type = "Spell", ID = 980 }),
    Corruption                             = Action.Create({ Type = "Spell", ID = 172 }),
    CreepingDeath                          = Action.Create({ Type = "Spell", ID = 264000 }),
    WritheInAgony                          = Action.Create({ Type = "Spell", ID = 196102 }),
    PandemicInvocation                     = Action.Create({ Type = "Spell", ID = 289364 }),
    UnstableAffliction                     = Action.Create({ Type = "Spell", ID = 30108 }),
    UnstableAfflictionDebuff               = Action.Create({ Type = "Spell", ID = 30108 }),
    NightfallBuff                          = Action.Create({ Type = "Spell", ID = 264571 }),
    AbsoluteCorruption                     = Action.Create({ Type = "Spell", ID = 196103 }),
    DrainLife                              = Action.Create({ Type = "Spell", ID = 234153 }),
    InevitableDemiseBuff                   = Action.Create({ Type = "Spell", ID = 273525 }),
    DrainSoul                              = Action.Create({ Type = "Spell", ID = 198590 }),
    ShadowEmbraceDebuff                    = Action.Create({ Type = "Spell", ID = 32390 }),
    ShadowEmbrace                          = Action.Create({ Type = "Spell", ID = 32388 }),
    PhantomSingularityDebuff               = Action.Create({ Type = "Spell", ID = 205179 }),
    VileTaintDebuff                        = Action.Create({ Type = "Spell", ID = 278350 }),
    CascadingCalamity                      = Action.Create({ Type = "Spell", ID = 275372 }),
    VileTaint                              = Action.Create({ Type = "Spell", ID = 278350 }),
    CascadingCalamityBuff                  = Action.Create({ Type = "Spell", ID = 275378 }),
    ActiveUasBuff                          = Action.Create({ Type = "Spell", ID = 233490 }),
    VisionofPerfection                     = Action.Create({ Type = "Spell", ID =  }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 })
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
Action:CreateEssencesFor(ACTION_CONST_WARLOCK_AFFLICTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_AFFLICTION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarMaintainSe = 0;
local VarUseSeed = 0;
local VarPadding = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarMaintainSe = 0
  VarUseSeed = 0
  VarPadding = 0
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

-- Used for VisionofPerfectionMinor check
local function DetermineEssenceRanks()
    A.VisionofPerfectionMinor = A.VisionofPerfectionMinor2:IsSpellLearned() and A.VisionofPerfectionMinor2 or A.VisionofPerfectionMinor
    A.VisionofPerfectionMinor = A.VisionofPerfectionMinor3:IsSpellLearned() and A.VisionofPerfectionMinor3 or A.VisionofPerfectionMinor
end
DetermineEssenceRanks = A.MakeFunctionCachedStatic(DetermineEssenceRanks)

-- Pet Handler UI --
local function HandlePetChoice()
    local choice = Action.GetToggle(2, "PetChoice")
    local currentspell = "Spell(688)"
    
    if choice == "IMP" then
        --print("IMP")
        currentspell = "Spell(688)"    
    elseif choice == "VOIDWALKER" then
        --print("VOIDWALKER")
        currentspell = "Spell(697)"
    elseif choice == "FELHUNTER" then 
        --print("FELHUNTER")    
        currentspell = "Spell(691)"
    elseif choice == "SUCCUBUS" then 
        --print("SUCCUBUS")    
        currentspell = "Spell(712)"
    else
        print("No Pet Data")
    end
    return choice
end

-- Multidot Handler UI --
local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if Player:InDungeon() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if Player:InPvP() then 
    		return true
		else
		    return false
		end		
    elseif choice == "Everywhere" then 
        return true
    else
		return false
    end
	--print(choice)
end

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

Action.Enum.SpellDuration = {
    -- SiphonLife  
    [63106] = {15000, 19500},
    -- Agony
    [980] = {18000, 23400},
    --Corruption
    [146739] = {14000, 18200},
    -- Darkglare
    [205180] = {20000, 26000},

}

-- Base Duration of a dot/hot/channel...
local SpellDuration = Action.Enum.SpellDuration
function A:BaseDuration()
    local Duration = SpellDuration[self.SpellID]
    if not Duration or Duration == 0 then 
	    return 0 
	end
    local BaseDuration = Duration[1]
    return BaseDuration / 1000
end

-- Pandemic Threshold
function A:PandemicThreshold()
    local BaseDuration = self:BaseDuration()
    if not BaseDuration or BaseDuration == 0 then 
	    return 0 
    end
    return BaseDuration * 0.3
end

local UnstableAfflictionDebuffs = {
  [1] = 233490,
  [2] = 233496,
  [3] = 233497,
  [4] = 233498,
  [5] = 233499
};

local function ActiveUAs(unit)
  local UACount = 0
  for i = 1, #UnstableAfflictionDebuffs do
    if Unit(unit):HasDeBuffsStacks(UnstableAfflictionDebuffs[i], true, true) > 0 then 
	    UACount = UACount + 1 
	end
  end
  return UACount
end

local function Contagion(unit)
    local MaximumDuration = 0
    for i = 1, #UnstableAfflictionDebuffs do
        local UARemains = Unit(unit):HasDeBuffs(UnstableAfflictionDebuffs[i], true, true)
        if UARemains > MaximumDuration then
            MaximumDuration = UARemains
        end
    end
    return MaximumDuration
end

-- Agony TickTime 
local function AgonyTickTime()
    local BaseTickTime = 2
    local Hasted = true
    if Hasted then
        return BaseTickTime * Player:SpellHaste() 
	end
    return BaseTickTime
end

-- "time.to.shard"
local function TimeToShard()
    local ActiveAgony = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.AgonyDebuff.ID)
    if ActiveAgony == 0 then
        return 10000 
    end
    return 1 / (0.16 / math.sqrt(ActiveAgony) * (ActiveAgony == 1 and 1.15 or 1) * ActiveAgony / AgonyTickTime())
end




local function EvaluateTargetIfFilterAgony244(unit)
  return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony285(unit)
  return A.CreepingDeath:IsSpellLearned() and A.AgonyDebuff.ID, true:ActiveDot < 6 and Unit(unit):TimeToDie() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < 5 or not bool(A.PandemicInvocation:GetAzeriteRank()) and Unit(unit):HasDeBuffsRefreshable(A.AgonyDebuff.ID, true)))
end


local function EvaluateTargetIfFilterAgony291(unit)
  return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony332(unit)
  return not A.CreepingDeath:IsSpellLearned() and A.AgonyDebuff.ID, true:ActiveDot < 8 and Unit(unit):TimeToDie() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < 5 or not bool(A.PandemicInvocation:GetAzeriteRank()) and Unit(unit):HasDeBuffsRefreshable(A.AgonyDebuff.ID, true)))
end


local function EvaluateTargetIfFilterSiphonLife338(unit)
  return Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true)
end

local function EvaluateTargetIfSiphonLife377(unit)
  return (A.SiphonLifeDebuff.ID, true:ActiveDot < 8 - num(A.CreepingDeath:IsSpellLearned()) - MultiUnits:GetByRangeInCombat(5, 5, 10)) and Unit(unit):TimeToDie() > 10 and Unit(unit):HasDeBuffsRefreshable(A.SiphonLifeDebuff.ID, true) and (not bool(Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true)) and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 or A.SummonDarkglare:GetCooldown() > Player:SoulShardsP * A.UnstableAffliction:GetSpellCastTime())
end


local function EvaluateCycleCorruption384(unit)
  return MultiUnits:GetByRangeInCombat(5, 5, 10) < 3 + raid_event.invulnerable.up + num(A.WritheInAgony:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and Unit(unit):HasDeBuffsRefreshable(A.CorruptionDebuff.ID, true)) and Unit(unit):TimeToDie() > 10
end

local function EvaluateCycleDrainSoul567(unit)
  return Unit(unit):TimeToDie() <= A.GetGCD()
end

local function EvaluateTargetIfFilterDrainSoul573(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul586(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and not bool(Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true))
end


local function EvaluateTargetIfFilterDrainSoul592(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul603(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe)
end


local function EvaluateCycleShadowBolt612(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and not bool(Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)) and not A.ShadowBolt:IsSpellInFlight()
end

local function EvaluateTargetIfFilterShadowBolt628(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfShadowBolt639(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe)
end


local function EvaluateCycleUnstableAffliction734(unit)
  return not bool(VarUseSeed) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() > time_to_shard or Player:SoulShardsP > 1) and (not A.VileTaint:IsSpellLearned() or Player:SoulShardsP > 1) and contagion <= A.UnstableAffliction:GetSpellCastTime() + VarPadding and (not bool(A.CascadingCalamity:GetAzeriteRank()) or Unit("player"):HasBuffs(A.CascadingCalamityBuff.ID, true) > time_to_shard)
end

local function EvaluateCycleDrainSoul805(unit)
  return Unit(unit):TimeToDie() <= A.GetGCD() and Player:SoulShardsP < 5
end

local function EvaluateTargetIfFilterAgony849(unit)
  return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony866(unit)
  return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() + A.ShadowBolt:GetSpellCastTime() and Unit(unit):TimeToDie() > 8
end


local function EvaluateCycleUnstableAffliction897(unit)
    return not bool(contagion) and Unit(unit):TimeToDie() <= 8
end

local function EvaluateTargetIfFilterDrainSoul903(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul918(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and bool(Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) <= A.GetGCD() * 2
end


local function EvaluateTargetIfFilterShadowBolt924(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfShadowBolt951(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and bool(Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) <= A.ShadowBolt:GetSpellCastTime() * 2 + A.ShadowBolt:TravelTime() and not A.ShadowBolt:IsSpellInFlight()
end


local function EvaluateTargetIfFilterPhantomSingularity957(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfPhantomSingularity972(unit)
  return Unit("player"):CombatTime() > 35 and Unit(unit):TimeToDie() > 16 * Player:SpellHaste() and (not bool(Azerite:EssenceHasMinor(A.VisionofPerfection.ID)) and not bool(A.DreadfulCalling:GetAzeriteRank()) or A.SummonDarkglare:GetCooldown() > 45 + Player:SoulShardsP * A.DreadfulCalling:GetAzeriteRank() or A.SummonDarkglare:GetCooldown() < 15 * Player:SpellHaste() + Player:SoulShardsP * A.DreadfulCalling:GetAzeriteRank())
end


local function EvaluateTargetIfFilterUnstableAffliction978(unit)
  return min:contagion
end

local function EvaluateTargetIfUnstableAffliction983(unit)
  return not bool(VarUseSeed) and Player:SoulShardsP == 5
end


local function EvaluateTargetIfFilterVileTaint995(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfVileTaint1010(unit)
  return Unit("player"):CombatTime() > 15 and Unit(unit):TimeToDie() >= 10 and (A.SummonDarkglare:GetCooldown() > 30 or A.SummonDarkglare:GetCooldown() < 10 and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) >= 10 and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) >= 10 and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) >= 10 or not A.SiphonLife:IsSpellLearned()))
end

      local CanMultidot = HandleMultidots()
      local unit = "player"
      local time_to_shard = TimeToShard()
      local PredictSpells = A.GetToggle(2, "PredictSpells")
      DetermineEssenceRanks()
              --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- summon_pet
            if A.SummonPet:IsReady(unit) then
                return A.SummonPet:Show(icon)
            end
            -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
            if A.GrimoireofSacrifice:IsReady(unit) and Unit("player"):HasBuffsDown(A.GrimoireofSacrificeBuff.ID, true) and (A.GrimoireofSacrifice:IsSpellLearned()) then
                return A.GrimoireofSacrifice:Show(icon)
            end
            -- snapshot_stats
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- seed_of_corruption,if=spell_targets.seed_of_corruption_aoe>=3&!equipped.169314
            if A.SeedofCorruption:IsReady(unit) and Unit("player"):HasDebuffsDown(A.SeedofCorruptionDebuff.ID, true) and (MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3 and not A.Item169314:IsExists()) then
                return A.SeedofCorruption:Show(icon)
            end
            -- haunt
            if A.Haunt:IsReady(unit) and Unit("player"):HasDebuffsDown(A.HauntDebuff.ID, true) then
                return A.Haunt:Show(icon)
            end
            -- shadow_bolt,if=!talent.haunt.enabled&spell_targets.seed_of_corruption_aoe<3&!equipped.169314
            if A.ShadowBolt:IsReady(unit) and (not A.Haunt:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) < 3 and not A.Item169314:IsExists()) then
                return A.ShadowBolt:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- use_item,name=azsharas_font_of_power,if=(!talent.phantom_singularity.enabled|cooldown.phantom_singularity.remains<4*spell_haste|!cooldown.phantom_singularity.remains)&cooldown.summon_darkglare.remains<19*spell_haste+soul_shard*azerite.dreadful_calling.rank&dot.agony.remains&dot.corruption.remains&(dot.siphon_life.remains|!talent.siphon_life.enabled)
            if A.AzsharasFontofPower:IsReady(unit) and ((not A.PhantomSingularity:IsSpellLearned() or A.PhantomSingularity:GetCooldown() < 4 * Player:SpellHaste() or not bool(A.PhantomSingularity:GetCooldown())) and A.SummonDarkglare:GetCooldown() < 19 * Player:SpellHaste() + Player:SoulShardsP * A.DreadfulCalling:GetAzeriteRank() and bool(Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)) and bool(Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true)) and (bool(Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true)) or not A.SiphonLife:IsSpellLearned())) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- potion,if=(talent.dark_soul_misery.enabled&cooldown.summon_darkglare.up&cooldown.dark_soul.up)|cooldown.summon_darkglare.up|target.time_to_die<30
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and ((A.DarkSoulMisery:IsSpellLearned() and A.SummonDarkglare:GetCooldown() == 0 and A.DarkSoul:GetCooldown() == 0) or A.SummonDarkglare:GetCooldown() == 0 or Unit(unit):TimeToDie() < 30) then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- use_items,if=cooldown.summon_darkglare.remains>70|time_to_die<20|((buff.active_uas.stack=5|soul_shard=0)&(!talent.phantom_singularity.enabled|cooldown.phantom_singularity.remains)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=gcd|!cooldown.deathbolt.remains)&!cooldown.summon_darkglare.remains)
            -- fireblood,if=!cooldown.summon_darkglare.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.SummonDarkglare:GetCooldown() == 0) then
                return A.Fireblood:Show(icon)
            end
            -- blood_fury,if=!cooldown.summon_darkglare.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.SummonDarkglare:GetCooldown() == 0) then
                return A.BloodFury:Show(icon)
            end
            -- memory_of_lucid_dreams,if=time>30
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):CombatTime() > 30) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- dark_soul,if=target.time_to_die<20+gcd|talent.sow_the_seeds.enabled&cooldown.summon_darkglare.remains>=cooldown.summon_darkglare.duration-10
            if A.DarkSoul:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):TimeToDie() < 20 + A.GetGCD() or A.SowtheSeeds:IsSpellLearned() and A.SummonDarkglare:GetCooldown() >= A.SummonDarkglare:BaseDuration() - 10) then
                return A.DarkSoul:Show(icon)
            end
            -- blood_of_the_enemy,if=pet.darkglare.remains|(!cooldown.deathbolt.remains|!talent.deathbolt.enabled)&cooldown.summon_darkglare.remains>=80&essence.blood_of_the_enemy.rank>1
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (bool(Unit("player"):HasBuffs(A.BloodoftheEnemyBuff.ID, true)) or (not bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned()) and A.SummonDarkglare:GetCooldown() >= 80 and A.BloodoftheEnemy:GetRank() > 1) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- use_item,name=pocketsized_computation_device,if=(cooldown.summon_darkglare.remains>=25|target.time_to_die<=30)&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
            if A.PocketsizedComputationDevice:IsReady(unit) and ((A.SummonDarkglare:GetCooldown() >= 25 or Unit(unit):TimeToDie() <= 30) and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
                A.PocketsizedComputationDevice:Show(icon)
            end
            -- use_item,name=rotcrusted_voodoo_doll,if=(cooldown.summon_darkglare.remains>=25|target.time_to_die<=30)&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
            if A.RotcrustedVoodooDoll:IsReady(unit) and ((A.SummonDarkglare:GetCooldown() >= 25 or Unit(unit):TimeToDie() <= 30) and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
                A.RotcrustedVoodooDoll:Show(icon)
            end
            -- use_item,name=shiver_venom_relic,if=(cooldown.summon_darkglare.remains>=25|target.time_to_die<=30)&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
            if A.ShiverVenomRelic:IsReady(unit) and ((A.SummonDarkglare:GetCooldown() >= 25 or Unit(unit):TimeToDie() <= 30) and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
                A.ShiverVenomRelic:Show(icon)
            end
            -- use_item,name=aquipotent_nautilus,if=(cooldown.summon_darkglare.remains>=25|target.time_to_die<=30)&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
            if A.AquipotentNautilus:IsReady(unit) and ((A.SummonDarkglare:GetCooldown() >= 25 or Unit(unit):TimeToDie() <= 30) and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
                A.AquipotentNautilus:Show(icon)
            end
            -- use_item,name=tidestorm_codex,if=(cooldown.summon_darkglare.remains>=25|target.time_to_die<=30)&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
            if A.TidestormCodex:IsReady(unit) and ((A.SummonDarkglare:GetCooldown() >= 25 or Unit(unit):TimeToDie() <= 30) and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
                A.TidestormCodex:Show(icon)
            end
            -- use_item,name=vial_of_storms,if=(cooldown.summon_darkglare.remains>=25|target.time_to_die<=30)&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
            if A.VialofStorms:IsReady(unit) and ((A.SummonDarkglare:GetCooldown() >= 25 or Unit(unit):TimeToDie() <= 30) and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
                A.VialofStorms:Show(icon)
            end
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
        end
        
        --DbRefresh
        local function DbRefresh(unit)
            -- siphon_life,line_cd=15,if=(dot.siphon_life.remains%dot.siphon_life.duration)<=(dot.agony.remains%dot.agony.duration)&(dot.siphon_life.remains%dot.siphon_life.duration)<=(dot.corruption.remains%dot.corruption.duration)&dot.siphon_life.remains<dot.siphon_life.duration*1.3
            if A.SiphonLife:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) / A.SiphonLifeDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) / A.AgonyDebuff.ID, true:BaseDuration()) and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) / A.SiphonLifeDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) / A.CorruptionDebuff.ID, true:BaseDuration()) and Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) < A.SiphonLifeDebuff.ID, true:BaseDuration() * 1.3) then
                return A.SiphonLife:Show(icon)
            end
            -- agony,line_cd=15,if=(dot.agony.remains%dot.agony.duration)<=(dot.corruption.remains%dot.corruption.duration)&(dot.agony.remains%dot.agony.duration)<=(dot.siphon_life.remains%dot.siphon_life.duration)&dot.agony.remains<dot.agony.duration*1.3
            if A.Agony:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) / A.AgonyDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) / A.CorruptionDebuff.ID, true:BaseDuration()) and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) / A.AgonyDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) / A.SiphonLifeDebuff.ID, true:BaseDuration()) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < A.AgonyDebuff.ID, true:BaseDuration() * 1.3) then
                return A.Agony:Show(icon)
            end
            -- corruption,line_cd=15,if=(dot.corruption.remains%dot.corruption.duration)<=(dot.agony.remains%dot.agony.duration)&(dot.corruption.remains%dot.corruption.duration)<=(dot.siphon_life.remains%dot.siphon_life.duration)&dot.corruption.remains<dot.corruption.duration*1.3
            if A.Corruption:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) / A.CorruptionDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) / A.AgonyDebuff.ID, true:BaseDuration()) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) / A.CorruptionDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) / A.SiphonLifeDebuff.ID, true:BaseDuration()) and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) < A.CorruptionDebuff.ID, true:BaseDuration() * 1.3) then
                return A.Corruption:Show(icon)
            end
        end
        
        --Dots
        local function Dots(unit)
            -- seed_of_corruption,if=dot.corruption.remains<=action.seed_of_corruption.cast_time+time_to_shard+4.2*(1-talent.creeping_death.enabled*0.15)&spell_targets.seed_of_corruption_aoe>=3+raid_event.invulnerable.up+talent.writhe_in_agony.enabled&!dot.seed_of_corruption.remains&!action.seed_of_corruption.in_flight
            if A.SeedofCorruption:IsReady(unit) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) <= A.SeedofCorruption:GetSpellCastTime() + time_to_shard + 4.2 * (1 - num(A.CreepingDeath:IsSpellLearned()) * 0.15) and MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3 + raid_event.invulnerable.up + num(A.WritheInAgony:IsSpellLearned()) and not bool(Unit(unit):HasDeBuffs(A.SeedofCorruptionDebuff.ID, true)) and not A.SeedofCorruption:IsSpellInFlight()) then
                return A.SeedofCorruption:Show(icon)
            end
            -- agony,target_if=min:remains,if=talent.creeping_death.enabled&active_dot.agony<6&target.time_to_die>10&(remains<=gcd|cooldown.summon_darkglare.remains>10&(remains<5|!azerite.pandemic_invocation.rank&refreshable))
            if A.Agony:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Agony, 40, "min", EvaluateTargetIfFilterAgony244, EvaluateTargetIfAgony285) then 
                    return A.Agony:Show(icon) 
                end
            end
            -- agony,target_if=min:remains,if=!talent.creeping_death.enabled&active_dot.agony<8&target.time_to_die>10&(remains<=gcd|cooldown.summon_darkglare.remains>10&(remains<5|!azerite.pandemic_invocation.rank&refreshable))
            if A.Agony:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Agony, 40, "min", EvaluateTargetIfFilterAgony291, EvaluateTargetIfAgony332) then 
                    return A.Agony:Show(icon) 
                end
            end
            -- siphon_life,target_if=min:remains,if=(active_dot.siphon_life<8-talent.creeping_death.enabled-spell_targets.sow_the_seeds_aoe)&target.time_to_die>10&refreshable&(!remains&spell_targets.seed_of_corruption_aoe=1|cooldown.summon_darkglare.remains>soul_shard*action.unstable_affliction.execute_time)
            if A.SiphonLife:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SiphonLife, 40, "min", EvaluateTargetIfFilterSiphonLife338, EvaluateTargetIfSiphonLife377) then 
                    return A.SiphonLife:Show(icon) 
                end
            end
            -- corruption,cycle_targets=1,if=spell_targets.seed_of_corruption_aoe<3+raid_event.invulnerable.up+talent.writhe_in_agony.enabled&(remains<=gcd|cooldown.summon_darkglare.remains>10&refreshable)&target.time_to_die>10
            if A.Corruption:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Corruption, 40, "min", EvaluateCycleCorruption384) then
                    return A.Corruption:Show(icon) 
                end
            end
        end
        
        --Fillers
        local function Fillers(unit)
            -- unstable_affliction,line_cd=15,if=cooldown.deathbolt.remains<=gcd*2&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&cooldown.summon_darkglare.remains>20
            if A.UnstableAffliction:IsReady(unit) and (A.Deathbolt:GetCooldown() <= A.GetGCD() * 2 and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 + raid_event.invulnerable.up and A.SummonDarkglare:GetCooldown() > 20) then
                return A.UnstableAffliction:Show(icon)
            end
            -- call_action_list,name=db_refresh,if=talent.deathbolt.enabled&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&(dot.agony.remains<dot.agony.duration*0.75|dot.corruption.remains<dot.corruption.duration*0.75|dot.siphon_life.remains<dot.siphon_life.duration*0.75)&cooldown.deathbolt.remains<=action.agony.gcd*4&cooldown.summon_darkglare.remains>20
            if (A.Deathbolt:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 + raid_event.invulnerable.up and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < A.AgonyDebuff.ID, true:BaseDuration() * 0.75 or Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) < A.CorruptionDebuff.ID, true:BaseDuration() * 0.75 or Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) < A.SiphonLifeDebuff.ID, true:BaseDuration() * 0.75) and A.Deathbolt:GetCooldown() <= action.agony.gcd * 4 and A.SummonDarkglare:GetCooldown() > 20) then
                local ShouldReturn = DbRefresh(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=db_refresh,if=talent.deathbolt.enabled&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&cooldown.summon_darkglare.remains<=soul_shard*action.agony.gcd+action.agony.gcd*3&(dot.agony.remains<dot.agony.duration*1|dot.corruption.remains<dot.corruption.duration*1|dot.siphon_life.remains<dot.siphon_life.duration*1)
            if (A.Deathbolt:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 + raid_event.invulnerable.up and A.SummonDarkglare:GetCooldown() <= Player:SoulShardsP * action.agony.gcd + action.agony.gcd * 3 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < A.AgonyDebuff.ID, true:BaseDuration() * 1 or Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) < A.CorruptionDebuff.ID, true:BaseDuration() * 1 or Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) < A.SiphonLifeDebuff.ID, true:BaseDuration() * 1)) then
                local ShouldReturn = DbRefresh(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- deathbolt,if=cooldown.summon_darkglare.remains>=30+gcd|cooldown.summon_darkglare.remains>140
            if A.Deathbolt:IsReady(unit) and (A.SummonDarkglare:GetCooldown() >= 30 + A.GetGCD() or A.SummonDarkglare:GetCooldown() > 140) then
                return A.Deathbolt:Show(icon)
            end
            -- shadow_bolt,if=buff.movement.up&buff.nightfall.remains
            if A.ShadowBolt:IsReady(unit) and (Unit("player"):IsMoving and bool(Unit("player"):HasBuffs(A.NightfallBuff.ID, true))) then
                return A.ShadowBolt:Show(icon)
            end
            -- agony,if=buff.movement.up&!(talent.siphon_life.enabled&(prev_gcd.1.agony&prev_gcd.2.agony&prev_gcd.3.agony)|prev_gcd.1.agony)
            if A.Agony:IsReady(unit) and (Unit("player"):IsMoving and not (A.SiphonLife:IsSpellLearned() and (Unit("player"):GetSpellLastCast(A.Agony) and Unit("player"):GetSpellLastCast(A.Agony) and Unit("player"):GetSpellLastCast(A.Agony)) or Unit("player"):GetSpellLastCast(A.Agony))) then
                return A.Agony:Show(icon)
            end
            -- siphon_life,if=buff.movement.up&!(prev_gcd.1.siphon_life&prev_gcd.2.siphon_life&prev_gcd.3.siphon_life)
            if A.SiphonLife:IsReady(unit) and (Unit("player"):IsMoving and not (Unit("player"):GetSpellLastCast(A.SiphonLife) and Unit("player"):GetSpellLastCast(A.SiphonLife) and Unit("player"):GetSpellLastCast(A.SiphonLife))) then
                return A.SiphonLife:Show(icon)
            end
            -- corruption,if=buff.movement.up&!prev_gcd.1.corruption&!talent.absolute_corruption.enabled
            if A.Corruption:IsReady(unit) and (Unit("player"):IsMoving and not Unit("player"):GetSpellLastCast(A.Corruption) and not A.AbsoluteCorruption:IsSpellLearned()) then
                return A.Corruption:Show(icon)
            end
            -- drain_life,if=buff.inevitable_demise.stack>10&target.time_to_die<=10
            if A.DrainLife:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) > 10 and Unit(unit):TimeToDie() <= 10) then
                return A.DrainLife:Show(icon)
            end
            -- drain_life,if=talent.siphon_life.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=2)&dot.agony.remains>5*spell_haste&dot.corruption.remains>gcd&(dot.siphon_life.remains>gcd|!talent.siphon_life.enabled)&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
            if A.DrainLife:IsReady(unit) and A.BurstIsON(unit) and (A.SiphonLife:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) >= 50 - 20 * num((MultiUnits:GetByRangeInCombat(5, 5, 10) - raid_event.invulnerable.up >= 2)) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 5 * Player:SpellHaste() and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) > A.GetGCD() and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) > A.GetGCD() or not A.SiphonLife:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.HauntDebuff.ID, true) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste()) then
                return A.DrainLife:Show(icon)
            end
            -- drain_life,if=talent.writhe_in_agony.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=3)-5*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up=2)&dot.agony.remains>5*spell_haste&dot.corruption.remains>gcd&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
            if A.DrainLife:IsReady(unit) and A.BurstIsON(unit) and (A.WritheInAgony:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) >= 50 - 20 * num((MultiUnits:GetByRangeInCombat(5, 5, 10) - raid_event.invulnerable.up >= 3)) - 5 * num((MultiUnits:GetByRangeInCombat(5, 5, 10) - raid_event.invulnerable.up == 2)) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 5 * Player:SpellHaste() and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) > A.GetGCD() and (Unit(unit):HasDeBuffs(A.HauntDebuff.ID, true) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste()) then
                return A.DrainLife:Show(icon)
            end
            -- drain_life,if=talent.absolute_corruption.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=4)&dot.agony.remains>5*spell_haste&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
            if A.DrainLife:IsReady(unit) and A.BurstIsON(unit) and (A.AbsoluteCorruption:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) >= 50 - 20 * num((MultiUnits:GetByRangeInCombat(5, 5, 10) - raid_event.invulnerable.up >= 4)) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 5 * Player:SpellHaste() and (Unit(unit):HasDeBuffs(A.HauntDebuff.ID, true) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste()) then
                return A.DrainLife:Show(icon)
            end
            -- haunt
            if A.Haunt:IsReady(unit) then
                return A.Haunt:Show(icon)
            end
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not bool(Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true)) and not A.ConcentratedFlame:IsSpellInFlight()) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- drain_soul,interrupt_global=1,chain=1,interrupt=1,cycle_targets=1,if=target.time_to_die<=gcd
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateCycleDrainSoul567) then
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&variable.maintain_se&!debuff.shadow_embrace.remains
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul573, EvaluateTargetIfDrainSoul586) then 
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&variable.maintain_se
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul592, EvaluateTargetIfDrainSoul603) then 
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- drain_soul,interrupt_global=1,chain=1,interrupt=1
            if A.DrainSoul:IsReady(unit) then
                return A.DrainSoul:Show(icon)
            end
            -- shadow_bolt,cycle_targets=1,if=talent.shadow_embrace.enabled&variable.maintain_se&!debuff.shadow_embrace.remains&!action.shadow_bolt.in_flight
            if A.ShadowBolt:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowBolt, 40, "min", EvaluateCycleShadowBolt612) then
                    return A.ShadowBolt:Show(icon) 
                end
            end
            -- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se
            if A.ShadowBolt:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowBolt, 40, "min", EvaluateTargetIfFilterShadowBolt628, EvaluateTargetIfShadowBolt639) then 
                    return A.ShadowBolt:Show(icon) 
                end
            end
            -- shadow_bolt
            if A.ShadowBolt:IsReady(unit) then
                return A.ShadowBolt:Show(icon)
            end
        end
        
        --Spenders
        local function Spenders(unit)
            -- unstable_affliction,if=cooldown.summon_darkglare.remains<=soul_shard*(execute_time+azerite.dreadful_calling.rank)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=soul_shard*execute_time)&(talent.sow_the_seeds.enabled|dot.phantom_singularity.remains|dot.vile_taint.remains)
            if A.UnstableAffliction:IsReady(unit) and (A.SummonDarkglare:GetCooldown() <= Player:SoulShardsP * (A.UnstableAffliction:GetSpellCastTime() + A.DreadfulCalling:GetAzeriteRank()) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() <= Player:SoulShardsP * A.UnstableAffliction:GetSpellCastTime()) and (A.SowtheSeeds:IsSpellLearned() or bool(Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true)) or bool(Unit(unit):HasDeBuffs(A.VileTaintDebuff.ID, true)))) then
                return A.UnstableAffliction:Show(icon)
            end
            -- call_action_list,name=fillers,if=(cooldown.summon_darkglare.remains<time_to_shard*(5-soul_shard)|cooldown.summon_darkglare.up)&time_to_die>cooldown.summon_darkglare.remains
            if ((A.SummonDarkglare:GetCooldown() < time_to_shard * (5 - Player:SoulShardsP) or A.SummonDarkglare:GetCooldown() == 0) and Unit(unit):TimeToDie() > A.SummonDarkglare:GetCooldown()) then
                local ShouldReturn = Fillers(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- seed_of_corruption,if=variable.use_seed
            if A.SeedofCorruption:IsReady(unit) and (bool(VarUseSeed)) then
                return A.SeedofCorruption:Show(icon)
            end
            -- unstable_affliction,if=!variable.use_seed&!prev_gcd.1.summon_darkglare&(talent.deathbolt.enabled&cooldown.deathbolt.remains<=execute_time&!azerite.cascading_calamity.enabled|(soul_shard>=5&spell_targets.seed_of_corruption_aoe<2|soul_shard>=2&spell_targets.seed_of_corruption_aoe>=2)&target.time_to_die>4+execute_time&spell_targets.seed_of_corruption_aoe=1|target.time_to_die<=8+execute_time*soul_shard)
            if A.UnstableAffliction:IsReady(unit) and (not bool(VarUseSeed) and not Unit("player"):GetSpellLastCast(A.SummonDarkglare) and (A.Deathbolt:IsSpellLearned() and A.Deathbolt:GetCooldown() <= A.UnstableAffliction:GetSpellCastTime() and not bool(A.CascadingCalamity:GetAzeriteRank()) or (Player:SoulShardsP >= 5 and MultiUnits:GetByRangeInCombat(5, 5, 10) < 2 or Player:SoulShardsP >= 2 and MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2) and Unit(unit):TimeToDie() > 4 + A.UnstableAffliction:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 or Unit(unit):TimeToDie() <= 8 + A.UnstableAffliction:GetSpellCastTime() * Player:SoulShardsP)) then
                return A.UnstableAffliction:Show(icon)
            end
            -- unstable_affliction,if=!variable.use_seed&contagion<=cast_time+variable.padding
            if A.UnstableAffliction:IsReady(unit) and (not bool(VarUseSeed) and contagion <= A.UnstableAffliction:GetSpellCastTime() + VarPadding) then
                return A.UnstableAffliction:Show(icon)
            end
            -- unstable_affliction,cycle_targets=1,if=!variable.use_seed&(!talent.deathbolt.enabled|cooldown.deathbolt.remains>time_to_shard|soul_shard>1)&(!talent.vile_taint.enabled|soul_shard>1)&contagion<=cast_time+variable.padding&(!azerite.cascading_calamity.enabled|buff.cascading_calamity.remains>time_to_shard)
            if A.UnstableAffliction:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.UnstableAffliction, 40, "min", EvaluateCycleUnstableAffliction734) then
                    return A.UnstableAffliction:Show(icon) 
                end
            end
        end
        
      -- call precombat
if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then
  local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
end
      if Unit(unit):IsExists() then
                     -- variable,name=use_seed,value=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>=3+raid_event.invulnerable.up|talent.siphon_life.enabled&spell_targets.seed_of_corruption>=5+raid_event.invulnerable.up|spell_targets.seed_of_corruption>=8+raid_event.invulnerable.up
            if (true) then
                VarUseSeed = num(A.SowtheSeeds:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3 + raid_event.invulnerable.up or A.SiphonLife:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 5 + raid_event.invulnerable.up or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 8 + raid_event.invulnerable.up)
            end
            -- variable,name=padding,op=set,value=action.shadow_bolt.execute_time*azerite.cascading_calamity.enabled
            if (true) then
                VarPadding = A.ShadowBolt:GetSpellCastTime() * A.CascadingCalamity:GetAzeriteRank()
            end
            -- variable,name=padding,op=reset,value=gcd,if=azerite.cascading_calamity.enabled&(talent.drain_soul.enabled|talent.deathbolt.enabled&cooldown.deathbolt.remains<=gcd)
            if (bool(A.CascadingCalamity:GetAzeriteRank()) and (A.DrainSoul:IsSpellLearned() or A.Deathbolt:IsSpellLearned() and A.Deathbolt:GetCooldown() <= A.GetGCD())) then
                VarPadding = 0
            end
            -- variable,name=maintain_se,value=spell_targets.seed_of_corruption_aoe<=1+talent.writhe_in_agony.enabled+talent.absolute_corruption.enabled*2+(talent.writhe_in_agony.enabled&talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>2)+(talent.siphon_life.enabled&!talent.creeping_death.enabled&!talent.drain_soul.enabled)+raid_event.invulnerable.up
            if (true) then
                VarMaintainSe = num(MultiUnits:GetByRangeInCombat(5, 5, 10) <= 1 + num(A.WritheInAgony:IsSpellLearned()) + num(A.AbsoluteCorruption:IsSpellLearned()) * 2 + num((A.WritheInAgony:IsSpellLearned() and A.SowtheSeeds:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) > 2)) + num((A.SiphonLife:IsSpellLearned() and not A.CreepingDeath:IsSpellLearned() and not A.DrainSoul:IsSpellLearned())) + raid_event.invulnerable.up)
            end
            -- call_action_list,name=cooldowns
            if (true) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- drain_soul,interrupt_global=1,chain=1,cycle_targets=1,if=target.time_to_die<=gcd&soul_shard<5
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateCycleDrainSoul805) then
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- haunt,if=spell_targets.seed_of_corruption_aoe<=2+raid_event.invulnerable.up
            if A.Haunt:IsReady(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) <= 2 + raid_event.invulnerable.up) then
                return A.Haunt:Show(icon)
            end
            -- summon_darkglare,if=summon_darkglare,if=dot.agony.ticking&dot.corruption.ticking&(buff.active_uas.stack=5|soul_shard=0|dot.phantom_singularity.remains&dot.phantom_singularity.remains<=gcd)&(!talent.phantom_singularity.enabled|dot.phantom_singularity.remains)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=gcd|!cooldown.deathbolt.remains|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up)
            if A.SummonDarkglare:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) and (ActiveUAs(unit) == 5 or Player:SoulShardsP == 0 or bool(Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true)) and Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true) <= A.GetGCD()) and (not A.PhantomSingularity:IsSpellLearned() or bool(Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true))) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() <= A.GetGCD() or not bool(A.Deathbolt:GetCooldown()) or MultiUnits:GetByRangeInCombat(5, 5, 10) > 1 + raid_event.invulnerable.up)) then
                return A.SummonDarkglare:Show(icon)
            end
            -- deathbolt,if=cooldown.summon_darkglare.remains&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&(!essence.vision_of_perfection.minor&!azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains>30)
            if A.Deathbolt:IsReady(unit) and (bool(A.SummonDarkglare:GetCooldown()) and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 + raid_event.invulnerable.up and (not bool(Azerite:EssenceHasMinor(A.VisionofPerfection.ID)) and not bool(A.DreadfulCalling:GetAzeriteRank()) or A.SummonDarkglare:GetCooldown() > 30)) then
                return A.Deathbolt:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.remains
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (bool(Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true))) then
                return A.TheUnboundForce:Show(icon)
            end
            -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
            if A.Agony:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Agony, 40, "min", EvaluateTargetIfFilterAgony849, EvaluateTargetIfAgony866) then 
                    return A.Agony:Show(icon) 
                end
            end
            -- memory_of_lucid_dreams,if=time<30
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):CombatTime() < 30) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- agony,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314
            if A.Agony:IsReady(unit) and (Unit("player"):CombatTime() > 30 and A.SummonDarkglare:GetCooldown() <= 15 and A.Item169314:IsExists()) then
                return A.Agony:Show(icon)
            end
            -- corruption,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314&!talent.absolute_corruption.enabled&(talent.siphon_life.enabled|spell_targets.seed_of_corruption_aoe>1&spell_targets.seed_of_corruption_aoe<=3)
            if A.Corruption:IsReady(unit) and (Unit("player"):CombatTime() > 30 and A.SummonDarkglare:GetCooldown() <= 15 and A.Item169314:IsExists() and not A.AbsoluteCorruption:IsSpellLearned() and (A.SiphonLife:IsSpellLearned() or MultiUnits:GetByRangeInCombat(5, 5, 10) > 1 and MultiUnits:GetByRangeInCombat(5, 5, 10) <= 3)) then
                return A.Corruption:Show(icon)
            end
            -- siphon_life,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314
            if A.SiphonLife:IsReady(unit) and (Unit("player"):CombatTime() > 30 and A.SummonDarkglare:GetCooldown() <= 15 and A.Item169314:IsExists()) then
                return A.SiphonLife:Show(icon)
            end
            -- unstable_affliction,target_if=!contagion&target.time_to_die<=8
            if A.UnstableAffliction:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.UnstableAffliction, 40, "min", EvaluateCycleUnstableAffliction897) then
                    return A.UnstableAffliction:Show(icon) 
                end
            end
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,cancel_if=ticks_remain<5,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=gcd*2
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul903, EvaluateTargetIfDrainSoul918) then 
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=execute_time*2+travel_time&!action.shadow_bolt.in_flight
            if A.ShadowBolt:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowBolt, 40, "min", EvaluateTargetIfFilterShadowBolt924, EvaluateTargetIfShadowBolt951) then 
                    return A.ShadowBolt:Show(icon) 
                end
            end
            -- phantom_singularity,target_if=max:target.time_to_die,if=time>35&target.time_to_die>16*spell_haste&(!essence.vision_of_perfection.minor&!azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains>45+soul_shard*azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains<15*spell_haste+soul_shard*azerite.dreadful_calling.rank)
            if A.PhantomSingularity:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.PhantomSingularity, 40, "max", EvaluateTargetIfFilterPhantomSingularity957, EvaluateTargetIfPhantomSingularity972) then 
                    return A.PhantomSingularity:Show(icon) 
                end
            end
            -- unstable_affliction,target_if=min:contagion,if=!variable.use_seed&soul_shard=5
            if A.UnstableAffliction:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.UnstableAffliction, 40, "min", EvaluateTargetIfFilterUnstableAffliction978, EvaluateTargetIfUnstableAffliction983) then 
                    return A.UnstableAffliction:Show(icon) 
                end
            end
            -- seed_of_corruption,if=variable.use_seed&soul_shard=5
            if A.SeedofCorruption:IsReady(unit) and (bool(VarUseSeed) and Player:SoulShardsP == 5) then
                return A.SeedofCorruption:Show(icon)
            end
            -- call_action_list,name=dots
            if (true) then
                local ShouldReturn = Dots(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- vile_taint,target_if=max:target.time_to_die,if=time>15&target.time_to_die>=10&(cooldown.summon_darkglare.remains>30|cooldown.summon_darkglare.remains<10&dot.agony.remains>=10&dot.corruption.remains>=10&(dot.siphon_life.remains>=10|!talent.siphon_life.enabled))
            if A.VileTaint:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.VileTaint, 40, "max", EvaluateTargetIfFilterVileTaint995, EvaluateTargetIfVileTaint1010) then 
                    return A.VileTaint:Show(icon) 
                end
            end
            -- use_item,name=azsharas_font_of_power,if=time<=3
            if A.AzsharasFontofPower:IsReady(unit) and (Unit("player"):CombatTime() <= 3) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- phantom_singularity,if=time<=35
            if A.PhantomSingularity:IsReady(unit) and (Unit("player"):CombatTime() <= 35) then
                return A.PhantomSingularity:Show(icon)
            end
            -- vile_taint,if=time<15
            if A.VileTaint:IsReady(unit) and (Unit("player"):CombatTime() < 15) then
                return A.VileTaint:Show(icon)
            end
            -- guardian_of_azeroth,if=(cooldown.summon_darkglare.remains<15+soul_shard*azerite.dreadful_calling.enabled|(azerite.dreadful_calling.rank|essence.vision_of_perfection.rank)&time>30&target.time_to_die>=210)&(dot.phantom_singularity.remains|dot.vile_taint.remains|!talent.phantom_singularity.enabled&!talent.vile_taint.enabled)|target.time_to_die<30+gcd
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((A.SummonDarkglare:GetCooldown() < 15 + Player:SoulShardsP * A.DreadfulCalling:GetAzeriteRank() or (bool(A.DreadfulCalling:GetAzeriteRank()) or bool(A.VisionofPerfection:GetRank())) and Unit("player"):CombatTime() > 30 and Unit(unit):TimeToDie() >= 210) and (bool(Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true)) or bool(Unit(unit):HasDeBuffs(A.VileTaintDebuff.ID, true)) or not A.PhantomSingularity:IsSpellLearned() and not A.VileTaint:IsSpellLearned()) or Unit(unit):TimeToDie() < 30 + A.GetGCD()) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- dark_soul,if=cooldown.summon_darkglare.remains<15+soul_shard*azerite.dreadful_calling.enabled&(dot.phantom_singularity.remains|dot.vile_taint.remains)
            if A.DarkSoul:IsReady(unit) and A.BurstIsON(unit) and (A.SummonDarkglare:GetCooldown() < 15 + Player:SoulShardsP * A.DreadfulCalling:GetAzeriteRank() and (bool(Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true)) or bool(Unit(unit):HasDeBuffs(A.VileTaintDebuff.ID, true)))) then
                return A.DarkSoul:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- call_action_list,name=spenders
            if (true) then
                local ShouldReturn = Spenders(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=fillers
            if (true) then
                local ShouldReturn = Fillers(unit); if ShouldReturn then return ShouldReturn; end
            end
      end

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
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
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
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
end]]--

