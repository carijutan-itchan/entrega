class Resources::Users::UsersResources
  include Alba::Resource

  root_key :users

  attributes :id, :first_name, :last_name, :contact, :email
end