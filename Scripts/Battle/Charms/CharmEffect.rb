module Battle::BombasticBlue::CharmEffect
    SpeedCalc                        = CharmHandlerHash.new
    WeightCalc                       = CharmHandlerHash.new
    # Battler's HP/stat changed
    OnHPDroppedBelowHalf             = CharmHandlerHash.new
    # Battler's status problem
    StatusCheckNonIgnorable          = CharmHandlerHash.new 
    StatusImmunity                   = CharmHandlerHash.new
    StatusImmunityNonIgnorable       = CharmHandlerHash.new
    StatusImmunityFromAlly           = CharmHandlerHash.new
    OnStatusInflicted                = CharmHandlerHash.new 
    StatusCure                       = CharmHandlerHash.new
    # Battler's stat stages
    StatLossImmunity                 = CharmHandlerHash.new
    StatLossImmunityNonIgnorable     = CharmHandlerHash.new  
    StatLossImmunityFromAlly         = CharmHandlerHash.new
    OnStatGain                       = CharmHandlerHash.new 
    OnStatLoss                       = CharmHandlerHash.new
    # Priority and turn order
    PriorityChange                   = CharmHandlerHash.new
    PriorityBracketChange            = CharmHandlerHash.new 
    PriorityBracketUse               = CharmHandlerHash.new
    # Move usage failures
    OnFlinch                         = CharmHandlerHash.new
    MoveBlocking                     = CharmHandlerHash.new
    MoveImmunity                     = CharmHandlerHash.new
    # Move usage
    ModifyMoveBaseType               = CharmHandlerHash.new
    # Accuracy calculation
    AccuracyCalcFromUser             = CharmHandlerHash.new
    AccuracyCalcFromAlly             = CharmHandlerHash.new
    AccuracyCalcFromTarget           = CharmHandlerHash.new
    # Damage calculation
    DamageCalcFromUser               = CharmHandlerHash.new
    DamageCalcFromAlly               = CharmHandlerHash.new
    DamageCalcFromTarget             = CharmHandlerHash.new
    DamageCalcFromTargetNonIgnorable = CharmHandlerHash.new
    DamageCalcFromTargetAlly         = CharmHandlerHash.new
    CriticalCalcFromUser             = CharmHandlerHash.new
    CriticalCalcFromTarget           = CharmHandlerHash.new
    # Upon a move hitting a target
    OnBeingHit                       = CharmHandlerHash.new
    OnDealingHit                     = CharmHandlerHash.new
    # Abilities that trigger at the end of using a move
    OnEndOfUsingMove                 = CharmHandlerHash.new
    AfterMoveUseFromTarget           = CharmHandlerHash.new
    # End Of Round
    EndOfRoundWeather                = CharmHandlerHash.new
    EndOfRoundHealing                = CharmHandlerHash.new
    EndOfRoundEffect                 = CharmHandlerHash.new
    EndOfRoundGainCharm              = CharmHandlerHash.new
    # Switching and fainting
    CertainSwitching                 = CharmHandlerHash.new 
    TrappingByTarget                 = CharmHandlerHash.new
    OnSwitchIn                       = CharmHandlerHash.new
    OnSwitchOut                      = CharmHandlerHash.new
    ChangeOnBattlerFainting          = CharmHandlerHash.new
    OnBattlerFainting                = CharmHandlerHash.new
    OnTerrainChange                  = CharmHandlerHash.new
    OnIntimidated                    = CharmHandlerHash.new
    # Running from battle
    CertainEscapeFromBattle          = CharmHandlerHash.new 

    SpeedCalc                       = CharmHandlerHash.new
    WeightCalc                      = CharmHandlerHash.new 
    # Battler's HP/stat changed
    HPHeal                          = CharmHandlerHash.new
    OnStatLoss                      = CharmHandlerHash.new
    # Battler's status problem
    StatusCure                      = CharmHandlerHash.new
    # Priority and turn order
    PriorityBracketChange           = CharmHandlerHash.new
    PriorityBracketUse              = CharmHandlerHash.new
    # Move usage failures
    OnMissingTarget                 = CharmHandlerHash.new 
    # Accuracy calculation
    AccuracyCalcFromUser            = CharmHandlerHash.new
    AccuracyCalcFromTarget          = CharmHandlerHash.new
    # Damage calculation
    DamageCalcFromUser              = CharmHandlerHash.new
    DamageCalcFromTarget            = CharmHandlerHash.new
    CriticalCalcFromUser            = CharmHandlerHash.new
    CriticalCalcFromTarget          = CharmHandlerHash.new 
    # Upon a move hitting a target
    OnBeingHit                      = CharmHandlerHash.new
    OnBeingHitPositiveBerry         = CharmHandlerHash.new
    # Charms that trigger at the end of using a move
    AfterMoveUseFromTarget          = CharmHandlerHash.new
    AfterMoveUseFromUser            = CharmHandlerHash.new
    OnEndOfUsingMove                = CharmHandlerHash.new
    OnEndOfUsingMoveStatRestore     = CharmHandlerHash.new
    # Experience and EV gain
    ExpGainModifier                 = CharmHandlerHash.new
    EVGainModifier                  = CharmHandlerHash.new
    # Weather and terrin
    WeatherExtender                 = CharmHandlerHash.new
    TerrainExtender                 = CharmHandlerHash.new
    TerrainStatBoost                = CharmHandlerHash.new
    # End Of Round
    EndOfRoundHealing               = CharmHandlerHash.new
    EndOfRoundEffect                = CharmHandlerHash.new
    # Switching and fainting
    CertainSwitching                = CharmHandlerHash.new 
    TrappingByTarget                = CharmHandlerHash.new
    OnSwitchIn                      = CharmHandlerHash.new 
    OnIntimidated                   = CharmHandlerHash.new 
    # Running from battle
    CertainEscapeFromBattle         = CharmHandlerHash.new 

    #=============================================================================

    def self.trigger(hash, *args, ret: false)
        new_ret = hash.trigger(*args)
        return (!new_ret.nil?) ? new_ret : ret
    end

    #=============================================================================

    def self.triggerSpeedCalc(charm, battler, mult)
        return trigger(SpeedCalc, charm, battler, mult, ret: mult)
    end

    def self.triggerWeightCalc(charm, battler, w)
        return trigger(WeightCalc, charm, battler, w, ret: w)
    end

    #=============================================================================

    def self.triggerHPHeal(charm, battler, battle, forced)
        return trigger(HPHeal, charm, battler, battle, forced)
    end

    def self.triggerOnStatLoss(charm, user, move_user, battle)
        return trigger(OnStatLoss, charm, user, move_user, battle)
    end

    #=============================================================================

    def self.triggerStatusCure(charm, battler, battle, forced)
        return trigger(StatusCure, charm, battler, battle, forced)
    end

    #=============================================================================

    def self.triggerPriorityBracketChange(charm, battler, battle)
        return trigger(PriorityBracketChange, charm, battler, battle, ret: 0)
    end

    def self.triggerPriorityBracketUse(charm, battler, battle)
        PriorityBracketUse.trigger(charm, battler, battle)
    end

    #=============================================================================

    def self.triggerOnMissingTarget(charm, user, target, move, hit_num, battle)
        OnMissingTarget.trigger(charm, user, target, move, hit_num, battle)
    end

    #=============================================================================

    def self.triggerAccuracyCalcFromUser(charm, mods, user, target, move, type)
        AccuracyCalcFromUser.trigger(charm, mods, user, target, move, type)
    end

    def self.triggerAccuracyCalcFromTarget(charm, mods, user, target, move, type)
        AccuracyCalcFromTarget.trigger(charm, mods, user, target, move, type)
    end

    #=============================================================================

    def self.triggerDamageCalcFromUser(charm, user, target, move, mults, power, type)
        DamageCalcFromUser.trigger(charm, user, target, move, mults, power, type)
    end

    def self.triggerDamageCalcFromTarget(charm, user, target, move, mults, power, type)
        DamageCalcFromTarget.trigger(charm, user, target, move, mults, power, type)
    end

    def self.triggerCriticalCalcFromUser(charm, user, target, crit_stage)
        return trigger(CriticalCalcFromUser, charm, user, target, crit_stage, ret: crit_stage)
    end

    def self.triggerCriticalCalcFromTarget(charm, user, target, crit_stage)
        return trigger(CriticalCalcFromTarget, charm, user, target, crit_stage, ret: crit_stage)
    end

    #=============================================================================

    def self.triggerOnBeingHit(charm, user, target, move, battle)
        OnBeingHit.trigger(charm, user, target, move, battle)
    end

    def self.triggerOnBeingHitPositiveBerry(charm, battler, battle, forced)
        return trigger(OnBeingHitPositiveBerry, charm, battler, battle, forced)
    end

    #=============================================================================

    def self.triggerAfterMoveUseFromTarget(charm, battler, user, move, switched_battlers, battle)
        AfterMoveUseFromTarget.trigger(charm, battler, user, move, switched_battlers, battle)
    end

    def self.triggerAfterMoveUseFromUser(charm, user, targets, move, num_hits, battle)
        AfterMoveUseFromUser.trigger(charm, user, targets, move, num_hits, battle)
    end

    def self.triggerOnEndOfUsingMove(charm, battler, battle, forced)
        return trigger(OnEndOfUsingMove, charm, battler, battle, forced)
    end

    def self.triggerOnEndOfUsingMoveStatRestore(charm, battler, battle, forced)
        return trigger(OnEndOfUsingMoveStatRestore, charm, battler, battle, forced)
    end

    #=============================================================================

    def self.triggerExpGainModifier(charm, battler, exp)
        return trigger(ExpGainModifier, charm, battler, exp, ret: -1)
    end

    def self.triggerEVGainModifier(charm, battler, ev_array)
        return false if !EVGainModifier[charm]
        EVGainModifier.trigger(charm, battler, ev_array)
        return true
    end

    #=============================================================================

    def self.triggerWeatherExtender(charm, weather, duration, battler, battle)
        return trigger(WeatherExtender, charm, weather, duration, battler, battle, ret: duration)
    end

    def self.triggerTerrainExtender(charm, terrain, duration, battler, battle)
        return trigger(TerrainExtender, charm, terrain, duration, battler, battle, ret: duration)
    end

    def self.triggerTerrainStatBoost(charm, battler, battle)
        return trigger(TerrainStatBoost, charm, battler, battle)
    end

    #=============================================================================

    def self.triggerEndOfRoundHealing(charm, battler, battle)
        EndOfRoundHealing.trigger(charm, battler, battle)
    end

    def self.triggerEndOfRoundEffect(charm, battler, battle)
        EndOfRoundEffect.trigger(charm, battler, battle)
    end

    #=============================================================================

    def self.triggerCertainSwitching(charm, switcher, battle)
        return trigger(CertainSwitching, charm, switcher, battle)
    end

    def self.triggerTrappingByTarget(charm, switcher, bearer, battle)
        return trigger(TrappingByTarget, charm, switcher, bearer, battle)
    end

    def self.triggerOnSwitchIn(charm, battler, battle)
        OnSwitchIn.trigger(charm, battler, battle)
    end

    def self.triggerOnIntimidated(charm, battler, battle)
        return trigger(OnIntimidated, charm, battler, battle)
    end

    #=============================================================================

    def self.triggerCertainEscapeFromBattle(charm, battler)
        return trigger(CertainEscapeFromBattle, charm, battler)
    end
  
    #=============================================================================
  
    def self.triggerSpeedCalc(charm, battler, mult)
      return trigger(SpeedCalc, charm, battler, mult, ret: mult)
    end
  
    def self.triggerWeightCalc(charm, battler, weight)
      return trigger(WeightCalc, charm, battler, weight, ret: weight)
    end
  
    #=============================================================================
  
    def self.triggerOnHPDroppedBelowHalf(charm, user, move_user, battle)
      return trigger(OnHPDroppedBelowHalf, charm, user, move_user, battle)
    end
  
    #=============================================================================
  
    def self.triggerStatusCheckNonIgnorable(charm, battler, status)
      return trigger(StatusCheckNonIgnorable, charm, battler, status)
    end
  
    def self.triggerStatusImmunity(charm, battler, status)
      return trigger(StatusImmunity, charm, battler, status)
    end
  
    def self.triggerStatusImmunityNonIgnorable(charm, battler, status)
      return trigger(StatusImmunityNonIgnorable, charm, battler, status)
    end
  
    def self.triggerStatusImmunityFromAlly(charm, battler, status)
      return trigger(StatusImmunityFromAlly, charm, battler, status)
    end
  
    def self.triggerOnStatusInflicted(charm, battler, user, status)
      OnStatusInflicted.trigger(charm, battler, user, status)
    end
  
    def self.triggerStatusCure(charm, battler)
      return trigger(StatusCure, charm, battler)
    end
  
    #=============================================================================
  
    def self.triggerStatLossImmunity(charm, battler, stat, battle, show_messages)
      return trigger(StatLossImmunity, charm, battler, stat, battle, show_messages)
    end
  
    def self.triggerStatLossImmunityNonIgnorable(charm, battler, stat, battle, show_messages)
      return trigger(StatLossImmunityNonIgnorable, charm, battler, stat, battle, show_messages)
    end
  
    def self.triggerStatLossImmunityFromAlly(charm, bearer, battler, stat, battle, show_messages)
      return trigger(StatLossImmunityFromAlly, charm, bearer, battler, stat, battle, show_messages)
    end
  
    def self.triggerOnStatGain(charm, battler, stat, user)
      OnStatGain.trigger(charm, battler, stat, user)
    end
  
    def self.triggerOnStatLoss(charm, battler, stat, user)
      OnStatLoss.trigger(charm, battler, stat, user)
    end
  
    #=============================================================================
  
    def self.triggerPriorityChange(charm, battler, move, priority)
      return trigger(PriorityChange, charm, battler, move, priority, ret: priority)
    end
  
    def self.triggerPriorityBracketChange(charm, battler, battle)
      return trigger(PriorityBracketChange, charm, battler, battle, ret: 0)
    end
  
    def self.triggerPriorityBracketUse(charm, battler, battle)
      PriorityBracketUse.trigger(charm, battler, battle)
    end
  
    #=============================================================================
  
    def self.triggerOnFlinch(charm, battler, battle)
      OnFlinch.trigger(charm, battler, battle)
    end
  
    def self.triggerMoveBlocking(charm, bearer, user, targets, move, battle)
      return trigger(MoveBlocking, charm, bearer, user, targets, move, battle)
    end
  
    def self.triggerMoveImmunity(charm, user, target, move, type, battle, show_message)
      return trigger(MoveImmunity, charm, user, target, move, type, battle, show_message)
    end
  
    #=============================================================================
  
    def self.triggerModifyMoveBaseType(charm, user, move, type)
      return trigger(ModifyMoveBaseType, charm, user, move, type, ret: type)
    end
  
    #=============================================================================
  
    def self.triggerAccuracyCalcFromUser(charm, mods, user, target, move, type)
      AccuracyCalcFromUser.trigger(charm, mods, user, target, move, type)
    end
  
    def self.triggerAccuracyCalcFromAlly(charm, mods, user, target, move, type)
      AccuracyCalcFromAlly.trigger(charm, mods, user, target, move, type)
    end
  
    def self.triggerAccuracyCalcFromTarget(charm, mods, user, target, move, type)
      AccuracyCalcFromTarget.trigger(charm, mods, user, target, move, type)
    end
  
    #=============================================================================
  
    def self.triggerDamageCalcFromUser(charm, user, target, move, mults, power, type)
      DamageCalcFromUser.trigger(charm, user, target, move, mults, power, type)
    end
  
    def self.triggerDamageCalcFromAlly(charm, user, target, move, mults, power, type)
      DamageCalcFromAlly.trigger(charm, user, target, move, mults, power, type)
    end
  
    def self.triggerDamageCalcFromTarget(charm, user, target, move, mults, power, type)
      DamageCalcFromTarget.trigger(charm, user, target, move, mults, power, type)
    end
  
    def self.triggerDamageCalcFromTargetNonIgnorable(charm, user, target, move, mults, power, type)
      DamageCalcFromTargetNonIgnorable.trigger(charm, user, target, move, mults, power, type)
    end
  
    def self.triggerDamageCalcFromTargetAlly(charm, user, target, move, mults, power, type)
      DamageCalcFromTargetAlly.trigger(charm, user, target, move, mults, power, type)
    end
  
    def self.triggerCriticalCalcFromUser(charm, user, target, crit_stage)
      return trigger(CriticalCalcFromUser, charm, user, target, crit_stage, ret: crit_stage)
    end
  
    def self.triggerCriticalCalcFromTarget(charm, user, target, crit_stage)
      return trigger(CriticalCalcFromTarget, charm, user, target, crit_stage, ret: crit_stage)
    end
  
    #=============================================================================
  
    def self.triggerOnBeingHit(charm, user, target, move, battle)
      OnBeingHit.trigger(charm, user, target, move, battle)
    end
  
    def self.triggerOnDealingHit(charm, user, target, move, battle)
      OnDealingHit.trigger(charm, user, target, move, battle)
    end
  
    #=============================================================================
  
    def self.triggerOnEndOfUsingMove(charm, user, targets, move, battle)
      OnEndOfUsingMove.trigger(charm, user, targets, move, battle)
    end
  
    def self.triggerAfterMoveUseFromTarget(charm, target, user, move, switched_battlers, battle)
      AfterMoveUseFromTarget.trigger(charm, target, user, move, switched_battlers, battle)
    end
  
    #=============================================================================
  
    def self.triggerEndOfRoundWeather(charm, weather, battler, battle)
      EndOfRoundWeather.trigger(charm, weather, battler, battle)
    end
  
    def self.triggerEndOfRoundHealing(charm, battler, battle)
      EndOfRoundHealing.trigger(charm, battler, battle)
    end
  
    def self.triggerEndOfRoundEffect(charm, battler, battle)
      EndOfRoundEffect.trigger(charm, battler, battle)
    end
  
    def self.triggerEndOfRoundGainCharm(charm, battler, battle)
      EndOfRoundGainCharm.trigger(charm, battler, battle)
    end
  
    #=============================================================================
  
    def self.triggerCertainSwitching(charm, switcher, battle)
      return trigger(CertainSwitching, charm, switcher, battle)
    end
  
    def self.triggerTrappingByTarget(charm, switcher, bearer, battle)
      return trigger(TrappingByTarget, charm, switcher, bearer, battle)
    end
  
    def self.triggerOnSwitchIn(charm, battler, battle, switch_in = false)
      OnSwitchIn.trigger(charm, battler, battle, switch_in)
    end
  
    def self.triggerOnSwitchOut(charm, battler, end_of_battle)
      OnSwitchOut.trigger(charm, battler, end_of_battle)
    end
  
    def self.triggerChangeOnBattlerFainting(charm, battler, fainted, battle)
      ChangeOnBattlerFainting.trigger(charm, battler, fainted, battle)
    end
  
    def self.triggerOnBattlerFainting(charm, battler, fainted, battle)
      OnBattlerFainting.trigger(charm, battler, fainted, battle)
    end
  
    def self.triggerOnTerrainChange(charm, battler, battle, charm_changed)
      OnTerrainChange.trigger(charm, battler, battle, charm_changed)
    end
  
    def self.triggerOnIntimidated(charm, battler, battle)
      OnIntimidated.trigger(charm, battler, battle)
    end
  
    #=============================================================================
  
    def self.triggerCertainEscapeFromBattle(charm, battler)
      return trigger(CertainEscapeFromBattle, charm, battler)
    end
  end