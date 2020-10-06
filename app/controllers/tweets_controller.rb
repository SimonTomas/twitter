class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet]
  before_action :authenticate_user!, except: [:index]

  # GET /tweets
  # GET /tweets.json
  def index

    if params[:q]
      @tweets = Tweet.where("content LIKE ?", "%#{params[:q]}%").order(created_at: :desc).page(params[:page])
    elsif current_user.nil?
      @tweets = Tweet.order(created_at: :desc).page(params[:page])
    else
      @tweets = Tweet.tweets_for_me(current_user.friends).order(created_at: :desc).page(params[:page])
    end

    @tweet = Tweet.new

  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
  end

  # GET /tweets/1/edit
  def edit
    if @tweet.user_id != current_user.id
      redirect_to root_path, alert: 'No tienes permiso para editar el Tweet'
    end
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'El Tweet fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { redirect_to root_path, alert: 'El tweet no pudo ser creado' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to root_path, notice: 'El Tweet fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def retweet
    @retweet = Tweet.new(
      user_id: current_user.id,
      content: @tweet.content,
      tweet_id: @tweet.id
    )
    
    if @retweet.save
      # render 'retweet'
      redirect_to root_path, notice: 'Has retwiteado exitosamente!'
    else
      redirect_to root_path, alert: 'Ya lo has retwiteado!'
    end

  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'El Tweet ha sido eliminado.' }
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
      params.require(:tweet).permit(:content, :user_id, :tweet_id)
    end

end
