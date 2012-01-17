class GooglePostsController < ApplicationController

  layout 'admin'
  
  # GET /google_posts
  # GET /google_posts.json
  def index
    @google_posts = GooglePost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @google_posts }
    end
  end

  # GET /google_posts/1
  # GET /google_posts/1.json
  def show
    @google_post = GooglePost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @google_post }
    end
  end

  # GET /google_posts/new
  # GET /google_posts/new.json
  def new
    @google_post = GooglePost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @google_post }
    end
  end

  # GET /google_posts/1/edit
  def edit
    @google_post = GooglePost.find(params[:id])
  end

  # POST /google_posts
  # POST /google_posts.json
  def create
    @google_post = GooglePost.new(params[:google_post])

    respond_to do |format|
      if @google_post.save
        format.html { redirect_to google_posts_url, notice: 'Google post was successfully created.' }
        format.json { render json: @google_post, status: :created, location: @google_post }
      else
        format.html { render action: "new" }
        format.json { render json: @google_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /google_posts/1
  # PUT /google_posts/1.json
  def update
    @google_post = GooglePost.find(params[:id])

    respond_to do |format|
      if @google_post.update_attributes(params[:google_post])
        format.html { redirect_to google_posts_url, notice: 'Google post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @google_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /google_posts/1
  # DELETE /google_posts/1.json
  def destroy
    @google_post = GooglePost.find(params[:id])
    @google_post.destroy

    respond_to do |format|
      format.html { redirect_to google_posts_url }
      format.json { head :ok }
    end
  end
end
