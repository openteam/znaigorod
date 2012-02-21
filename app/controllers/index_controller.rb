class IndexController < ApplicationController

  def index
    @kinds = Kind.published.where(:institution_kind_id => params[:kind])
  end

end