class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    @user = current_user
    @like.author = @user

    @like.save if @like.valid?
    redirect_to user_posts_path(@user)
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
