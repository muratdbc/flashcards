require 'securerandom'

get '/' do
  @decks=Deck.all
  erb :home
end

get'/question/:id' do
  @deck = Deck.find(params[:id].to_i)
  @current_card = @deck.cards.to_a.pop
  @right_answer = @current_card.answer

  @options = []
  3.times do
    @options << Card.all.sample.answer
  end

  @options << @right_answer

  erb :qu_home
end

post '/question/:id' do
 @question = Card.find(params[:id]).questions
 # @answer =
 erb :qu_answer
end

#-------SESSIONS--------------------

get '/login' do
  erb :sign_in
end

post '/login' do
  # sign-in

  @user=User.new
  user_logging=@user.authenticate(params[:username],params[:password])
  if user_logging
    session[:username] = user_logging.username
    redirect '/'
  else
    #go back to signin
    redirect '/login'
  end
end

get '/logout' do
  session[:username] = nil
  redirect to '/'
end
#----------- USERS -----------

get '/users/new' do
  # @user = User.new
  erb :sign_up
end

post '/users' do
  username = params["username"]
  password = params["password"]
  @user = User.new
  new_user=@user.register(username, password)
  if new_user
  #if username #comment this out later
    session[:username] = new_user.username
    redirect  '/'
  else
    @errors = @user.errors
    erb :sign_up
  end
end

