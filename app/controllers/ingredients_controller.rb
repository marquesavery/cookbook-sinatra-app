class IngredientsController < ApplicationController
    get '/ingredients' do 
        if !logged_in?
            redirect "/login"
        end

        erb :'/ingredients/index'
    end
    
    get '/ingredients/new' do
        erb :'/ingredients/new'
    end
    
    post '/ingredients' do
        if Ingredient.find_by_name(params[:name])  
            flash[:message] = "That ingredient already exists. Please add a new Ingredient."
            redirect to "/ingredients/new"
        else
            @ingredient = Landmark.create(params[:landmark])
            @ingredient.save
            redirect to "/ingredients"
        end
    end

    delete '/ingredients/:id/delete' do
        if logged_in?
            @ingredient = Ingredient.find_by_id(params[:id])
            if @ingredient && @ingredient.user == current_user
                @ingredient.delete
            else
                flash[:message] = "Only the creator of the ingredient can delete it."
            end
            redirect '/ingredients'
        else
            redirect '/login'
        end
    end

end