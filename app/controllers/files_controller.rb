class FilesController < ApplicationController
  before_action :require_signin!

  def new
    @ticket = Ticket.new
    asset = @ticket.assets.build
    render partial: "files/form",
           locals: { number: params[:number].to_i, asset: asset }
  end

  def show
    asset = Asset.find(params[:id])
    if can?(:view, asset.ticket.project)
      # first argument is the path of the file we're sending
      # second argument is an option hash used to pass filename and content type options so the browser receiving file knows what to call it and the type of file
      send_file asset.asset.path,
                filename: asset.asset_identifier,
                content_type: asset.content_type
    else
      flash[:alert] = "The asset you were looking for could not be found."
      redirect_to root_path
    end
  end
end
