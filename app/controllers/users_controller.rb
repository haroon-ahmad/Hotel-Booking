class UsersController < ApplicationController
	#before_filter :authorize, :except => [:new]
  def user_params
      params.require(:user).permit(:name,:phonenumber,:email,:password,:password_confirmation,:image)
    end

    def new
    	@user=User.new
    end

    def create
    	@user=User.new(user_params)
      if @user.name!=""
    	 if @user.save
    		  session[:user_id] =@user.id
    		  redirect_to root_url
    	 else
    	   render "new",:notice=>"error in form"
    	 end
      end
    end

  def edit
  	 @user=User.find(params[:id])
  end

   def show

      @user=User.find(params[:id])
    end

    def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path, :notice=> "user has been updated"
    else
      render "edit"
    end
  end
end
