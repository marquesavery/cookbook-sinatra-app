class IngredientsController < ApplicationController
    get '/ingredients' do 
        if !logged_in?
            redirect "/login"
        end

        erb :'/ingredients/index'
    end
    
    get '/ingredients/new' do
        if !logged_in?
            redirect '/login'
        end

        erb :'/ingredients/new'
    end

    get '/ingredients/:slug' do
        if !logged_in?
            redirect '/login'
        end

        @ingredient = Ingredient.find_by_slug(params[:slug])
        erb :'/ingredients/show'
    end
    
    post '/ingredients' do
        if Ingredient.find_by_name(params[:ingredient].downcase)  
            flash[:message] = "That ingredient already exists. Please add a new Ingredient."
            redirect to "/ingredients/new"
        else
            @ingredient = Ingredient.create(:name => params[:ingredient].downcase, :user_id => current_user.id)
            redirect to "/ingredients"
        end
    end

    get '/ingredients/:slug/edit' do
        if logged_in?
            @ingredient = Ingredient.find_by_slug(params[:slug])
            erb :'/ingredients/edit'
        else
            redirect '/login'
        end
    end

    patch '/ingredients/:slug' do
        if logged_in?
            @ingredient = Ingredient.find_by_slug(params[:slug])
            if @ingredient && @ingredient.user == current_user
                @ingredient.update(name: params[:ingredient])
                redirect "/ingredients/#{@ingredient.slug}"
            end
        else
            redirect '/login'
        end
    end

    delete '/ingredients/:slug/delete' do
        if logged_in?
            @ingredient = Ingredient.find_by_slug(params[:slug])
            if @ingredient && @ingredient.user == current_user
                @ingredient.destroy
                redirect '/ingredients'
            else
                flash[:message] = "To delete the ingredient you need to be the creator"
                redirect "/ingredients/#{@ingredient.slug}"
            end
        else
            redirect '/login'
        end
    end

end