class User < ActiveRecord::Base
    
    has_many :applications
    before_save { self.username = username.downcase }
    
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :username, presence:true, length: { maximum: 255 }, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    
    validates :password, presence:true, length: { minimum: 6, maximum: 255 }
end
