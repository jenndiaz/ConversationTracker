class Conversation < ActiveRecord::Base
    belongs_to :account
    belongs_to :friend
end