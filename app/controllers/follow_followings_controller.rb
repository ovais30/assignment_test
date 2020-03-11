class FollowFollowingsController < ApplicationController
  
  def index
  end

  def create
    follow = FollowFollowing.find_by(follower_id: current_user.id, following_id: follow_params[:following_id],status: true)
    if follow.present?
        msg = "Already following"
        stts = true
    else
      follow = FollowFollowing.new
      follow.follower_id = current_user.id
      follow.following_id = follow_params[:following_id]
      follow.status = true
      follow.save
      msg = "Start following You"
      stts = true
    end
    render :status => 200,
           :json => {:success => stts,
                     :msg => msg
                     }
  end


  def follower_list
    # debugger
    follower = FollowFollowing.where("following_id=?", params[:user_id]).pluck(:follower_id)
    if follower.present?
      follower_list = User.select('id,email,full_name').where("id IN (?)", follower)
      stts = true
    else
      stts = false
      msg = "no data found"
      follower_list =[]
    end
    render :status => 200,
           :json => {:success => stts,
                     :msg => msg,
                     :follower_list => follower_list
                     }
  end


  def following_list
    following = FollowFollowing.where("follower_id=?", params[:user_id]).pluck(:following_id)
    if following.present?
      following_list = User.select('id,email,full_name').where("id IN (?)", following)
      stts = true
    else
      stts = false
      msg = "no data found"
      following_list =[]
    end
    render :status => 200,
           :json => {:success => stts,
                     :msg => msg,
                     :following_list => following_list
                     }
  end

  private

  

  def follow_params
    params.require(:follow).permit(:follower_id,:following_id,:status)
  end
end
