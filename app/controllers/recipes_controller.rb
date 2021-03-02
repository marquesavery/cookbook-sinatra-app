class RecipesController < ApplicationController

    get '/recipes' do
        if !logged_in?
            redirect "/login"
        end

        @user = User.find(session[:user_id])
        erb :"/recipes/index"
    end

    post '/recipes' do
        @recipe = Recipe.create(params[:recipe])
        @recipe.user_id = current_user.id
        params[:ingredients].each do |ingredient|
            @recipe.ingredients << Ingredient.find_by_id(ingredient)
        end

        @recipe.save

        redirect '/recipes'
    end

    get '/recipes/new' do
        if !logged_in?
            redirect '/login'
        end
        erb :'/recipes/new'
    end

    get '/recipes/:slug' do
        if !logged_in?
            redirect '/login'
        end

        @recipe = Recipe.find_by_slug(params[:slug])
        erb :'/recipes/show'
    end

    get '/recipes/:slug/edit' do
        if logged_in?
            @recipe = Recipe.find_by_slug(params[:slug])
            if @recipe && @recipe.user == current_user
                erb :'/recipes/edit'
            else
                redirect '/recipes'
            end
        else
            redirect '/login'
        end
    end

    patch '/recipes/:slug' do
        if logged_in?
            @recipe = Recipe.find_by_slug(params[:slug])
            @recipe.update(params[:recipe])
            @recipe.ingredients.destroy_all
            params[:ingredients].each do |ingredient|
                @recipe.ingredients << Ingredient.find_by_id(ingredient)
            end
            @recipe.save
            redirect "/recipes/#{@recipe.slug}"
        else
            redirect '/login'
        end
    end

    delete '/recipes/:slug/delete' do
        if logged_in?
            @recipe = Recipe.find_by_slug(params[:slug])
            if @recipe && @recipe.user == current_user
                @recipe.destroy
            end
            redirect '/recipes'
        else
            redirect '/login'
        end
    end

end
