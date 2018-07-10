class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :gender, presence: true
  validates :name, presence: true
  validates :email, presence: true

  has_many :posts, :dependent => :destroy

  #Twitterログイン
  #引数に関連するユーザーが存在すればそれを返し、存在しまければ新規に作成する
  def self.find_or_create_from_auth_hash(auth_hash)
    #OmniAuthで取得した各データを代入していく
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
      user.email = User.dummy_email(auth)
    end
  end

  protected
  #パスワードなしでユーザ情報の編集を行えるようにオーバーライド
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
end
