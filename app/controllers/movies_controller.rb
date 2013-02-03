class MoviesController < ApplicationController
 helper_method :sort_column, :sort_direction

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    query_base = Movie

    if !params[:ratings].nil?
      query_base = query_base.scoped(:conditions => { :rating => params[:ratings].keys })
    end

    if !params[:sort_order].nil?
      if 'by_title' == params[:sort_order]
        query_base = query_base.scoped(:order => :title)
      elsif 'by_release_date' == params[:sort_order]
        query_base = query_base.scoped(:order => :release_date)
      end
    end

    @movies = query_base.all

    @all_ratings = Movie.all_ratings

    if !params[:ratings].nil?
      @selected_ratings = params[:ratings]
    else
      @selected_ratings = {}
    end
  end
end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end


private

def sort_column
  Movie.column_names.include?(params[:sort]) ? params[:sort] : "rating"
end

def sort_direction 
  %w[asc].include?(params[:direction]) ? params[:direction] :"asc"
end