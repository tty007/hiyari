class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :gender, presence: true
  validates :name, presence: true
  validates :email, presence: true

  has_many :posts, :dependent => :destroy

  protected
  #パスワードなしでユーザ情報の編集を行えるようにオーバーライド
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
end
