class User < ActiveRecord::Base

  attr_accessor :name, :email, :updated_at, :created_at

  def initialize
  end

end
