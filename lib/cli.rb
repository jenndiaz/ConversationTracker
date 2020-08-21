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
        puts "Welcome to Friendly Reminder"
        puts "The friendly app to track your friends and stay in touch!"
        @username_input = prompt.ask("Please enter a new or existing username:".colorize(:cyan)) do |q|
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
                puts "Welcome new friend, #{@username_input}!"
                sleep(1)
            end
            main_menu
        end
    end

    def main_menu 
        prompt = TTY::Prompt.new(active_color: :cyan)
        choices = {
            "Add New Conversation with Friend" => 1,
            "Delete Conversation with Friend" => 2,
            "Update Conversation with Friend" => 3, 
            "View Your Friends and Conversation Dates" => 4, 
            "Exit Friendly Reminder" => 5
    
        }
        menu_response = prompt.select("Choose an option from below:".colorize(:cyan), choices)
        case menu_response
        when 1 #create
            prompt = TTY::Prompt.new(active_color: :cyan)
            new_friend_name = prompt.ask("Who is the friend you spoke to?") do |q|
                q.required true
                q.modify :strip, :capitalize 
                end
            date = prompt.ask ("On what date was your most recent conversation? YYYY-MM-DD")
           #binding.pry 
            new_friend = Friend.create(name: new_friend_name, occupation: nil)
            new_friend.save
            if @found_user
                Conversation.create(account: @found_user, friend: new_friend, date: date)
            elsif @new_user
                Conversation.create(account: @new_user, friend: new_friend, date: date)
            end
            puts "Your new friend has been entered! Remember to keep in touch!"
           # binding.pry
           sleep(1)
           system("clear")
           welcome_art
           main_menu
        when 2 #delete
            exfriend = prompt.ask("Who would you like to delete?")
            friend_instance = Friend.find_by(name: exfriend)
            exfriend_name = Conversation.find_by(friend: friend_instance)
                if exfriend_name == nil
                    puts "You haven't started a conversation with this friend yet. Add a new conversation to get started.".colorize(:red)
                # binding.pry
                else
                    exfriend_name.destroy.save
                    puts "Your conversation has been deleted! :( Time to make new friends!"
                end
            sleep(1)
            system("clear")
            welcome_art
            main_menu
        when 3 #Update
            prompt = TTY::Prompt.new(active_color: :cyan)
            friend_chat = prompt.ask("Great job reaching out to a friend! Whom did you speak with?")
            sleep(1)
            friend = Friend.find_by(name: friend_chat)
            newconvo = Conversation.find_by(friend: friend)
                if newconvo == nil
                    puts "You haven't started a conversation with this friend yet. Add a new conversation to get started.".colorize(:red)
                    sleep(1)
                else
                    new_date = prompt.ask("On what date did you speak to them? YYYY-MM-DD")
                    newconvo.update(date: new_date)
                    puts "Your conversation has been updated!"
                end
            sleep(1)
            system("clear")
            welcome_art
            main_menu
        when 4 #View friends
            prompt = TTY::Prompt.new(active_color: :cyan)
            if @found_user
                found_user_id = @found_user.id
                yourconversations = Conversation.where(account: found_user_id)
            elsif @new_user
                new_user_id = @new_user
                yourconversations = Conversation.where(account: new_user_id)
            end
                 yourconversations.reload           
            if yourconversations.empty?
                puts "You haven't added any friends yet. Create a new conversation to get started.".colorize(:red)
            else
                puts "Here are your friends!"
                sleep(1)
                yourconversations.each do |conversation|
                    puts "#{conversation.friend.name}:  #{conversation.date} "
                end
            end
            prompt.keypress("Press any key to return to the main menu".colorize(:cyan) )
            system("clear")
            welcome_art
            main_menu      
        when 5 
            puts "We hope you enjoyed your Friendly Reminder! Come back soon!"
            sleep(2)
            exit
        end
    end        