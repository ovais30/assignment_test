class TweetsController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    tweets = current_user.tweets
    if tweets.present?
      msg = "tweets List"
      stts = true
    else
      msg = "No data Found"
      stts = false
    end
    render :status => 200,
           :json => {:success => stts,
                     :msg => msg,
                     :tweets => tweets
                        }
  end

  def create
    comment = Tweet.create(tweet_params)
    if comment.save
      render :status => 200,
             :json => {:success => true,
                       :msg => "Tweet Post Successfully",
                       :tweet => comment
                        }
    else
      render :status => 200,
             :json => {:success => false,
                       :msg => comment.error.messages[0]
                        }
    end
  end

  private

  def set_user
    current_user = User.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:user_id,:comment)
  end
end
