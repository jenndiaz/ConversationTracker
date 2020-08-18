require 'bundler/setup'
Bundler.require
require 'pry'
ActiveRecord::Base.logger = nil
require_all 'lib'

