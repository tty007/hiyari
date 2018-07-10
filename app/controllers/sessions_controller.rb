class SessionsController < ApplicationController
    def create
        user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    # request.env['omniauth.auth']にはOmniAuthによってHash形式でユーザーのデータが格納されている。
        session[:user_id] = user.id
        redirect_to root_path, notice: 'ログインしました'
    end
end
