class SessionsController < ApplicationController
  def index
  end

  def new
    unless params[:email].blank?
      user = User.find_by(email: params[:email].downcase)
      unless user.nil?
        render json: {error: 'Email already exists'}
        return
      end

      if params[:pass] == params[:pass2]
        user = User.new(name: params[:name], email: params[:email].downcase, password: params[:pass])
        user.save!
        sign_in user
        render json: {url: url_for(controller: "main", action: "index")}
      else
        render json: {error: 'Password not same'}
      end
    end
  end

  def create
    unless params[:email].blank?
      begin
        user = User.find_by!(email: params[:email].downcase)
        if user && user.authenticate(params[:pass])
          sign_in user
          render json: {url: url_for(controller: "main", action: "index")}
        else
          render json: {error: 'Login failed. Invalid email/password combination. Repeat'}
        end
      rescue ActiveRecord::RecordNotFound
        render json: {error: 'Login failed. Invalid email/password combination. Repeat'}
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end