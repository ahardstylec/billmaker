Billmaker.controllers :login do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end


  # GET /login/new
  get :new do
    render "/login/new", layout: "application_login"
  end

  # POST /login/create
  post :create do
    if account = Account.authenticate(params[:email], params[:password])
      set_current_account(account)
      if account.role == "admin"
        redirect url(:base, :index)
      else
        redirect url(:home, :index)
      end
    else
      params[:email], params[:password] = h(params[:email]), h(params[:password])
      flash[:warning] = "Login or password wrong."
      redirect url(:login, :new)
    end
  end

  # DELETE /login/destroy
  delete :destroy do 
    set_current_account(nil)
    redirect url(:login, :new)
  end
  
end
