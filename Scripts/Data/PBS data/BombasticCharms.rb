module GameData

  #TODO: Work on this. High priority.
    class Charm
      attr_reader :id
      attr_reader :real_name
      attr_reader :socket
      attr_reader :show_quantity
      attr_reader :field_use
      attr_reader :battle_use
      attr_reader :accuracy
      attr_reader :total_uses
      attr_reader :recharge_rate
      attr_reader :priority
      attr_reader :function_code
      attr_reader :real_description
      attr_reader :flags
      attr_reader :pbs_file_suffix
  
      DATA = {}
      DATA_FILENAME = "charms.dat"
      PBS_BASE_FILENAME = "charms"
  
      extend ClassMethodsSymbols
      include InstanceMethods
  
      SCHEMA = {
        "SectionName"       => [:id,                       "m"],
        "Name"              => [:real_name,                "s"],
        "Socket"            => [:socket,                   "u"],
        "ShowQuantity"      => [:show_quantity,            "b"],
        "TotalUses"         => [:total_uses,               "u"],
        "RechargeRate"      => [:recharge_rate,            "u"],
        "FieldUse"          => [:field_use,                "e", {"OnPokemon" => 1, "Direct" => 2}],
        "BattleUse"         => [:battle_use,               "e", {"OnPokemon" => 1, "OnMove" => 2,
                                                                "OnBattler" => 3, "OnFoe" => 4, "Direct" => 5}],
        "Priority"          => [:priority,                 "i"],
        "FunctionCode"      => [:function_code,            "s"],
        "Flags"             => [:flags,                    "*s"],
        "Description"       => [:real_description,         "q"]
      }

      def self.editor_properties
        field_use_array = [_INTL("Can't use in field")]
        self.schema["FieldUse"][2].each { |key, value| field_use_array[value] = key if !field_use_array[value] }
        battle_use_array = [_INTL("Can't use in battle")]
        self.schema["BattleUse"][2].each { |key, value| battle_use_array[value] = key if !battle_use_array[value] }
        return [
          ["ID",                ReadOnlyProperty,                        _INTL("ID of this item (used as a symbol like :XXX).")],
          ["Name",              ItemNameProperty,                        _INTL("Name of this item as displayed by the game.")],
          ["Socket",            SocketProperty,                          _INTL("Slot where this amulet goes when equipped.")],
          ["ShowQuantity",      BooleanProperty,                         _INTL("Whether the Bag shows how many of this item are in there.")],
          ["TotalUses",         LimitProperty.new(20),                   _INTL("How many times a Amulet can be used before it needs recharging.")],
          ["RechargeRate",      LimitProperty.new(20),                   _INTL("Battles to win before regaining a charge for amulet")],
          ["FieldUse",          EnumProperty.new(field_use_array),       _INTL("How this item can be used outside of battle.")],
          ["BattleUse",         EnumProperty.new(battle_use_array),      _INTL("How this item can be used within a battle.")],
          ["Priority",          LimitProperty.new(9999),                 _INTL("Charm's priority in combat.")],
          ["Function Code",     StringProperty,                          _INTL("Probably best not to mess with this")],
          ["Flags",             StringListProperty,                      _INTL("Words/phrases that can be used to group certain kinds of items.")],
          ["Description",       StringProperty,                          _INTL("Description of this item.")]
        ]
      end
  
      def initialize(hash)
        puts "Testing charm hash data to see if it's actually fucking valid."

        @id                       = hash[:id]
        puts "NAME CLASS:"
        puts hash[:real_name].class
        @real_name                = hash[:real_name]        || "Unnamed"
        @socket                   = hash[:socket]           || 1      
        @show_quantity            = hash[:show_quantity]
        @total_uses               = hash[:total_uses]       || 5
        @recharge_rate            = hash[:recharge_rate]    || 2
        @field_use                = hash[:field_use]        || 0
        @battle_use               = hash[:battle_use]       || 0
        @priority                 = hash[:priority]         || 0
        @function_code            = hash[:function_code]    || "None"
        @flags                    = hash[:flags]            || []
        @real_description         = hash[:real_description] || "???"
        @pbs_file_suffix          = hash[:pbs_file_suffix]  || ""
        puts "/*?*?*?*?*?/"
      end
  
      # @return [String] the translated name of this ability
      def name
        puts "Getting name"
        return pbGetMessageFromHash(MessageTypes::CHARM_NAMES, @real_name)
      end
  
      # @return [String] the translated description of this ability
      def description
        puts "getting description"
        return pbGetMessageFromHash(MessageTypes::CHARM_DESCRIPTIONS, @real_description)
      end

      def has_flag?(flag)
        puts "Getting Flags"
        return @flags.any? { |f| f.downcase == flag.downcase }
      end
      
      def display_category(pkmn, move = nil); return @category; end
      def display_accuracy(pkmn, move = nil); return @accuracy; end

      alias __orig__get_property_for_PBS get_property_for_PBS unless method_defined?(:__orig__get_property_for_PBS)
      
      def get_property_for_PBS(key)
        key = "SectionName" if key == "ID"
        ret = __orig__get_property_for_PBS(key)
        puts "Getting Property\n======="
        puts key
        puts ret
        puts "======\n"
        case key
        when "Socket"
          ret = 0 if ret == -1
        when "total_uses", "recharge_rate"
          ret = 1 if ret == -1
        when "FieldUse", "BattleUse"
          ret = 1 if ret == 0
        end
        return ret
      end
    end
  end
  