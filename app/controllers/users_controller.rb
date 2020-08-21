class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect to "/users/#{current_user.id}"
    else
      erb :'/users/new'
    end
  end

post '/signup' do
    is_admin = params[:email_address].include?("@chp.com") ? true : false
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email_address: params[:email_address], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to "/users/#{@user.id}"
    else
      redirect to '/signup'
    end
end

  get '/login' do
    if logged_in?
      redirect to "/users/#{current_user.id}"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(email_address: params[:email_address], password: params[:password])
    if !@user.nil?
     session[:user_id] = @user.id
     redirect to '/'
    else
     redirect to '/login'
    end
  end



  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    if logged_in? && @user == current_user
      erb :'/users/account'
    else
      redirect to '/login'
    end
  end

  get '/users/:id/edit' do
    @user = User.find_by_id(params[:id])
    if logged_in? && @user == current_user
      erb :'/users/edit'
    else
      redirect to '/login'
    end
  end

  patch '/users/:id' do
    @user = User.find_by_id(params[:id])
    @user.email_address = params[:email_address]
    @user.password = params[:password]
    if logged_in? && @user == current_user && @user.valid?
      @user.save
      redirect to "/users/#{@user.id}"
    else
      redirect to '/login'
    end
  end

  get '/logout' do
   if logged_in?
     session.clear
     redirect to '/'
   else
     redirect to '/'
   end
 end

 delete '/reservations/:id' do
    @user = User.find_by_id(params[:id])
    if logged_in? && @user == current_user
      @user.reservations.each do |reservation|
        reservation.delete
      end
      @user.delete
      session.clear
      redirect to '/'
    else
      redirect to '/login'
    end
 end

end