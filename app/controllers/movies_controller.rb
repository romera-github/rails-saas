class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    
    @orden = _get_sort_order
    @ratings_tabla = _get_selected_ratings
    @redirige = false
    

    if @redirige
      puts 'redirect req'

      if !@orden.nil? && !@ratings_tabla.nil?
        
        redirect_to movies_path(:orden => @orden, :ratings => @ratings_tabla)
        
      elsif !@orden.nil? && @ratings_tabla.nil?
        
        redirect_to movies_path(:orden => @orden)
        
      else

        redirect_to movies_path(:ratings => @ratings_tabla)
      end
      
      return
    end
	
    if !@ratings_tabla.nil?
      
      @selected_ratings = @ratings_tabla.keys
      
    end

	
    filters = Hash.new
    
    if !@selected_ratings.nil?
      
      filters[:ratings] = @selected_ratings
      
    end
    
    if !@orden.nil?
      
      filters[:order] = @orden
      
    end

    if filters.empty?
      
      @movies = Movie.all
      
    else
      if !filters[:order].nil?
        if filters[:ratings].nil?
          @movies = Movie.find(:all, :order => filters[:order])
        else
          @movies = Movie.find(:all, :order => filters[:order], :conditions => { :rating => filters[:ratings] })
        end
      else
        if filters[:ratings].nil?
          @movies = Movie.all
        else
          @movies = Movie.find(:all, :conditions => { :rating => filters[:ratings] })
        end
      end
    end

    #Store our sort order and ratings checkboxes in session data.
    if !@orden.nil?
      session[:orden] = @orden
    end
    if !@ratings_hash.nil?
      session[:ratings] = @ratings_hash
    end

  end

  #Get our sort_order. Use value from params if !nil, otherwise attempt to use session data.
  def _get_sort_order
    if !params[:orden].nil?
      return params[:orden]    
    end
    if !session[:orden].nil?
      @redirect_required = true
      order = session[:orden]
      session.delete(:orden)
      order
    end
  end

  #Get our selected_ratings. Use value from params if !nil, otherwise attempt to use session data.
  def _get_selected_ratings
    if !params[:ratings].nil?
      return params[:ratings]
    end
    if !session[:ratings].nil?
      @redirect_required = true
      ratings = session[:ratings]
      session.delete(:ratings)
      ratings
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

end
