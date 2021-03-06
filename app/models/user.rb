class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates :gender, presence: true
  validates :name, presence: true
  validates :email, presence: true

  has_many :posts, :dependent => :destroy

  # #Twitterログイン
  # #引数に関連するユーザーが存在すればそれを返し、存在しまければ新規に作成する
  # def self.find_or_create_from_auth(auth_hash)
  #   #OmniAuthで取得した各データを代入していく
  #   provider = auth_hash[:provider]
  #   uid = auth_hash[:uid]
  #   nickname = auth_hash[:info][:nickname]
  #   image_url = auth_hash[:info][:image]

  #   User.find_or_create_by(provider: provider, uid: uid) do |user|
  #     user.nickname = nickname
  #     user.image_url = image_url
  #   end
  # end
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  protected
  #パスワードなしでユーザ情報の編集を行えるようにオーバーライド
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  #ダミーのメールアドレスを生成
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
