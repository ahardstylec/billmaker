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

	put :update, map: "clients/update/:id" do
		puts params
		@client = Client.find(params[:id])
		 if @client.update_attributes(params[:client])
		 	redirect "clients/"
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

	post :change_current_client do 
		user_clients = current_account.clients
		user_clients.each{|c| c.set(status: false)}
		current_account.clients.find(params[:client]).set(status: true)
		""
	end

end