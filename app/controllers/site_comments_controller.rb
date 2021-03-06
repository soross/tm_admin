class SiteCommentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_site_comment, only: [:show, :edit, :update, :destroy]

  # GET /site_comments
  # GET /site_comments.json
  def index
    @site_comments = SiteComment.where("name <> '维斗喜帖'").order("updated_at DESC").page(params[:page] || 1)
  end

  # GET /site_comments/1
  # GET /site_comments/1.json
  def show
  end

  # GET /site_comments/new
  def new
    @site_comment = SiteComment.new
  end

  # GET /site_comments/1/edit
  def edit
  end

  # POST /site_comments
  # POST /site_comments.json
  def create
    @site_comment = SiteComment.new(site_comment_params)

    respond_to do |format|
      if @site_comment.save
        format.html { redirect_to @site_comment, notice: 'Site comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @site_comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @site_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_comments/1
  # PATCH/PUT /site_comments/1.json
  def update
    respond_to do |format|
      if @site_comment.update(site_comment_params)
        format.html { redirect_to site_comments_path, notice: 'Site comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_comments/1
  # DELETE /site_comments/1.json
  def destroy
    @site_comment.destroy
    respond_to do |format|
      format.html { redirect_to site_comments_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_comment
      @site_comment = SiteComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_comment_params
      params.require(:site_comment).permit(:user_id, :site_id, :template_page_id, :name, :mobile_phone, :tel_phone, :email, :qq, :weixin, :address, :gender, :birth, :hobby, :content, :content2, :content3, :status)
    end
end
