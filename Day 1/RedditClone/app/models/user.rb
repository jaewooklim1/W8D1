class User < ApplicationRecord

    validates :username, :uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    attr_reader :password

    after_initialize :ensure_session_token

    has_many :posts

    has_many :comments

    has_many :user_votes

    # FIGVAPER

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom.base64(64)
        self.save!
        self.session_token
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        
        return nil if user.nil?

        user.is_password?(password) ? user : nil
    end

    private 

    def ensure_session_token
        self.session_token ||= SecureRandom.base64(64)
    end
end