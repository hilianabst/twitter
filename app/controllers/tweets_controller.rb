class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweets]
  before_action :authenticate_user!, :except => [:index]
  http_basic_authenticate_with name: "hello", password: "world", except: :index


  # def retweets
  #   @retweet= Tweet.create(content:@tweet.content, user_id:@tweet.user_id, tweet_id:@tweet.id)
  # end

  # private
  # def tweet_params
  #   params.require(:tweet).permit(:content, :user_id, :tweet_id)
  # end 

  def hashtags
      tag = Tag.find_by(name: params[:name]).per(50)
      @tweets = tag.tweets
  
    end

  def apis
    @tweet = Tweet.all.page(params[:page]).per(50)
    # render json: @tweet
    render plain: JSON.pretty_generate(@tweet.as_json)

  end

  def index
    search = []
    if params[:content].present?
      search = Tweet.content(params[:content])
    else
<<<<<<< HEAD
      search = Tweet.all.with_image
=======
      search = Tweet.all
>>>>>>> 2e48a251abd03b2f95cecba81ac4814999e76049
    end
    @tweets = search.order("created_at DESC").page(params[:page]).per(50)
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.build
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id]) 
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :photo)
    end
end
