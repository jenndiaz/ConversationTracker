class Conversation < ActiveRecord::Base
    belongs_to :account
    belongs_to :friend

    # def self.view_friends
    #     all.pluck(:friend) 
    #     binding.pry
    #     puts "here are your friends!"
    # end

end