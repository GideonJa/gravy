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


   def apply_omniauth(omniauth)
     self.email = omniauth['info']['email'] if email.blank?
     self.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
   end

end
