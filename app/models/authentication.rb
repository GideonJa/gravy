class Authentication
  
  include Mongoid::Document
  field :user_id, :type => Integer
  field :provider, :type => String
  field :uid, :type => String
  key :uid, :provider, :user_id
  
  referenced_in :user
end
