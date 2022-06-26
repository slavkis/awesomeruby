class LibrariesController < ApplicationController
  def index
    @libraries = Library.all

    if params[:min_stars]
      @libraries = @libraries.where("libraries.stars >= ?", params[:min_stars] || 0 )
    end

    @libraries = @libraries.includes(:category).group_by{ |lib| lib.category }
  end
end
