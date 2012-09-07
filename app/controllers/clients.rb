Billmaker.controllers :clients do
	
	get :index do
		@clients = current_account.clients
		render "clients/index"
	end

	get :show, map: "client/:id" do
	end

	get :new do
		@client = Client.new
		render "clients/new"
	end

	post :create do
		@client = Client.new(params[:client])

		if @client.save
			current_account.clients << @client
			flash[:notice] = "client successfully created"
			redirect url(:clients, :index)
		else
			flash[:error] = "client could not be created"
			render "clients/new"
		end
	end

	get :edit, map: "clients/edit/:id" do
		@client = Client.find(params[:id])
		render "clients/edit"
	end

	put :update do 
		@client = Client.find(params[:id])
		 if @client.update_attributes[params[:client]]
		 	@clients = current_account.clients
		 	render "clients/index"
		 else
		 	render "clients/edit"
		 end
	end

	delete :destroy do 
		@client = Client.find params[:id]
		if @client.destroy
			@clients = current_account.clients
			render "clients/index"
		end
	end

	get :new_account_client do 
		@client = Client.new
		render "clients/new_account_client"
	end

	post :create_client_for_user do
		@client = Client.new(params[:client])

		if @client.save
			current_account.clients << @client
			flash[:notice] = "client successfully created"
			redirect url(:clients, :index)
		else
			flash[:error] = "client could not be created"
			render "clients/new"
		end
	end

	post :start_work, provides: [:html, :js] do
		@worksession = WorkSession.new(start: Time.now, active: true)
		@client = Client.find(params[:client])
		@client.work_sessions.where(active: true).each{ |ws| 
			ws.set(active: false)
		}
		@worksession.client = @client
		@worksession.save
		render "clients/start_work", layout: false
		#render "clients/start_work"
	end

	post :end_work, provides: [:html, :js] do
		@worksession = WorkSession.find(params[:id])
		@worksession.active = false
		@worksession.ende = Time.now
		@worksession.profit = ((@worksession.ende-@worksession.start)/3600)*@worksession.client.pay
		@worksession.save
		#render "clients/end_work"
	end

	post :change_current_client do 
		user_clients = current_account.clients
		user_clients.each{|c| c.set(status: false)}
		current_account.clients.find(params[:client]).set(status: true)
		""
	end

	get :get_session_start, provides: [:json] do
		@client = current_account.current_client
		@start = @client.session_start
		render "clients/get_session_start"
	end

end