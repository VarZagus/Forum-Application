class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true
    has_many :posts
    has_many :comments
    

    def update_posts_count
        self.posts_count+=1
        save
    end

end
