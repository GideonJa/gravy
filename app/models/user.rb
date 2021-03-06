class User
  
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name
  field :email
   
  index [[:uid, Mongo::ASCENDING], [:provider, Mongo::ASCENDING]]
  
  validates_presence_of :provider, :uid, :email, :name, :email
  validates_uniqueness_of :email
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end
        

end
