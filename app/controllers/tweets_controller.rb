class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @comment = Comment.new
    #新着順
    @comments = @tweet.comments.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(post_params)
    @tweet.user_id = current_user.id
    @tweet.save
    redirect_to tweets_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def post_params
      params.require(:tweet).permit(:title, :body, :post_image, :category_id, :erea_id)
    end



end

