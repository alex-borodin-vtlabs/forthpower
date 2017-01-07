class AttachmentsController < ApplicationController
  before_action { |c| c.admin_auth 2 }
  #skip_before_filter :verify_authenticity_token  #open when skip csrf token verify
  def create
    @attachment = current_user.attachments.new
    @attachment.picture = params[:file]
    @attachment.save

    respond_to do |format|
        format.json { render :json => { status: 'OK', link: @attachment.picture.url}}
    end
  end

  private
    def attachment_params
      params.require(:attachment).permit(:picture)
    end
end
