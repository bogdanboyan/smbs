Factory.define :user do |u|
  u.email    'one@railsware.com'
  u.password '12345678'
  u.password_confirmation { |user| user.password }
end