class ProductsController < ApplicationController
    before_action :require_user_logged_in!
    before_action :check_role, only: [:new, :my_products]
    def index
        # @products = Product.all.order(:created_at)
        # @product = Product.new
        @products = Product.includes(:biddings).all.order(:created_at)
        @updated_product = flash[:updated_product]
        @products.each do |product|
            if product.bidding_expiration < Time.current
              product.update(bidding_allowed: false)
            end
        end
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        if @product.save 
            redirect_to products_path, notice: 'Product has been created successfully.'
        else
            render :new, status: 422
        end
    end

    def show
        @product = Product.find(params[:id])
        @product = Product.includes(biddings: :user).find(params[:id])
    end


    def my_products
        @user = Current.user
        @products = @user.products.includes(:biddings)
    end


    def select_winner
        @product = Product.find(params[:id])
    
        if @product.update(bidding_allowed: false)
          redirect_to request.referer, notice: "Bidding Ended Successfully."
        else
          render :select_winner
        end
    end
    





def edit 
    @product = Product.find(params[:id])
    if @product && @product.user != Current.user
      redirect_to products_path, notice: 'unauthorized access!'
    end
end

def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
        redirect_to products_path, notice: 'Product has been updated successfully.'
    else
        render :edit, status: 422
    end
end

def destroy
    if @product.user != Current.user
        redirect_to products_path, notice: 'unauthorized access!'
    else @product.destroy
        redirect_to products_path, notice: 'Product has been deleted successfully.'
    end
end

def stop_bidding
    @product = Product.find(params[:id])
    @product.update(bidding_allowed: false)
    redirect_to products_path, notice: "Bidding has been stopped for this product."
end




private

    def product_params
        params.require(:product).permit(:name, :description, :lowest_allowable_bid, :starting_bid_price, :current_lowest_bid, :bidding_expiration, :image, :user_id, :bidding_allowed)
    end

    # def set_micropost
    #     @product = Product.find(params[:id])
    # end

    def check_role
        unless Current.user&.auctioneer?
          redirect_to products_path, alert: "You are not authorized to access this page."
        end
      end


end
