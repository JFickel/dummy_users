get '/' do
  erb :index
end

#secret page
post '/secret' do
  if User.authenticate(params[:user][:email],params[:user][:password])
    session[:logged_in] = true
    erb :secret
  else
    redirect '/'
  end
end

get '/secret' do
  if session[:logged_in] 
    erb :secret
  end
end

#logout
get '/logout' do
  session.clear
  redirect '/'
end

#new user
post '/new_user' do
  # params == {user: {name: "john", email: "john@aol.com", 
  #   password: 'secret', password_confirmation: 'secret'}}
  user = User.new(name: params[:user][:name], email: params[:user][:email])
  user.encrypted_password = user.secure_hash(params[:user][:password])
  user.encrypted_password_confirmation = user.secure_hash(params[:user][:password_confirmation])
  if user.save
    session[:logged_in] = true
    redirect "/secret"
  else
    session[:signup_errors] = user.errors
    redirect '/'
  end
end
