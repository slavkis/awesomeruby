class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    @categories = Category.all

    if params[:min_stars]
      @libraries = @libraries.where(stars: (params[:min_stars].to_i..@libraries.maximum(:stars)))
    end

    @libraries = @libraries.group_by{ |lib| lib.category }

  end
end
