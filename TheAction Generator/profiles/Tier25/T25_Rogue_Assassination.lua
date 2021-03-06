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
Action[ACTION_CONST_ROGUE_ASSASSINATION] = {
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
    MarkedForDeath                         = Action.Create({ Type = "Spell", ID = 137619 }),
    ApplyPoison                            = Action.Create({ Type = "Spell", ID =  }),
    Vendetta                               = Action.Create({ Type = "Spell", ID = 79140 }),
    VendettaDebuff                         = Action.Create({ Type = "Spell", ID = 79140 }),
    ToxicBladeDebuff                       = Action.Create({ Type = "Spell", ID = 245389 }),
    RuptureDebuff                          = Action.Create({ Type = "Spell", ID = 1943 }),
    Subterfuge                             = Action.Create({ Type = "Spell", ID = 108208 }),
    ShroudedSuffocation                    = Action.Create({ Type = "Spell", ID =  }),
    GarroteDebuff                          = Action.Create({ Type = "Spell", ID = 703 }),
    Vanish                                 = Action.Create({ Type = "Spell", ID = 1856 }),
    Nightstalker                           = Action.Create({ Type = "Spell", ID = 14062 }),
    Exsanguinate                           = Action.Create({ Type = "Spell", ID = 200806 }),
    DeeperStratagem                        = Action.Create({ Type = "Spell", ID = 193531 }),
    ToxicBlade                             = Action.Create({ Type = "Spell", ID = 245388 }),
    VisionofPerfection                     = Action.Create({ Type = "Spell", ID =  }),
    PoolResource                           = Action.Create({ Type = "Spell", ID = 9999000010 }),
    Garrote                                = Action.Create({ Type = "Spell", ID = 703 }),
    MasterAssassin                         = Action.Create({ Type = "Spell", ID =  }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Envenom                                = Action.Create({ Type = "Spell", ID = 32645 }),
    FanofKnives                            = Action.Create({ Type = "Spell", ID = 51723 }),
    EchoingBlades                          = Action.Create({ Type = "Spell", ID =  }),
    HiddenBladesBuff                       = Action.Create({ Type = "Spell", ID =  }),
    DoubleDose                             = Action.Create({ Type = "Spell", ID =  }),
    DeadlyPoisonDotDebuff                  = Action.Create({ Type = "Spell", ID = 177918 }),
    Blindside                              = Action.Create({ Type = "Spell", ID =  }),
    BlindsideBuff                          = Action.Create({ Type = "Spell", ID =  }),
    VenomRush                              = Action.Create({ Type = "Spell", ID = 152152 }),
    Mutilate                               = Action.Create({ Type = "Spell", ID = 1329 }),
    ScentofBlood                           = Action.Create({ Type = "Spell", ID =  }),
    Rupture                                = Action.Create({ Type = "Spell", ID = 1943 }),
    CrimsonTempest                         = Action.Create({ Type = "Spell", ID = 121411 }),
    CrimsonTempestBuff                     = Action.Create({ Type = "Spell", ID = 121411 }),
    ReapingFlames                          = Action.Create({ Type = "Spell", ID =  }),
    SubterfugeBuff                         = Action.Create({ Type = "Spell", ID = 108208 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID =  }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_ROGUE_ASSASSINATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_ASSASSINATION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarVendettaSubterfugeCondition = 0;
local VarVendettaNightstalkerCondition = 0;
local VarVendettaFontCondition = 0;
local VarSingleUnit(unit) = 0;
local VarSsVanishCondition = 0;
local VarEnergyRegenCombined = 0;
local VarUseFiller = 0;
local VarSkipCycleGarrote = 0;
local VarSkipCycleRupture = 0;
local VarSkipRupture = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarVendettaSubterfugeCondition = 0
  VarVendettaNightstalkerCondition = 0
  VarVendettaFontCondition = 0
  VarSingleUnit(unit) = 0
  VarSsVanishCondition = 0
  VarEnergyRegenCombined = 0
  VarUseFiller = 0
  VarSkipCycleGarrote = 0
  VarSkipCycleRupture = 0
  VarSkipRupture = 0
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

---------------------------------------------------
-------------- ASSASSINATION PREAPL ---------------
---------------------------------------------------
local BleedTickTime, ExsanguinatedBleedTickTime = 2 / Unit("player"):SpellHaste(), 1 / Unit("player"):SpellHaste();
local Stealth;
local RuptureThreshold, RuptureDMGThreshold, GarroteDMGThreshold;
local ComboPoints, ComboPointsDeficit, Energy_Regen_Combined, PoisonedBleeds;
local PriorityRotation;

-- Master Assassin Remains Check
local MasterAssassinBuff, NominalDuration = 256735, 3;
local function MasterAssassinRemains()
    if Unit("player"):HasBuffs(MasterAssassinBuff, true) < 0 then
        return A.GetCurrentGCD() + NominalDuration;
    else
        return Unit("player"):HasBuffs(MasterAssassinBuff, true);
    end
end

function Poisoned (unit)
    return (Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) or Unit(unit):HasDeBuffs(A.WoundPoisonDebuff.ID, true)) and true or false;
end

function Bleeds (unit)
    return (Unit(unit):HasDeBuffs(A.Garrote.ID, true) and 1 or 0) + (Unit(unit):HasDeBuffs(A.Rupture.ID, true) and 1 or 0)
    + (Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) and 1 or 0) + (Unit(unit):HasDeBuffs(A.InternalBleeding.ID, true) and 1 or 0);
end
  
local PoisonedBleedsCount = 0;
function PoisonedBleeds ()
    PoisonedBleedsCount = 0;
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Garrote.ID) -- Garrote count
 	local AppliedInternalBleeding = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.InternalBleeding.ID) -- InternalBleeding count
 	local AppliedRupture = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Rupture.ID) -- Rupture count
	
	PoisonedBleedsCount = AppliedGarrote + AppliedInternalBleeding + AppliedRupture
	
    return PoisonedBleedsCount;
