class Project
  include Mongoid::Document
  field :name, :type => String
  field :owner, :type => String
end
