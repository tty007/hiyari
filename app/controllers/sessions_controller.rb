class SessionsController < ApplicationController

    def twitter
        callback_from :twitter
    end

    private

    # def create
    #     user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    # # request.env['omniauth.auth']にはOmniAuthによってHash形式でユーザーのデータが格納されている。
    #     if user
    #         session[:user_id] = user.id
    #         redirect_to root_path, notice: 'ログインしました'
    #     else
    #         redirect_to root_path, notice: "失敗しました。"
    #     end
    # end

    # def destroy
    #     reset_session
    #     redirect_to root_path
    # end

    def callback_from(provider)
        provider = provider.to_s

        @user = User.find_for_oauth(request.env['omniauth.auth'])

        if @user.persisted?
            flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
            sign_in_and_redirect @user, event: :authentication
        else
            session["devise.#{provider}_data"] = request.env['omniauth.auth']
            redirect_to new_user_registration_url
        end
    end
end
