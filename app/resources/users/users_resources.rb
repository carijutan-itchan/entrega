class BlogResource < BaseResource
  root_key :user

  attributes :id, :first_name, :last_name, :contact, :jti
end