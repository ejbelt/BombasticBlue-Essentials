class BBAmulet

    attr_reader   :registered_items
    attr_reader   :setup_slot
    attr_reader   :effect_slot
    attr_reader   :ability_slot

    def initialize

    end

    def equip_charm(charm, slot)
        case slot
            when 1
                if (unequip_charm(@effect_slot, 1) > 0)
                    @effect_slot = charm
                end
            when 2
                if (unequip_charm(@ability_slot, 2) > 0)
                    @ability_slot = charm
                end
            else
                if (unequip_charm(@setup_slot, 0) > 0)
                    @setup_slot = charm
                end
        end
    end

    def unequip_charm(charm, slot)
        case slot
            when 1
                @effect_slot = nil
            when 2
                @ability_slot = nil
            else
                @setup_slot = nil
        end
    end

    def get_available_charms(bag)

    end

end