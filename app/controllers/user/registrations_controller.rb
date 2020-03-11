class User::RegistrationsController < Devise::RegistrationsController
    prepend_before_action :require_no_authentication, only: [:cancel ] 
    skip_before_action :verify_authenticity_token 
    
    def create
        debugger
        user = User.find_by("email=?", user_params[:email])
        if user.present?
            render :status => 200,
                   :json => {:success => true,
                             :msg => "User Alrady Exist",
                             :user => user
               }
        else
        #    user =  User.create(user_params)
            user =  User.new
            user.email = user_params[:email]
            user.password = user_params[:password]
            user.first_name = user_params[:first_name]
            user.last_name = user_params[:last_name]
            user.full_name = "#{user_params[:first_name] }"+ "#{user_params[:last_name] }"
            user.location = user_params[:location]
            user.confirmed_at = DateTime.now
           if user.save
                if user.confirmed_at.present?
                render :status => 200,
                       :json => {:success => true,
                                  :msg => "Signed up successfully",
                                    # :msg => t('devise.cardex.Signed_up'),
                                    :user => user
                        }
                else
                render :status => 200,
                        :json => {:success => true,
                                    :msg => "You have to confirm your email address before continuing"
                                    # :user => @user
                        }
                end
           else
             render :status => 200,
                    :json => {:success => false,
                              :msg => user.errors.full_messages[0]
                    }
           end  
        end
    end

    private

    def user_params
        params.require(:user).permit(:email,:password,:first_name,:last_name,:full_name,:location,:latitude,:longitude)
    end
end
