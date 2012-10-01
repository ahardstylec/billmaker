Billmaker.controllers :accounts do

  get :index do
    @accounts = Account.all
    render 'accounts/index'
  end

  get :new do
    @account = Account.new
    render 'accounts/new'
  end

  post :create do
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = 'Account was successfully created.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/new'
    end
  end

  get :edit, :with => :id do
    @account = Account.find(params[:id])
    render 'accounts/edit'
  end

  put :update, :with => :id do
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = 'Account was successfully updated.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/edit'
    end
  end

  get :edit_settings do
    @emailsetting = current_account.emailsetting || Emailsetting.new()
    render "accounts/edit_settings"
  end

  post :save_email_setting do
    @emailsetting = current_account.emailsetting || Emailsetting.create(account_id: current_account.id)
    if @emailsetting.update_attributes(params[:emailsetting])
      redirect url(:home, :index)
    else
      render "accounts/edit_settings"
    end
  end

  delete :destroy, :with => :id do
    account = Account.find(params[:id])
    if account != current_account && account.destroy
      flash[:notice] = 'Account was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Account!'
    end
    redirect url(:accounts, :index)
  end

  post "set_email_active" do
    @user = current_account
    ap params 
    @user.settings[:email_active] = "checked" == params[:checked] ? true : false
    if @user.save
      print "active mail saved"
    end
  end
end
