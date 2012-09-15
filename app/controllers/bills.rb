Billmaker.controllers :bills do
	
	get :index do 
		
		@clients = current_account.clients
		@client = current_account.current_client
		@bills = @client.bills
		
		render "bills/index"
	end

	get :edit, map: "bills/edit/:id" do
		@bill = Bill.find(params[:id])
		render "bills/edit"
	end

	get :show, map: "bills/show/:id" do

	end

	post :destroy, map: "bills/destroy" do 
		@bill = Bill.find(params[:id])
		@client = current_account.clients.where(status: true).first
		@bills = @client.bills
		@bill.destroy
		render "bills/index"
	end

	post :create do
	end

	put :update do
	end

	post :start_work, provides: [:html, :js] do
		@worksession = WorkSession.new(start: Time.now, active: true)
		@client = current_account.current_client
		@bill = @client.current_bill
		if @bill
			if @bill.date.mon == Time.now().mon && @bill.date.year == Time.now().year
				@bill.work_sessions.where(active: true).each{ |ws| ws.set(active: false)}
			else
				@bill = Bill.new(date: Time.new)
				@client.bills << @bill
			end
		else
			@bill = Bill.new(date: Time.new)
			@bill.save
			@client.bills << @bill
			@bill.save
		end	
		@worksession.bill = @bill
		@worksession.save
		render "bills/start_work", layout: false
	end

	post :end_work, provides: [:html, :js] do
		@client = current_account.current_client
		@bill = @client.current_bill
		if @bill
			@worksession = @bill.current_session
			if @worksession
				@worksession.active = false
				@worksession.ende = Time.now
				profit = ((Time.now - @worksession.start)/3600)*@worksession.bill.client.pay
				@worksession.profit = profit
				@worksession.bill.add_profit profit.round(2)
				@worksession.save
			end
		end
	end

	get :get_session_start, provides: [:json] do
		@client = current_account.current_client
		@start = @client.session_start
		render "bills/get_session_start"
	end

	put :end_work_handler, map: "/bills/end_work_handler/:id" do
		@worksession = WorkSession.find(params[:id])

	end

end