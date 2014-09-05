class AddMsgpicToMessages < ActiveRecord::Migration
  def self.up
  	add_attachment :messages, :msgpic
  end
  def self.down
  	remove_attachment :messages, :msgpic
	end
end
