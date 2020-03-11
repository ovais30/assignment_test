class User::SessionsController < Devise::SessionsController
    respond_to :json

    
    def create
        if !params[:user][:email].present? || !params[:user][:password].present?
          sucs = false
          stts = ''
          msg = "Email and Password can not be blank."
        else
          resource = User.find_by(email: params[:user][:email])
          if resource.present?
           # if resource.confirmed_at.present?      
              if resource.confirmed?
                if resource.valid_password?(params[:user][:password])
                #   if resource.is_active
                        # warden.authenticate!(auth_options)
                        sign_in(resource)
                        cookies.signed[:user_id] = {value: resource.id, expiry: Time.now + 1.day }
                        # update_Login_user(resource.id,request.headers["HTTP_DEVICE_TOKEN"],request.headers["HTTP_DEVICE_TYPE"])
                        stts = ''
                        sucs = true
                        # debugger
                        msg = 'Logged In Successfully.'
                #   else
                #    stts = ''
                #    sucs = false
                #    msg = 'You are not an active user. Please contact to admin.'
                #   end
                else
                 stts = ''
                 sucs = false
                  msg = 'Invalid email or password.'
                end
              else
               stts = 'unauthorized'
               sucs = false
               # msg = 'An Email has been sent to your Email-ID. Please confirm to continue.'
               msg = t('devise.cardex.An_Email_has_been_sent_to_your_email')    
              end
            # else
            #   sucs = false
            #   msg = 'An Email has been sent to your Email-ID. Please confirm to continue.'
            # end
          else
            sucs = false
            msg = 'User does not Exist.'
            # msg = t('devise.cardex.user_does_not_exist')
          end
        end    
        render :status => 200,
               :json => {:success => true,
                         :msg => msg,
                         :user => resource
                        }
    end

end
