Billmaker.controllers :home do
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

  get :index, map: "/" do
    @client = current_account.clients.where(status: true).first || current_account.clients.first
    @bill = @client.bills.sort("date.desc").first if @client
    if @bill
      @work_sessions = @bill.work_sessions
      @activesession = @bill.current_session
    end
    render "home/index"
  end
  
end