end
	
---------------------------------------------------
------- SIMC CUSTOM FUNCTION / EXPRESSION ---------
---------------------------------------------------

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Unit("player"):ComboPoints(), CPMaxSpend());
end

-- Spells Damage
A.Envenom:RegisterDamage(
-- Envenom DMG Formula:
--    AP * CP * Env_APCoef * Aura_M * ToxicB_M * DS_M * Mastery_M * Versa_M
function ()
    return
        -- Attack Power
        Player:AttackPower() *
        -- Combo Points
        CPSpend() *
        -- Envenom AP Coef
        0.16 *
        -- Aura Multiplier (SpellID: 137037)
        1.27 *
        -- Toxic Blade Multiplier
        (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and 1.3 or 1) *
        -- Deeper Stratagem Multiplier
        (A.DeeperStratagem:IsSpellLearned() and 1.05 or 1) *
        -- Mastery Finisher Multiplier
        (1 + Player:MasteryPct()/100) *
        -- Versatility Damage Multiplier
        (1 + Player:VersatilityDmgPct()/100);
    end
);
A.Mutilate:RegisterDamage(
    function ()
        return
            -- Attack Power (MH Factor + OH Factor)
            Player:AttackPower() *
            -- Mutilate Coefficient
            0.35 *
            -- Aura Multiplier (SpellID: 137037)
            1.27 *
            -- Versatility Damage Multiplier
            (1 + Player:VersatilityDmgPct()/100);
    end
);
local function NighstalkerMultiplier ()
    return A.Nightstalker:IsSpellLearned() and Unit("player"):IsStealthed() and 1.5 or 1;
end
local function SubterfugeGarroteMultiplier ()
    return A.Subterfuge:IsSpellLearned() and Unit("player"):IsStealthed() and 2 or 1;
end

RegisterPMultiplier( -- Garrote dot and action
	A.Garrote.ID,    -- Garrote action
	A.GarroteDebuff.ID,  -- GarroteDebuff dot

    {NighstalkerMultiplier},
    {SubterfugeGarroteMultiplier}
)

RegisterPMultiplier( -- Rupture dot and action
	A.Rupture.ID,    -- Rupture action
	A.RuptureDebuff.ID,  -- RuptureDebuff dot

    {NighstalkerMultiplier}
)

-- Spell ID Changes check
Stealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth; -- w/ or w/o Subterfuge Talent

-- Stealth
function Stealth(Stealth, Setting)
    if Action.GetToggle(2, "StealthOOC") and Stealth:IsReady("player") and not Unit("player"):IsStealthed() then
        return Stealth:Show(icon)
    end
    return false;
end

---------------------------------------------------
------------------- DEFENSIVES --------------------
---------------------------------------------------

-- Crimson Vial
function CrimsonVial(CrimsonVial)
    if A.CrimsonVial:IsReady(unit) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "CrimsonVialHP") then
        return A.CrimsonVial:Show(icon)
    end
    return false;
end

-- Feint
function Feint(Feint)
    if A.Feint:IsReady(unit) and not Unit("player"):HasBuffs(A.Feint.ID, true) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "FeintHP") then
        return A.Feint:Show(icon)
    end
