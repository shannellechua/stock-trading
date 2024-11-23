module Admin
  class UsersController < AdminController
    def index
      @users = User.all.order(id: :asc)
    end

    def show
      @user = User.find(params[:id])
      @transactions = @user.transactions;
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to admin_users_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        flash[:notice] = "The user has been edited!"
        redirect_to admin_user_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "The user has been removed from TraderBlue."
      redirect_to admin_users_path, status: :see_other
    end

    def pending
      @users = User.where(approved: false)
    end

    def approve
      @user = User.find(params[:id])

      if @user.update(approved: true)
        UserMailer.approve_email(@user).deliver_now
        flash[:notice] = "User has been approved to trade on TraderBlue."
      else
        flash[:alert] = "Failed to approve user."
      end
      redirect_to admin_users_path
    end

    def transactions
      @transactions = Transaction.all
    end

    private
      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :balance)
      end
  end
end