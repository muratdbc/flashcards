require 'securerandom'

get '/' do
  @decks=Deck.all
  erb :home
end

get'/game/:id' do
  if session[:value]
    @id=params[:id]
    erb :game
  else
    redirect to ('/login')
  end
end

post '/questions' do
  if session[:value]
    puts params[:deck].to_i
    Deck.find(params[:deck].to_i).cards.to_a.shuffle
  else
    redirect to('/login')
  end
end

#-------SESSIONS--------------------

get '/login' do
  erb :sign_in
end

post '/login' do
  # sign-in
  @user=User.find(params[:username])
  if @user.password == params[:password]
    #set the session
    session[:user_id] = @user.id
    redirect '/'
  else
    #go back to signin
    redirect '/login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end
#----------- USERS -----------

get '/users/new' do
  @user = User.new
  erb :sign_up
end

post '/users' do
  username = params["username"]
  password = params["password"]
  @user = User.new
  # if @user.register(username, password)
  if username #comment this out later
    session[:username] = @user.username
    redirect  '/'
  else
    @errors = @user.errors
    erb :sign_up
  end
end

