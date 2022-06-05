class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    @categories = Category.all

    if params[:min_stars]
      @libraries = @libraries.where(stars: (params[:min_stars]..@libraries.max(:stars)))
    end

    @libraries = @libraries.group_by{ |lib| lib.category }

  end
end
