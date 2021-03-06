class AccountController < ApplicationController
  layout  'scaffold'

  def login
    case @request.method
      when :post
      if @session[:user] = User.authenticate(@params[:user_login], @params[:user_password])

        flash['notice']  = "Login successful"
        redirect_back_or_default params[:return_to]
      else
        flash.now['notice']  = "Login unsuccessful"

        @login = @params[:user_login]
      end
    end
  end
  
  def logout
    @session[:user] = nil
  end
    
  def welcome
  end
  
end
