class Friend < ActiveRecord::Base
    has_many :conversations
    has_many :accounts, through: :conversations
end