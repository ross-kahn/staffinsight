class UsersController < ApplicationController
  def index
    @users = User.all
		authorize! :index, User
  end

  def show
    @user = User.find(params[:id])
		authorize! :read, @user
  end

  def new
    @user = User.new
		authorize! :create, User
  end

  def create
    @user = User.new(params[:user])
		authorize! :create, User
		
    if @user.save
      redirect_to new_profile_path(@user), :notice => "Successfully created user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
		authorize! :edit, @user
  end

  def update
    @user = User.find(params[:id])
		authorize! :edit, @user
		
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
		authorize! :destroy, @user
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end
end
