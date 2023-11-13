

Bootstrap.SCRIPTS.each do |script|

    begin
        sFile = File.open('Scripts/' + path + '.rb', 'r') { |f| f.read }

    rescue
        #Error out here.

end


#To ensure the game stays alive when we load the scripts
loop do
    Graphics.update
    Input.update
end