end

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax()
		
    if ActionUnit("player"):CombatTime() == 0 then 
        return 
    end 

    -- Emergency Evade
    local Evade = Action.GetToggle(2, "EvadeHP")
    if     Evade >= 0 and A.Evade:IsReady("player") and 
    (
        (   -- Auto 
            Evade >= 100 and 
            (
                -- HP lose per sec >= 20
                ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                -- TTD 
                ActionUnit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        ActionUnit("player"):UseDeff() or 
                        (
                            ActionUnit("player", 5):HasFlags() and 
                            ActionUnit("player"):GetRealTimeDMG() > 0 and 
                            ActionUnit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Evade < 100 and 
            ActionUnit("player"):HealthPercent() <= Evade
        )
    ) 
    then 
        return A.Evade:Show(icon)Cast Evade (Defensives)"; end
    end  
		
    -- Emergency Feint
        local Feint = Action.GetToggle(2, "FeintHP")
        if     Feint >= 0 and A.Feint:IsReady("player") and 
        (
            (   -- Auto 
                Feint >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Feint < 100 and 
                ActionUnit("player"):HealthPercent() <= Feint
            )
        ) 
        then 
            return A.Feint:Show(icon)Cast Evade (Defensives)"; end
        end  		

        -- Emergency CrimsonVial
        local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
        if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
        (
            (   -- Auto 
                CrimsonVial >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CrimsonVial < 100 and 
                ActionUnit("player"):HealthPercent() <= CrimsonVial
            )
        ) 
        then 
            return A.CrimsonVial:Show(icon)Cast Evade (Defensives)"; end
        end  		

        -- Emergency Cloak of Shadow
        local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
        if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
        (
            (   -- Auto 
                CloakofShadow >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CloakofShadow < 100 and 
                ActionUnit("player"):HealthPercent() <= CloakofShadow
            )
        ) 
        then 
            return A.CloakofShadow:Show(icon)Cast Evade (Defensives)"; end
        end 
		
        -- Emergency Vanish
        local Vanish = Action.GetToggle(2, "VanishDefensive")
        if     Vanish >= 0 and A.Vanish:IsReady("player") and 
        (
            (   -- Auto 
                Vanish >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Vanish < 100 and 
                ActionUnit("player"):HealthPercent() <= Vanish
            )
        ) 
    then 
        return A.Vanish:Show(icon)
    end  

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function RefreshPoisons()
    local choice = Action.GetToggle(2, "PoisonToUse")
	
	if A.CripplingPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.CripplingPoison) <= 10 or not Unit("player"):BuffP(A.CripplingPoison)) and not Unit("player"):PrevGCDP(1, A.CripplingPoison) and not Unit("player"):IsCasting() then
	    return A.CripplingPoison:Show(icon)
	end	
	-- Wound Poison
	if choice == "Wound Poison" then 
	    if A.WoundPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.WoundPoison) <= 10 or not Unit("player"):BuffP(A.WoundPoison)) and not Unit("player"):PrevGCDP(1, A.WoundPoison) and not Unit("player"):IsCasting() then 
		    return A.WoundPoison:Show(icon)
        end
	-- Deadly Poison
	elseif choice == "Deadly Poison" then
	    if A.DeadlyPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.DeadlyPoison) <= 10 or not Unit("player"):BuffP(A.DeadlyPoison)) and not Unit("player"):PrevGCDP(1, A.DeadlyPoison) and not Unit("player"):IsCasting() then 
		    return A.DeadlyPoison:Show(icon)
        end
	elseif choice == "Auto" then
	    -- Auto
	    if Action.IsInPvP and A.WoundPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.WoundPoison) <= 10 or not Unit("player"):BuffP(A.WoundPoison)) and not Unit("player"):PrevGCDP(1, A.WoundPoison) and not Unit("player"):IsCasting() then 		
	        return A.WoundPoison:Show(icon)
		else
		    if A.DeadlyPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.DeadlyPoison) <= 10 or not Unit("player"):BuffP(A.DeadlyPoison)) and not Action.IsInPvP and not Unit("player"):PrevGCDP(1, A.DeadlyPoison) and not Unit("player"):IsCasting() then
		        return A.DeadlyPoison:Show(icon)
		    end
	    end
	else
	    return
	end	
end
	
-- Check if the Priority Rotation variable should be set
local function UsePriorityRotation()
    if Cache.EnemiesCount[10] < 2 then
        return false
    end
    if Action.GetToggle(2, "UsePriorityRotation") == "Always" then
        return true
    end
    if Action.GetToggle(2, "UsePriorityRotation") == "On Bosses" and Unit(unit):IsInBossList() then
        return true
    end
    -- Zul Mythic
    if Unit("player"):InstanceDifficulty() == 16 and Unit(unit):NPCID() == 138967 then
        return true
    end
    return false
