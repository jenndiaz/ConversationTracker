class Cli 
    Prompt = TTY::Prompt.new 
    #attr_reader :something? 
    def feedback 
        gets.strip
    end

    def welcome 
        puts "Welcome to Friendly Reminder"
        name = Prompt.ask("Please enter your username")  

        if name != Account.username then Account.create(username: name)
        else name =username: 
    end
end