class ListingsController < ApplicationController
  #before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # search results
  def search_results
    @query = params[:query]
    if @query
      @listings = Listing.basic_search(@query)
    else
      @listings = Listing.all
    end
    render :layout => false
  end
  
  # favorite/unfavorite listing
  def fav_listing
    @add_fav = params[:add_fav]
    @listing = Listing.find(params[:listing_id])
    @listing.favorite(current_user)
    @favorites = current_user.favorites
    render :layout => false
  end

  # GET /listings
  # GET /listings.json
  def index
    @favorites = current_user.favorites
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
    render :layout => false
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @listing }
      else
        format.html { render action: 'new' }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :time, :location, :body, :category)
    end
end
