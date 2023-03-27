class BiddingsController < ApplicationController
        def index
            @product = Product.find(params[:product_id])            # @biddings = @product.biddings
            # if session[:user_id]
            #     @user = User.find(session[:user_id])
            # end
        end


        def new
            @product = Product.find(params[:product_id])
            @bidding = Bidding.new
        end

        def create
            puts "create action called"
            @product = Product.find(params[:product_id])
            @bidding = Bidding.new(bidding_params)
            if @bidding.save
              @product.update_current_lowest_bid(@bidding.bid_amount)
              redirect_to products_path, notice: 'Bid was successfully placed.'
            else
              render :new, status: 422
            end
          end



    
    def show 
    end
    
    # def edit 
    #     if @product.user != Current.user
    #         redirect_to products_path, notice: 'unauthorized access!'
    #      end
    # end
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
    
        def bidding_params
            params.require(:bidding).permit(:user_id, :product_id, :bid_amount)
        end
          
        # def bidding_params
        #     params.require(:bidding).permit(:bid_amount).merge(product_id: params[:product_id], user_id: current_user.id)
        #   end

        def set_micropost
            @product = Product.find(params[:id])
        end
   
    
end
