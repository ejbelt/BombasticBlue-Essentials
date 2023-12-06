class Window_BBCharms < Window_DrawableCommand
   
    attr_accessor :sorting
    attr_reader :charms
  
    def initialize(bag, filterlist, x, y, width, height)
      @bag        = bag
      @filterlist = filterlist
      @charms = @bag.pockets["Charms"]
      @sorting = false
      super(x, y, width, height)
      @selarrow  = AnimatedBitmap.new("Graphics/UI/Bag/cursor")
      @swaparrow = AnimatedBitmap.new("Graphics/UI/Bag/cursor_swap")
      self.windowskin = nil
    end


end


### Amulet Screen

class BBAmuletScreen < Window_DrawableCommand
  

end

class BBAmuletScene

    charmlistBASECOLOR     = Color.new(88, 88, 80)
    charmlistSHADOWCOLOR   = Color.new(168, 184, 184)
    charmtextBASECOLOR     = Color.new(248, 248, 248)
    charmtextSHADOWCOLOR   = Color.new(0, 0, 0)
    POCKETNAMEBASECOLOR   = Color.new(88, 88, 80)
    POCKETNAMESHADOWCOLOR = Color.new(168, 184, 184)
    ITEMSVISIBLE          = 7
  
    def pbUpdate
      pbUpdateSpriteHash(@sprites)
    end

    def pbStartScene(bag, amulet, choosing = false, filterproc = nil, resetpocket = true)
        @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
        @viewport.z = 99999
        @bag        = bag
        @amulet     = amulet
        @choosing   = choosing
        @filterproc = filterproc
        pbRefreshFilter
        lastpocket = @bag.last_viewed_pocket
        numfilledpockets = @bag.pockets.length - 1
        if @choosing
          numfilledpockets = 0
          if @filterlist.nil?
            (1...@bag.pockets.length).each do |i|
              numfilledpockets += 1 if @bag.pockets[i].length > 0
            end
          else
            (1...@bag.pockets.length).each do |i|
              numfilledpockets += 1 if @filterlist[i].length > 0
            end
          end
          lastpocket = (resetpocket) ? 1 : @bag.last_viewed_pocket
          if (@filterlist && @filterlist[lastpocket].length == 0) ||
             (!@filterlist && @bag.pockets[lastpocket].length == 0)
            (1...@bag.pockets.length).each do |i|
              if @filterlist && @filterlist[i].length > 0
                lastpocket = i
                break
              elsif !@filterlist && @bag.pockets[i].length > 0
                lastpocket = i
                break
              end
            end
          end
        end
        @bag.last_viewed_pocket = lastpocket
        @sliderbitmap = AnimatedBitmap.new("Graphics/UI/Bag/icon_slider")
        @slotbitmap = AnimatedBitmap.new("Graphics/UI/Amulet/icon_slot")
        @sprites = {}
        @sprites["background"] = IconSprite.new(0, 0, @viewport)
        @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
        pbSetSystemFont(@sprites["overlay"].bitmap)
        @sprites["bagsprite"] = IconSprite.new(30, 20, @viewport)
        @sprites["charmicon"] = BitmapSprite.new(186, 32, @viewport)
        @sprites["charmicon"].x = 0
        @sprites["charmicon"].y = 224
        @sprites["leftarrow"] = AnimatedSprite.new("Graphics/UI/left_arrow", 8, 40, 28, 2, @viewport)
        @sprites["leftarrow"].x       = -4
        @sprites["leftarrow"].y       = 76
        @sprites["leftarrow"].visible = (!@choosing || numfilledpockets > 1)
        @sprites["leftarrow"].play
        @sprites["rightarrow"] = AnimatedSprite.new("Graphics/UI/right_arrow", 8, 40, 28, 2, @viewport)
        @sprites["rightarrow"].x       = 150
        @sprites["rightarrow"].y       = 76
        @sprites["rightarrow"].visible = (!@choosing || numfilledpockets > 1)
        @sprites["rightarrow"].play
        @sprites["charmlist"] = Window_PokemonBag.new(@bag, @filterlist, lastpocket, 168, -8, 314, 40 + 32 + (ITEMSVISIBLE * 32))
        @sprites["charmlist"].viewport    = @viewport
        @sprites["charmlist"].pocket      = lastpocket
        @sprites["charmlist"].index       = @bag.last_viewed_index(lastpocket)
        @sprites["charmlist"].baseColor   = charmlistBASECOLOR
        @sprites["charmlist"].shadowColor = charmlistSHADOWCOLOR
        @sprites["charmicon"] = ItemIconSprite.new(48, Graphics.height - 48, nil, @viewport)
        @sprites["charmtext"] = Window_UnformattedTextPokemon.newWithSize(
          "", 72, 272, Graphics.width - 72 - 24, 128, @viewport
        )
        @sprites["charmtext"].baseColor   = charmtextBASECOLOR
        @sprites["charmtext"].shadowColor = charmtextSHADOWCOLOR
        @sprites["charmtext"].visible     = true
        @sprites["charmtext"].windowskin  = nil
        @sprites["helpwindow"] = Window_UnformattedTextPokemon.new("")
        @sprites["helpwindow"].visible  = false
        @sprites["helpwindow"].viewport = @viewport
        @sprites["msgwindow"] = Window_AdvancedTextPokemon.new("")
        @sprites["msgwindow"].visible  = false
        @sprites["msgwindow"].viewport = @viewport
        pbBottomLeftLines(@sprites["helpwindow"], 1)
        pbDeactivateWindows(@sprites)
        pbRefresh
        pbFadeInAndShow(@sprites)
      end

      def pbRefresh
        # Set the background image
        @sprites["background"].setBitmap(sprintf("Graphics/UI/Amulet/bg_%d", @bag.last_viewed_pocket))
        # Set the bag sprite
        amuletscreenexists = pbResolveBitmap(sprintf("Graphics/UI/Amulet/amulet_%d_f", @bag.last_viewed_pocket))
        if amuletscreenexists
          @sprites["bagsprite"].setBitmap(sprintf("Graphics/UI/Amulet/amulet_%d", @bag.last_viewed_pocket))
        end
        # Draw the pocket icons
        @sprites["charmicon"].bitmap.clear
        if @choosing && @filterlist
          (1...@bag.pockets.length).each do |i|
            next if @filterlist[i].length > 0
            @sprites["charmicon"].bitmap.blt(
              6 + ((i - 1) * 22), 6, @slotbitmap.bitmap, Rect.new((i - 1) * 20, 28, 20, 20)
            )
          end
        end
        @sprites["charmicon"].bitmap.blt(
          2 + ((@sprites["charmlist"].pocket - 1) * 22), 2, @slotbitmap.bitmap,
          Rect.new((@sprites["charmlist"].pocket - 1) * 28, 0, 28, 28)
        )
        # Refresh the charm window
        @sprites["charmlist"].refresh
        # Refresh more things
        pbRefreshIndexChanged
      end
    
      def pbRefreshIndexChanged
        charmlist = @sprites["charmlist"]
        overlay = @sprites["overlay"].bitmap
        overlay.clear
        # Draw the pocket name
        pbDrawTextPositions(
          overlay,
          [["Charms", 94, 186, :center, POCKETNAMEBASECOLOR, POCKETNAMESHADOWCOLOR]]
        )
        # Draw slider arrows
        showslider = false
        if charmlist.top_row > 0
          overlay.blt(470, 16, @sliderbitmap.bitmap, Rect.new(0, 0, 36, 38))
          showslider = true
        end
        if charmlist.top_item + charmlist.page_item_max < charmlist.itemCount
          overlay.blt(470, 228, @sliderbitmap.bitmap, Rect.new(0, 38, 36, 38))
          showslider = true
        end
        # Draw slider box
        if showslider
          sliderheight = 174
          boxheight = (sliderheight * charmlist.page_row_max / charmlist.row_max).floor
          boxheight += [(sliderheight - boxheight) / 2, sliderheight / 6].min
          boxheight = [boxheight.floor, 38].max
          y = 54
          y += ((sliderheight - boxheight) * charmlist.top_row / (charmlist.row_max - charmlist.page_row_max)).floor
          overlay.blt(470, y, @sliderbitmap.bitmap, Rect.new(36, 0, 36, 4))
          i = 0
          while i * 16 < boxheight - 4 - 18
            height = [boxheight - 4 - 18 - (i * 16), 16].min
            overlay.blt(470, y + 4 + (i * 16), @sliderbitmap.bitmap, Rect.new(36, 4, 36, height))
            i += 1
          end
          overlay.blt(470, y + boxheight - 18, @sliderbitmap.bitmap, Rect.new(36, 20, 36, 18))
        end
        # Set the selected charm's icon
        @sprites["charmicon"].item = charmlist.item
        # Set the selected charm's description
        @sprites["charmtext"].text =
          (charmlist.item) ? GameData::Charm.get(charmlist.item).description : _INTL("Close bag.")
      end
    
      def pbRefreshFilter
        @filterlist = nil
        return if !@choosing
        return if @filterproc.nil?
        @filterlist = []
        (1...@bag.pockets.length).each do |i|
          @filterlist[i] = []
          @bag.pockets[i].length.times do |j|
            @filterlist[i].push(j) if @filterproc.call(@bag.pockets[i][j][0])
          end
        end
      end

      def bbChoseAmulet

      end

      def bbChoseCharm

      end
    
