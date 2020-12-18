class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect "/recipes"
        end

        erb :'/users/signup'
    end

    post "/signup" do
        if logged_in?
            redirect "/recipes"
        end

        user = User.new(:email => params[:email], :password => params[:password])    
        if user.save
            session[:user_id] = user.id
            redirect "/recipes"
        else
            flash[:message] = "There was a problem. Please try again."
            redirect "/signup"
        end
    end

    get "/login" do
        if logged_in?
            redirect "/recipes"
        end

        erb :'/users/login'
    end
    
    post "/login" do
        if logged_in?
            redirect "/recipes"
        end
        
        user = User.find_by(:email => params[:email])
    
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/recipes"
        else
            flash[:message] = "There was a problem. Please try again."
            redirect "/login"
        end
    end

    get "/logout" do
        session.clear
        redirect "/login"
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'  
    end

end