end

-- Fake ss_buffed (wonky without Subterfuge but why would you, eh?)
local function SSBuffed(unit)
    return A.ShroudedSuffocation:GetAzeriteRank() > 0
end

-- non_ss_buffed_targets
local function NonSSBuffedTargets()
    local count = 0;
    
	local MissingGarrote = MultiUnits:GetByRangeMissedDoTs(10, 5, A.Garrote.ID)   
	
	count = MissingGarrote
	
    return count;
end

-- ss_buffed_targets_above_pandemic
local function SSBuffedTargetsAbovePandemic()
    local count = 0;
    local GarroteToRefresh = MultiUnits:GetByRangeDoTsToRefresh(10, 5, A.Garrote.ID, 5.4)
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(10, 5, A.Garrote.ID) -- Garrote count

    count = AppliedGarrote - GarroteToRefresh

    return count;
end


local function EvaluateTargetIfFilterMarkedForDeath31(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath36(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() * 1.5 or Player:ComboPointsDeficit() >= CPMaxSpend())
end


local function EvaluateCycleFanofKnives282(unit)
    return (not Unit(unit):HasDeBuffs(A.DeadlyPoisonDotDebuff.ID, true)) and (bool(VarUseFiller) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3)
end

local function EvaluateCycleMutilate303(unit)
    return (not Unit(unit):HasDeBuffs(A.DeadlyPoisonDotDebuff.ID, true)) and (bool(VarUseFiller) and MultiUnits:GetByRangeInCombat(10, 5, 10) == 2)
end

local function EvaluateCycleGarrote420(unit)
  return not bool(VarSkipCycleGarrote) and Unit(unit) ~= self.target and (not A.Subterfuge:IsSpellLearned() or not (A.Vanish:GetCooldown() == 0 and A.Vendetta:GetCooldown() <= 4)) and Player:ComboPointsDeficit() >= 1 + 3 * num((bool(A.ShroudedSuffocation:GetAzeriteRank()) and A.Vanish:GetCooldown() == 0)) and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and (A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not A.Exsanguinated(Unit(unit), "Garrote") or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and not bool(ss_buffed) and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)) > 12 and (MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and bool(A.ShroudedSuffocation:GetAzeriteRank()))
end

local function EvaluateCycleRupture567(unit)
  return not bool(VarSkipCycleRupture) and not bool(VarSkipRupture) and Unit(unit) ~= self.target and Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) and (A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not A.Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4
end

local function EvaluateTargetIfFilterGarrote721(unit)
  return Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)
end

local function EvaluateTargetIfGarrote756(unit)
  return A.Subterfuge:IsSpellLearned() and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 12 or A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 2
end


local function EvaluateTargetIfFilterGarrote774(unit)
  return Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)
end

local function EvaluateTargetIfGarrote805(unit)
  return A.Subterfuge:IsSpellLearned() and bool(A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):TimeToDie() > Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 18 or not bool(ss_buffed))
