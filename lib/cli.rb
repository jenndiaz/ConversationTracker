require "tty-prompt"
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
        menu_options = {
            "Create New Converastion" => 1,
            "Delete Conversation" => 2,
            "Update Conversation" => 3, 
            "View Your Friends" => 4, 
            "Exit Friendly Reminder" => 5
        }
        # menu_response = Prompt.select("Choose an option from below:")
        # case menu_response
        # when 1
            
        # when 2

        # when 3 

        # when 4 
        
        # when 5 
        #     puts "We hope you enjoied your Friendly Reminder! Come back soon!"
        #     welcome
        # end

    end