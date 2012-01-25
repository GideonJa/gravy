class User
  
  include Mongoid::Document
  references_many :authentications
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
         
  attr_accessible :email, :name


  def self.from_omniauth(auth)
     find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
   end

   def self.create_with_omniauth(auth)
     create! do |user|
       user.name = auth["info"]["name"]
       user.email = auth["info"]["email"]
     end
      
      user.provider = auth["provider"]
       user.uid = auth["uid"]
     
   end
end
