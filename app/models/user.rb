class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email                  , type: String # :null => false
  field :encrypted_password     , type: String # :null => false
  field :reset_password_token   , type: String
  field :reset_password_sent_at , type: DateTime
  field :remember_created_at    , type: DateTime
  field :sign_in_count          , type: Integer   , default: 0
  field :current_sign_in_at     , type: DateTime
  field :last_sign_in_at        , type: DateTime
  field :current_sign_in_ip     , type: String
  field :last_sign_in_ip        , type: String

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
