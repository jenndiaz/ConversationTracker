require "tty-prompt"
class Cli 
    prompt = TTY::Prompt.new
    attr_accessor :username_input, :new_user

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
                sleep(1)
            else
                @new_user = Account.create(username: @username_input)
                puts "Welcome, new friend, #{@username_input}!"
                sleep(1)
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
            "Exit Friendly Reminder" => 5,
            "Test View Friends/Dates" => 6
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
           sleep(1)
           system("clear")
           welcome_art
           main_menu
        when 2 #delete
            exfriend = prompt.ask("Who would you like to delete??")
            exfriend_name = Friend.find_by(name: exfriend)
            exfriend_name.destroy
            puts "Your Converstion has been deleted! Go make find new friends!"
            sleep(1)
            system("clear")
            welcome_art
            main_menu
        when 3 #Update
            prompt = TTY::Prompt.new
            friend_chat = prompt.ask("Great job reaching out to a friend! Whom did you speak with?")
            sleep(1)
            friend = Friend.find_by(name: friend_chat)
            newconvo = Conversation.find_by(friend: friend)
                if newconvo == nil
                    puts "You haven't started a conversation with this friend yet. Create a new conversation to get started.".colorize(:red)
                    sleep(1)
                else
            new_date = prompt.ask("On what date did you speak to them?")
            newconvo.update(date: new_date)
            puts "Your conversation has been updated!"
                end
            sleep(1)
            system("clear")
            welcome_art
            main_menu
        when 4 #View friends
            if @found_user
                yourfriends = @found_user.friends
            elsif @new_user
                yourfriends = @new_user.friends
                end
            if yourfriends.empty?
                puts "You haven't added any friends yet. Create a new conversation to get started.".colorize(:red)
            else
                puts "Here are your friends!"
                sleep(1)
                yourfriends.each do |friend|
                    puts friend.name
            end
        end
            sleep(1.5)
            system("clear")
            welcome_art
            main_menu
        when 5 
            puts "We hope you enjoyed your Friendly Reminder! Come back soon!"
            sleep(3)
            exit
        when 6
            if @found_user
                found_user_id = @found_user.id
                yourconversations = Conversation.where(account: found_user_id)
            elsif @new_user
                new_user_id = @new_user.id
                yourconversations = Conversation.where(account: new_user_id)
            end
            if yourconversations.empty?
                puts "You haven't added any friends yet. Create a new conversation to get started.".colorize(:red)
            else
                puts "Here are your friends!"
                sleep(1)
                yourconversations.each do |conversation|
                    puts conversation.date
            end
        end
            sleep(1.5)
            main_menu
        end
        end

        # def view_conversations
        #     if @found_user
        #         yourconversations = Conversation.where(account_id: @found_user.account_id)
        #     elsif @new_user
        #         yourconversations = Conversation.where(account_id: @new_user.account_id)
        #     end
        #     if yourconversations.empty?
        #         puts "You haven't added any friends yet. Create a new conversation to get started.".colorize(:red)
        #     else
        #         puts "Here are your friends!"
        #         sleep(1)
        #         yourconversations.each do |conversation|
        #             puts conversation.name conversation.date
        #     end
        # end
        #     sleep(1.5)
        #     main_menu
        # end
    # end