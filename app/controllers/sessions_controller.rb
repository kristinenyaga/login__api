class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if(user&.authenticate(params[:password]))
        session[:user_id] = user.id
        render json: user, status: :created
    else
        render json: {errors: ["invalid password or email"]}, status: :unauthorized
    end
end

def destroy
    if(session.include? :user_id)
        session.delete :user_id
        head :no_content
    else
        render json: {errors: ["you are not logged in"]}, status: :unauthorized
    end
end


end