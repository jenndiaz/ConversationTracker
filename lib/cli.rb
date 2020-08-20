require "tty-prompt"
class Cli 
    prompt = TTY::Prompt.new
    attr_accessor :username_input

    def welcome_art 
        font = TTY::Font.new(:doom) 
        puts (font.write("Friendly Reminder")).colorize(:cyan)
    end

    def welcome 
        system("clear")
        welcome_art
        prompt = TTY::Prompt.new(active_color: :cyan)
        # binding.pry
        puts "Welcome to Friendly Reminder"  
        @username_input = prompt.ask("Please enter a new or existing username".colorize(:cyan)) do |q|
            q.required true
            q.modify :strip, :capitalize 
        end
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
        prompt = TTY::Prompt.new(active_color: :cyan)
        choices = {
            "Create New Converastion" => 1,
            "Delete Conversation" => 2,
            "Update Conversation" => 3, 
            "View Your Friends" => 4, 
            "Exit Friendly Reminder" => 5
        }
        menu_response = prompt.select("Choose an option from below:".colorize(:cyan), choices)
        case menu_response
        when 1 #create
            prompt = TTY::Prompt.new(active_color: :cyan)
            new_friend_name = prompt.ask("Who is your friend?") do |q|
                q.required true
                q.modify :strip, :capitalize 
            end
            date = prompt.ask ("On what date was your most recent conversation?")
            new_friend = Friend.create(name: new_friend_name, occupation: nil)
            Conversation.create account: @found_user, friend: new_friend, date: date
            puts "Your new friend has been entered! Remeber to keep in touch!"
           # binding.pry
           sleep(1.5)
           system("clear")
           welcome_art
           main_menu
        when 2 #delete
            exfriend = prompt.ask("Who would you like to delete??")
            exfriend_name = Friend.find_by(name: exfriend)
            exfriend_name.destroy
            puts "Your Converstion has been deleted! Go make find new friends!"
            sleep(1.5)
            system("clear")
            welcome_art
            main_menu
        when 3 #Update
            prompt = TTY::Prompt.new
            friend_chat = prompt.ask("Great job reaching out to a friend! Whom did you speak with?")
            friend = Friend.find_by(name: friend_chat)
            newconvo = Conversation.find_by(friend: friend)
            new_date = prompt.ask("On what date did you speak to them?")
            newconvo.update(date: new_date)
           puts "Your conversation has been updated!"
           sleep(1.5)
           system("clear")
           welcome_art
           main_menu
        when 4 #View 
            puts "here are your friends!"
            sleep(1)
            yourfriends = @found_user.friends 
            yourfriends.each do |friend|
                puts  friend.name
            end
            sleep(1.5)
            system("clear")
            welcome_art
            main_menu
        when 5 
            puts "We hope you enjoied your Friendly Reminder! Come back soon!"
            sleep(3)
            exit
        end

    end