end


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
        local Precombat, Cds, Direct, Dot, Essences, Stealthed
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>15
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 15) then
                return A.MarkedForDeath:Show(icon)
            end
            -- apply_poison
            if A.ApplyPoison:IsReady(unit) then
                return A.ApplyPoison:Show(icon)
            end
            -- stealth
            if A.Stealth:IsReady(unit) then
                return A.Stealth:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- use_item,name=azsharas_font_of_power,if=!stealthed.all&master_assassin_remains=0&(cooldown.vendetta.remains<?(cooldown.toxic_blade.remains*equipped.ashvanes_razor_coral))<10+10*equipped.ashvanes_razor_coral&!debuff.vendetta.up&!debuff.toxic_blade.up
            if A.AzsharasFontofPower:IsReady(unit) and (not Unit("player"):IsStealthed(true, true) and MasterAssassinRemains == 0 and num((A.Vendetta:GetCooldown() < ?{})) < 10 + 10 * num(A.AshvanesRazorCoral:IsExists()) and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and not Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true)) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
            if (not Unit("player"):IsStealthed(true, true) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and MasterAssassinRemains == 0) then
                local ShouldReturn = Essences(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit*1.5|combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath31, EvaluateTargetIfMarkedForDeath36) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 30 - raid_event.adds.duration and Player:ComboPointsDeficit() >= CPMaxSpend()) then
                return A.MarkedForDeath:Show(icon)
            end
            -- variable,name=vendetta_subterfuge_condition,value=!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1&(spell_targets.fan_of_knives<6|!cooldown.vanish.up)
            if (true) then
                VarVendettaSubterfugeCondition = num(not A.Subterfuge:IsSpellLearned() or not bool(A.ShroudedSuffocation:GetAzeriteRank()) or A.PMultiplier(unit, A.GarroteDebuff.ID) > 1 and (MultiUnits:GetByRangeInCombat(10, 5, 10) < 6 or not A.Vanish:GetCooldown() == 0))
            end
            -- variable,name=vendetta_nightstalker_condition,value=!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled
            if (true) then
                VarVendettaNightstalkerCondition = num(not A.Nightstalker:IsSpellLearned() or not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() < 5 - 2 * num(A.DeeperStratagem:IsSpellLearned()))
            end
            -- variable,name=variable,name=vendetta_font_condition,value=!equipped.azsharas_font_of_power|azerite.shrouded_suffocation.enabled|debuff.razor_coral_debuff.down|trinket.ashvanes_razor_coral.cooldown.remains<10&(cooldown.toxic_blade.remains<1|debuff.toxic_blade.up)
            if (true) then
                VarVendettaFontCondition = num(not A.AzsharasFontofPower:IsExists() or bool(A.ShroudedSuffocation:GetAzeriteRank()) or bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or trinket.ashvanes_razor_coral.cooldown.remains < 10 and (A.ToxicBlade:GetCooldown() < 1 or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true)))
            end
            -- vendetta,if=!stealthed.rogue&dot.rupture.ticking&!debuff.vendetta.up&variable.vendetta_subterfuge_condition&variable.vendetta_nightstalker_condition&variable.vendetta_font_condition
            if A.Vendetta:IsReady(unit) and (not Unit("player"):IsStealthed(true, false) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and bool(VarVendettaSubterfugeCondition) and bool(VarVendettaNightstalkerCondition) and bool(VarVendettaFontCondition)) then
                return A.Vendetta:Show(icon)
            end
            -- vanish,if=talent.exsanguinate.enabled&(talent.nightstalker.enabled|talent.subterfuge.enabled&variable.single_target)&combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1&(!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier<=1)
            if A.Vanish:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and (A.Nightstalker:IsSpellLearned() or A.Subterfuge:IsSpellLearned() and bool(VarSingleUnit(unit))) and Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1 and (not A.Subterfuge:IsSpellLearned() or not bool(A.ShroudedSuffocation:GetAzeriteRank()) or A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1)) then
                return A.Vanish:Show(icon)
            end
            -- vanish,if=talent.nightstalker.enabled&!talent.exsanguinate.enabled&combo_points>=cp_max_spend&(debuff.vendetta.up|essence.vision_of_perfection.enabled)
            if A.Vanish:IsReady(unit) and (A.Nightstalker:IsSpellLearned() and not A.Exsanguinate:IsSpellLearned() and Player:ComboPoints() >= CPMaxSpend() and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or bool(A.VisionofPerfection:IsSpellLearned()))) then
                return A.Vanish:Show(icon)
            end
            -- variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_ss_buffed_targets>=1|spell_targets.fan_of_knives=3)&(ss_buffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
            if (true) then
                VarSsVanishCondition = num(bool(A.ShroudedSuffocation:GetAzeriteRank()) and (non_ss_buffed_targets >= 1 or MultiUnits:GetByRangeInCombat(10, 5, 10) == 3) and (ss_buffed_targets_above_pandemic == 0 or MultiUnits:GetByRangeInCombat(10, 5, 10) >= 6))
            end
            -- pool_resource,for_next=1,extra_amount=45
            -- vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&(dot.garrote.refreshable|debuff.vendetta.up&dot.garrote.pmultiplier<=1))&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
            if A.Vanish:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and not Unit("player"):IsStealthed(true, false) and A.Garrote:GetCooldown() == 0 and (bool(VarSsVanishCondition) or not bool(A.ShroudedSuffocation:GetAzeriteRank()) and (Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1)) and Player:ComboPointsDeficit() >= num(((1 + 2 * A.ShroudedSuffocation:GetAzeriteRank()) * MultiUnits:GetByRangeInCombat(10, 5, 10)) > ?4) and 10000000000 > 12) then
                if A.Vanish:IsUsablePPool(45) then
                    return A.Vanish:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- vanish,if=talent.master_assassin.enabled&!stealthed.all&master_assassin_remains<=0&!dot.rupture.refreshable&dot.garrote.remains>3&(debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up)&(!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up)|essence.vision_of_perfection.enabled)
            if A.Vanish:IsReady(unit) and (A.MasterAssassin:IsSpellLearned() and not Unit("player"):IsStealthed(true, true) and MasterAssassinRemains <= 0 and not Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 3 and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (not A.ToxicBlade:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true)) and (not bool(Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID)) or Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true)) or bool(A.VisionofPerfection:IsSpellLearned()))) then
                return A.Vanish:Show(icon)
            end
            -- shadowmeld,if=!stealthed.all&azerite.shrouded_suffocation.enabled&dot.garrote.refreshable&dot.garrote.pmultiplier<=1&combo_points.deficit>=1
            if A.Shadowmeld:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not Unit("player"):IsStealthed(true, true) and bool(A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 and Player:ComboPointsDeficit() >= 1) then
                return A.Shadowmeld:Show(icon)
            end
            -- exsanguinate,if=dot.rupture.remains>4+4*cp_max_spend&!dot.garrote.refreshable
            if A.Exsanguinate:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4 + 4 * CPMaxSpend() and not Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true)) then
                return A.Exsanguinate:Show(icon)
            end
            -- toxic_blade,if=dot.rupture.ticking&(!equipped.azsharas_font_of_power|cooldown.vendetta.remains>10)
            if A.ToxicBlade:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and (not A.AzsharasFontofPower:IsExists() or A.Vendetta:GetCooldown() > 10)) then
                return A.ToxicBlade:Show(icon)
            end
            -- potion,if=buff.bloodlust.react|debuff.vendetta.up
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism() or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                A.ProlongedPower:Show(icon)
            end
            -- blood_fury,if=debuff.vendetta.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=debuff.vendetta.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=debuff.vendetta.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=debuff.vendetta.up
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            -- use_item,name=galecallers_boon,if=cooldown.vendetta.remains>45
            if A.GalecallersBoon:IsReady(unit) and (A.Vendetta:GetCooldown() > 45) then
                A.GalecallersBoon:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.vendetta.remains>10-4*equipped.azsharas_font_of_power|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) > 10 - 4 * num(A.AzsharasFontofPower:IsExists()) or Unit(unit):TimeToDie() < 20) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=master_assassin_remains=0&!debuff.vendetta.up&!debuff.toxic_blade.up&buff.memory_of_lucid_dreams.down&energy<80&dot.rupture.remains>4
            if A.CyclotronicBlast:IsReady(unit) and (MasterAssassinRemains == 0 and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and not Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) and Player:EnergyPredicted() < 80 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4) then
                A.CyclotronicBlast:Show(icon)
            end
            -- use_item,name=lurkers_insidious_gift,if=debuff.vendetta.up
            if A.LurkersInsidiousGift:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                A.LurkersInsidiousGift:Show(icon)
            end
            -- use_item,name=lustrous_golden_plumage,if=debuff.vendetta.up
            if A.LustrousGoldenPlumage:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                A.LustrousGoldenPlumage:Show(icon)
            end
            -- use_item,effect_name=gladiators_medallion,if=debuff.vendetta.up
            if A.GladiatorsMedallion:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                A.GladiatorsMedallion:Show(icon)
            end
            -- use_item,effect_name=gladiators_badge,if=debuff.vendetta.up
            if A.GladiatorsBadge:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                A.GladiatorsBadge:Show(icon)
            end
            -- use_items
        end
        
        --Direct
        local function Direct(unit)
            -- envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target)&(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)
            if A.Envenom:IsReady(unit) and (Player:ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not bool(VarSingleUnit(unit))) and (not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() > 2)) then
                return A.Envenom:Show(icon)
            end
            -- variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target
            if (true) then
                VarUseFiller = num(Player:ComboPointsDeficit() > 1 or Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not bool(VarSingleUnit(unit)))
            end
            -- fan_of_knives,if=variable.use_filler&azerite.echoing_blades.enabled&spell_targets.fan_of_knives>=2+(debuff.vendetta.up*(1+(azerite.echoing_blades.rank=1)))
            if A.FanofKnives:IsReady(unit) and (bool(VarUseFiller) and bool(A.EchoingBlades:GetAzeriteRank()) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 + (num(Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) * (1 + num((A.EchoingBlades:GetAzeriteRank() == 1))))) then
                return A.FanofKnives:Show(icon)
            end
            -- fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|(!priority_rotation&spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue))
            if A.FanofKnives:IsReady(unit) and (bool(VarUseFiller) and (Unit("player"):HasBuffsStacks(A.HiddenBladesBuff.ID, true) >= 19 or (not bool(priority_rotation) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 4 + num((A.DoubleDose:GetAzeriteRank() > 2)) + num(Unit("player"):IsStealthed(true, false))))) then
                return A.FanofKnives:Show(icon)
            end
            -- fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3
            if A.FanofKnives:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FanofKnives, 10, "min", EvaluateCycleFanofKnives282) then
                    return A.FanofKnives:Show(icon) 
                end
            end
            -- blindside,if=variable.use_filler&(buff.blindside.up|!talent.venom_rush.enabled&!azerite.double_dose.enabled)
            if A.Blindside:IsReady(unit) and (bool(VarUseFiller) and (Unit("player"):HasBuffs(A.BlindsideBuff.ID, true) or not A.VenomRush:IsSpellLearned() and not bool(A.DoubleDose:GetAzeriteRank()))) then
                return A.Blindside:Show(icon)
            end
            -- mutilate,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives=2
            if A.Mutilate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Mutilate, 40, "min", EvaluateCycleMutilate303) then
                    return A.Mutilate:Show(icon) 
                end
            end
            -- mutilate,if=variable.use_filler
            if A.Mutilate:IsReady(unit) and (bool(VarUseFiller)) then
                return A.Mutilate:Show(icon)
            end
        end
        
        --Dot
        local function Dot(unit)
            -- variable,name=skip_cycle_garrote,value=priority_rotation&spell_targets.fan_of_knives>3&(dot.garrote.remains<cooldown.garrote.duration|poisoned_bleeds>5)
            if (true) then
                VarSkipCycleGarrote = num(bool(priority_rotation) and MultiUnits:GetByRangeInCombat(10, 5, 10) > 3 and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < A.Garrote:BaseDuration() or PoisonedBleeds() > 5))
            end
            -- variable,name=skip_cycle_rupture,value=priority_rotation&spell_targets.fan_of_knives>3&(debuff.toxic_blade.up|(poisoned_bleeds>5&!azerite.scent_of_blood.enabled))
            if (true) then
                VarSkipCycleRupture = num(bool(priority_rotation) and MultiUnits:GetByRangeInCombat(10, 5, 10) > 3 and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or (PoisonedBleeds() > 5 and not bool(A.ScentofBlood:GetAzeriteRank()))))
            end
            -- variable,name=skip_rupture,value=debuff.vendetta.up&(debuff.toxic_blade.up|master_assassin_remains>0)&dot.rupture.remains>2
            if (true) then
                VarSkipRupture = num(Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or MasterAssassinRemains > 0) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 2)
            end
            -- rupture,if=talent.exsanguinate.enabled&((combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1)|(!ticking&(time>10|combo_points>=2)))
            if A.Rupture:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and ((Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1) or (not Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and (Unit("player"):CombatTime() > 10 or Player:ComboPoints() >= 2)))) then
                return A.Rupture:Show(icon)
            end
            -- pool_resource,for_next=1
            -- garrote,if=(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>4&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) and ((not A.Subterfuge:IsSpellLearned() or not (A.Vanish:GetCooldown() == 0 and A.Vendetta:GetCooldown() <= 4)) and Player:ComboPointsDeficit() >= 1 + 3 * num((bool(A.ShroudedSuffocation:GetAzeriteRank()) and A.Vanish:GetCooldown() == 0)) and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and (A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not A.Exsanguinated(Unit(unit), "Garrote") or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and not bool(ss_buffed) and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)) > 4 and (MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and bool(A.ShroudedSuffocation:GetAzeriteRank()))) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- garrote,cycle_targets=1,if=!variable.skip_cycle_garrote&target!=self.target&(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>12&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateCycleGarrote420) then
                    return A.Garrote:Show(icon) 
                end
            end
            -- crimson_tempest,if=spell_targets>=2&remains<2+(spell_targets>=5)&combo_points>=4
            if A.CrimsonTempest:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and Unit("player"):HasBuffs(A.CrimsonTempestBuff.ID, true) < 2 + num((MultiUnits:GetByRangeInCombat(40, 5, 10) >= 5)) and Player:ComboPoints() >= 4) then
                return A.CrimsonTempest:Show(icon)
            end
            -- rupture,if=!variable.skip_rupture&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
            if A.Rupture:IsReady(unit) and (not bool(VarSkipRupture) and Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) and (A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not A.Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4) then
                return A.Rupture:Show(icon)
            end
            -- rupture,cycle_targets=1,if=!variable.skip_cycle_rupture&!variable.skip_rupture&target!=self.target&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
            if A.Rupture:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rupture, 5, "min", EvaluateCycleRupture567) then
                    return A.Rupture:Show(icon) 
                end
            end
        end
        
        --Essences
        local function Essences(unit)
            -- concentrated_flame,if=energy.time_to_max>1&!debuff.vendetta.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyTimeToMaxPredicted() > 1 and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- blood_of_the_enemy,if=debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up&combo_points.deficit<=1|debuff.vendetta.remains<=10)|target.time_to_die<=10
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (not A.ToxicBlade:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and Player:ComboPointsDeficit() <= 1 or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) <= 10) or Unit(unit):TimeToDie() <= 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- guardian_of_azeroth,if=cooldown.vendetta.remains<3|debuff.vendetta.up|target.time_to_die<30
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.Vendetta:GetCooldown() < 3 or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or Unit(unit):TimeToDie() < 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- guardian_of_azeroth,if=floor((target.time_to_die-30)%cooldown)>floor((target.time_to_die-30-cooldown.vendetta.remains)%cooldown)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (math.floor ((Unit(unit):TimeToDie() - 30) / cooldown) > math.floor ((Unit(unit):TimeToDie() - 30 - A.Vendetta:GetCooldown()) / cooldown)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- focused_azerite_beam,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60&energy<70
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 or 10000000000 > 60 and Player:EnergyPredicted() < 70) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 or 10000000000 > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
            -- memory_of_lucid_dreams,if=energy<50&!cooldown.vendetta.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyPredicted() < 50 and not A.Vendetta:GetCooldown() == 0) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
            if A.ReapingFlames:IsReady(unit) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or target.time_to_pct_20 > 30) then
                return A.ReapingFlames:Show(icon)
            end
        end
        
        --Stealthed
        local function Stealthed(unit)
            -- rupture,if=combo_points>=4&(talent.nightstalker.enabled|talent.subterfuge.enabled&(talent.exsanguinate.enabled&cooldown.exsanguinate.remains<=2|!ticking)&variable.single_target)&target.time_to_die-remains>6
            if A.Rupture:IsReady(unit) and (Player:ComboPoints() >= 4 and (A.Nightstalker:IsSpellLearned() or A.Subterfuge:IsSpellLearned() and (A.Exsanguinate:IsSpellLearned() and A.Exsanguinate:GetCooldown() <= 2 or not Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true)) and bool(VarSingleUnit(unit))) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 6) then
                return A.Rupture:Show(icon)
            end
            -- pool_resource,for_next=1
            -- garrote,if=azerite.shrouded_suffocation.enabled&buff.subterfuge.up&buff.subterfuge.remains<1.3&!ss_buffed
            if A.Garrote:IsReady(unit) and (bool(A.ShroudedSuffocation:GetAzeriteRank()) and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) < 1.3 and not bool(ss_buffed)) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&(remains<12|pmultiplier<=1)&target.time_to_die-remains>2
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateTargetIfFilterGarrote721, EvaluateTargetIfGarrote756) then 
                    return A.Garrote:Show(icon) 
                end
            end
            -- rupture,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&!dot.rupture.ticking&variable.single_target
            if A.Rupture:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and bool(A.ShroudedSuffocation:GetAzeriteRank()) and not Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and bool(VarSingleUnit(unit))) then
                return A.Rupture:Show(icon)
            end
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&target.time_to_die>remains&(remains<18|!ss_buffed)
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateTargetIfFilterGarrote774, EvaluateTargetIfGarrote805) then 
                    return A.Garrote:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- garrote,if=talent.subterfuge.enabled&talent.exsanguinate.enabled&cooldown.exsanguinate.remains<1&prev_gcd.1.rupture&dot.rupture.remains>5+4*cp_max_spend
            if A.Garrote:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.Exsanguinate:IsSpellLearned() and A.Exsanguinate:GetCooldown() < 1 and Unit("player"):GetSpellLastCast(A.Rupture) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 5 + 4 * CPMaxSpend()) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- stealth
            if A.Stealth:IsReady(unit) then
                return A.Stealth:Show(icon)
            end
            -- variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*7%(2*spell_haste)
            if (true) then
                VarEnergyRegenCombined = Player:EnergyRegen() + PoisonedBleeds() * 7 / (2 * Player:SpellHaste())
            end
            -- variable,name=single_target,value=spell_targets.fan_of_knives<2
            if (true) then
                VarSingleUnit(unit) = num(MultiUnits:GetByRangeInCombat(10, 5, 10) < 2)
            end
            -- call_action_list,name=stealthed,if=stealthed.rogue
            if (Unit("player"):IsStealthed(true, false)) then
                local ShouldReturn = Stealthed(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)
            if ((not A.MasterAssassin:IsSpellLearned() or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true))) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=dot
            if (true) then
                local ShouldReturn = Dot(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=direct
            if (true) then
                local ShouldReturn = Direct(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- arcane_torrent,if=energy.deficit>=15+variable.energy_regen_combined
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:EnergyDeficitPredicted() >= 15 + VarEnergyRegenCombined) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- arcane_pulse
            if A.ArcanePulse:AutoRacial(unit) and Action.GetToggle(1, "Racial") then
                return A.ArcanePulse:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
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

