class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    #現在のユーザに紐づいた新規投稿の作成
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿が作成されました"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.update(post_params)
    redirect_to("/posts")
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to("/users/#{current_user.id}")
  end

  # ストロングパラメータを定義
  private

    def post_params
      params[:post].permit(:title, :content)
    end
end
