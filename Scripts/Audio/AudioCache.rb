
#===============================================================================
# Tired of errors, copying and using Handler hash without the blocking
#===============================================================================
class SoundHash
    def initialize
      @hash = {}
    end
  
    def [](id)
      return @hash[id] if id && @hash[id]
      return nil
    end
  
    def add(id, sound = nil)
      @hash[id] = sound
    end
  
    def copy(src, *dests)
      sound = self[src]
      return if !sound
      dests.each { |dest| add(dest, sound) }
    end
  
    def remove(key)
      @hash.delete(key)
    end
  
    def clear
      @hash.clear
    end
  
    def each
      @hash.each_pair { |key, value| yield key, value }
    end
  
    def keys
      return @hash.keys.clone
    end
  
    # NOTE: The call does not pass id as a parameter to the proc/block.
    def trigger(id, *args)
      sound = self[id]
      return sound&.call(*args)
    end

end


module AudioCache
    Cache = SoundHash.new()
    
    def self.AddToCache(audio_file, volume=100, pitch=100)
        if audio_file.is_a?(String)
            new_member = AudioCacheMember.new(audio_file, volume, pitch)
            Cache.add(audio_file, new_member)
            return new_member
        end
        
        if audio_file.is_a(RPG::AudioFile)
            Cache.add(audio_file.name, audio_file)
            return audio_file
        end

        return nil
    end

    def self.GetCacheValue(key)
        return Cache[key]
    end

end

class AudioCacheMember
    attr_reader   :name          # map event interpreter
    attr_reader   :audio_file       # battle event interpreter
    attr_reader   :volume
    attr_reader   :pitch
  
    def initialize(file_name, volume=100, pitch=100)
      @name = file_name
      @volume = volume
      @pitch = pitch
      @audio_file = RPG::AudioFile.new(file_name, volume, pitch)
    end

    def GetFile()
        return @audio_file
    end

end

module AudioPreloader
    module_function

    def PreloadSounds()
        #Preload_BGM()
        Preload_BGS()
        #Preload_ME()
        Preload_SE()
    end

    def Preload_SE()
        files = FilenameUpdater.readDirectoryFiles('Audio/SE/', ['*.ogg'])
        files.each_with_index do |file, i|
            new_file = AudioCache.AddToCache(file, 100, 100)
            bbPreloadSE(new_file)
        end
        Preload_Anim()
        Preload_Ambience()
        # Preload_Cries()
    end

    def Preload_Ambience()
        files = FilenameUpdater.readDirectoryFiles('Audio/SE/Ambience', ['*.ogg'])
        files.each_with_index do |file, i|
            new_file = AudioCache.AddToCache('Ambience/' + file, 100, 100)
            bbPreloadSE('Ambience/' + file)
        end
    end
    
    def Preload_Anim()
        files = FilenameUpdater.readDirectoryFiles('Audio/SE/Anim', ['*.ogg'])
        files.each_with_index do |file, i|
            new_file = AudioCache.AddToCache('Anim/' + file, 100, 100)
            bbPreloadSE('Anim/' + file)
        end
    end
    
    def Preload_Cries()
        files = FilenameUpdater.readDirectoryFiles('Audio/SE/Cries', ['*.ogg'])
        files.each_with_index do |file, i|
            new_file = AudioCache.AddToCache('Cries/' + file, 100, 100)
            bbPreloadSE('Cries/' + file)
        end
    end

    def Preload_BGM()
        files = FilenameUpdater.readDirectoryFiles('Audio/BGM/', ['*.ogg', '*.mid'])
        files.each_with_index do |file, i|
            new_file = AudioCache.AddToCache(file, 100, 100)
            bbPreloadBGM(file)
        end
    end

    def Preload_BGS()
        files = FilenameUpdater.readDirectoryFiles('Audio/BGS/', ['*.ogg'])
        files.each_with_index do |file, i|
            new_file = AudioCache.AddToCache(file, 100, 100)
            bbPreloadBGS(file)
        end
    end

    def Preload_ME()
        files = FilenameUpdater.readDirectoryFiles('Audio/ME/', ['*.ogg'])
        files.each_with_index do |file, i|
            new_file = AudioCache.AddToCache(file, 100, 100)
            bbPreloadME(file)
        end
    end

end