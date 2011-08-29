require 'active_record'

# -- init kaminari without rails
require "kaminari/config"
require "kaminari/models/page_scope_methods"
require "kaminari/models/configuration_methods"
require "kaminari/models/active_record_extension"
::ActiveRecord::Base.send :include, Kaminari::ActiveRecordExtension

# -- setup ActiveRecord
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

class User < ActiveRecord::Base
  include ActsAsFlexigrid
end

class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:users) {|t| t.string :name; t.integer :age}
  end
end
