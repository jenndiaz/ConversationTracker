class Cli 
    Prompt = TTY::Prompt.new
    attr_accessor :username_input

    def welcome 
        puts "Welcome to Friendly Reminder"
        @username_input = Prompt.ask("Please enter a new or existing username")
        find_user
    end

    def find_user
        @found_user = Account.all.find_by(username: @username_input)
            if @found_user
                puts "Welcome back, #{@found_user.username}!"
            else
                Account.create(username: @username_input)
                puts "Welcome, new friend, #{@username_input}!"
                
            end
            main_menu
        end
    end

    def main_menu 

    end

    






#    # Request username input from user and save to variable
#    puts "Enter a new or existing username to continue:".light_yellow
#    username_response = gets.chomp

#    # Access User.find_user method to determine if user is new or existing
#    User.find_user(username_response)