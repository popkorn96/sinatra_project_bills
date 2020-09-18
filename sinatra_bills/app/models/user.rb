class User < ActiveRecord::Base
    has_secure_password
    has_many :bills
    validates_presence_of :username, :password
end