end

class BBAmuletSceneScreen

    def initialize(scene, bag, amulet)
        @amulet = amulet
        @bag   = bag
        @scene = scene
    end

    @scene.pbStartScene(@bag, @amulet)
    charm = nil
    loop do
      item = @scene.bbChoseCharm
      break if !item
      charm = GameData::Charm.get(item)
      cmdRead     = -1
      cmdUse      = -1
      cmdEquip    = -1
      cmdGive     = -1
      cmdToss     = -1
      cmdDebug    = -1
      commands = []
      # Generate command list
      commands[cmdEquip = commands.length]       = _INTL("Equip")
      commands[cmdGive = commands.length]       = _INTL("Give") if $player.pokemon_party.length > 0 && itm.can_hold?
      commands[cmdToss = commands.length]       = _INTL("Toss") if !charm.is_important? || $DEBUG
      commands[cmdDebug = commands.length]      = _INTL("Debug") if $DEBUG
      commands[commands.length]                 = _INTL("Cancel")
      # Show commands generated above
      itemname = charm.name
      command = @scene.pbShowCommands(_INTL("{1} is selected.", itemname), commands)

      if cmdEquip >= 0 && command == cmdEquip   # Use item
        ret = bbEquipCharm(item)
        # ret: 0=Item wasn't used; 1=Item used; 2=Close Bag to use in field
        break if ret == 2   # End screen
        @scene.pbRefresh
        next
      elsif cmdGive >= 0 && command == cmdGive   # Give item to Pokémon
        if $player.pokemon_count == 0
          @scene.pbDisplay(_INTL("There is no Pokémon."))
        elsif charm.is_important?
          @scene.pbDisplay(_INTL("The charm can't be held."))
        else
          pbFadeOutIn do
            sscene = PokemonParty_Scene.new
            sscreen = PokemonPartyScreen.new(sscene, $player.party)
            sscreen.pbPokemonGiveScreen(item)
            @scene.pbRefresh
          end
        end
      elsif cmdToss >= 0 && command == cmdToss   # Toss item
        qty = @bag.quantity(item)
        if qty > 1
          helptext = _INTL("Toss out how many {1}s?", charm.name)
          qty = @scene.pbChooseNumber(helptext, qty)
        end
        if qty > 0
          itemname = charm.name
          if pbConfirm(_INTL("Is it OK to throw away {1} {2}?", qty, itemname))
            pbDisplay(_INTL("Threw away {1} {2}.", qty, itemname))
            qty.times { @bag.remove(item) }
            @scene.pbRefresh
          end
        end
      elsif cmdDebug >= 0 && command == cmdDebug   # Debug
        command = 0
        loop do
          command = @scene.pbShowCommands(_INTL("Do what with {1}?", itemname),
                                          [_INTL("Change quantity"),
                                           _INTL("Cancel")], command)
          case command
          ### Cancel ###
          when -1, 2
            break
          ### Change quantity ###
          when 0
            qty = @bag.quantity(item)
            params = ChooseNumberParams.new
            params.setRange(0, Settings::BAG_MAX_PER_SLOT)
            params.setDefaultValue(qty)
            newqty = pbMessageChooseNumber(
              _INTL("Choose new quantity of {1} (max. {2}).", itemplural, Settings::BAG_MAX_PER_SLOT), params
            ) { @scene.pbUpdate }
            if newqty > qty
              @bag.add(item, newqty - qty)
            elsif newqty < qty
              @bag.remove(item, qty - newqty)
            end
            @scene.pbRefresh
            break if newqty == 0
          end
        end
      end
    end
    ($game_temp.fly_destination) ? @scene.dispose : @scene.pbEndScene
    return item
  end

    def pbDisplay(text)
        @scene.pbDisplay(text)
    end
    
    def pbConfirm(text)
        return @scene.pbConfirm(text)
    end

    def bbEquipCharm(charm)

    end

    def bbCharmIntoSlot(charm, slot)

    end

end