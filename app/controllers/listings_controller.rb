require 'textacular/tasks'

class ListingsController < ApplicationController
  #before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @fav_listings = current_user.listings
    @listings = Listing.order(updated_at: :desc)
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @month_listings = Listing.where('extract(month from updated_at) = ? AND extract(year from updated_at) = ?', 
      @date.month, @date.year).order(start_time: :asc)
    @month_listings = @month_listings.where.not(start_time: nil)
    @categories = ['Event', '', '', '']
  end
  
  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
    @favorite = current_user.favorites.find_by_listing_id(params[:id])
    if @favorite != nil
      @favorite.mark_read
    end
    render :layout => false
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
  
  # search results
  def search_results
    @listings = current_user.query_listings(params[:category], params[:query])
    render :layout => false
  end
  
  # favorite/unfavorite listing
  def favorites
    current_user.favorite(Listing.find(params[:listing_id]))
    @fav_listings = current_user.listings
    render :layout => false
  end
  
  def cal
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @month_listings = Listing.where('extract(month from updated_at) = ? AND extract(year from updated_at) = ?', 
      @date.month, @date.year).order(start_time: :asc)
    @month_listings = @month_listings.where.not(start_time: nil)
    render :layout => false
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
