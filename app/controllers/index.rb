# HOME PAGE (LOG-IN / REGISTER)
get '/' do
  if logged_in?
    redirect "/users/#{current_user.id}/notes"
  else
    erb :index
  end
end

#----------- LOGIN SUBMISSION -----------

post '/login' do
  user = User.where(email: params[:email]).first
  if user && user.password == params[:password]
    login(user)
    redirect "/users/#{user.id}/notes"
  else
    @login_failed = true
    erb :index
  end
end

#----------- REGISTER SUBMISSION -----------
post '/register' do
  @user = User.new(
    name: params[:name].presence,
    email: params[:email].presence,
    password: params[:password].presence,
  )
  if @user
    @user.save
    login(@user)
    redirect "/users/#{@user.id}/notes"
  else
    @signup_failed = true
    status 400
    erb :index
  end
end

delete '/logout' do
  logout!
  redirect '/'
end

get '/users/:id/notes' do |id|
  redirect '/' if current_user.nil?
  @user = User.find(id)
  erb :"todos/index"
end
#----------- CREATE TODOS ---------
post '/notes' do

  @note = Note.new(content: params[:content])
  current_user.notes << @note
  if @note.save
    return @note.to_json
  else
    status 404
    "FUCK YOU NAM"
  end
end

# #----------- EDIT TODOS -----------
put '/edit/:id' do
  @note = Note.where(id: params[:id]).first
  @note.content = params[:content]
  @note.save
  redirect "/users/#{current_user.id}/notes"
end

delete '/delete/:id' do
  note = Note.where(id: params[:id]).first
  note.destroy
  redirect "/"
end
