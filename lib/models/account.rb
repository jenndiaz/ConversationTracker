class Account < ActiveRecord::Base
    has_many :conversations
    has_many :friends, through: :conversations
end