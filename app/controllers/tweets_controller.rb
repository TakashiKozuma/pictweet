class TweetsController < ApplicationController
  # before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end
  
  def new
    @tweet = Tweet.new
    # @tweet = Test.new
    # @tweet = Tweet.find(1)
  end
  
  def create
    Tweet.create(tweet_params)
    # Test.create(test_params)
  end
  
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end
  
  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end
  
  def test_params
    params.require(:test).permit(:image, :text).merge(user_id: current_user.id)
  end
  
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
  
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
