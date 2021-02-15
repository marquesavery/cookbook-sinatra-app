class RecipesController < ApplicationController

    get '/recipes' do
        if !logged_in?
            redirect "/login"
        end

        @user = User.find(session[:user_id])
        erb :"/recipes/index"
    end

    post '/recipes' do
        @user = current_user
        if params[:instructions] == ""
            flash[:message] = "Instructions required."
            redirect '/recipes/new'
        else
            @recipe = Recipe.create(:instructions => params[:instructions], :user_id => @user.id)
            redirect '/recipes'
        end
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
            @recipe = Recipe.find_by_id(params[:id])
            if @recipe && @recipe.user == current_user
                erb :'/recipes/edit'
            else
                redirect '/recipes'
            end
        else
            redirect '/login'
        end
    end

    patch '/recipes/:id' do
        if logged_in?
            if params[:content] == ""
                redirect "/recipes/#{params[:id]}/edit"
            else 
                @recipe = Recipe.find_by_id(params[:id])
                if @recipe && @recipe.user == current_user
                    if @recipe.update(instructions: params[:instructions])
                        redirect "/recipes/#{@recipe.slug}"
                    else
                        redirect "/recipes/#{@recipe.slug}/edit"
                    end
                    redirect '/recipes'
                end
            end
        else
            redirect '/login'
        end
    end

    delete '/recipes/:id/delete' do
        if logged_in?
            @recipe = Recipe.find_by_id(params[:id])
            if @recipe && @recipe.user == current_user
                @recipe.delete
            end
            redirect '/recipes'
        else
            redirect '/login'
        end
    end

end
